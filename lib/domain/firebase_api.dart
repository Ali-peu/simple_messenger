import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:simple_messenger/data/models/app_user.dart';
import 'package:simple_messenger/data/models/chat_message.dart';

class FirebaseApi {
  static FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  static User get user => firebaseAuth.currentUser!;
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<bool> googleSign() async {
    try {
      final googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        return false;
      }

      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await firebaseAuth.signInWithCredential(credential);
      if (!(await userExists())) {
        final result = await createUser();

        return result;
      } else {
        return false;
      }
    } on Exception catch (e) {
      if (kDebugMode) {
        log(e.toString(), name: 'Error: ');
      }
      return false;
    }
  }

  bool checkUser() {
    if (firebaseAuth.currentUser == null) {
      return false;
    } else {
      return true;
    }
  }

  static String getConversationID(String id) => user.uid.hashCode <= id.hashCode
      ? '${user.uid}_$id'
      : '${id}_${user.uid}';

  Future<bool> createUser() async {
    try {
      final appUser = AppUser(
          uid: user.uid,
          name: user.displayName.toString(),
          userEmail: user.email.toString(),
          isOnline: false,
          lastActive: DateTime.now());

      await firestore.collection('users').doc(user.uid).set(appUser.toJson());
      return true;
    } on Exception catch (e) {
      if (kDebugMode) {
        log(e.toString(), name: 'Error: ');
      }
      return false;
    }
  }

  Future<void> sendMessage(AppUser appUser, String message) async {
    final time = DateTime.now().millisecondsSinceEpoch.toString();

    final messageForUser = ChatMessage(
        toId: appUser.uid,
        message: message,
        read: '',
        fromId: user.uid,
        sent: time);

    log(messageForUser.toString(), name: 'Namae :');
    final ref = firestore
        .collection('chats/${getConversationID(appUser.uid)}/messages/');
    await ref.doc(time).set(messageForUser.toJson());
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getAllMessages(AppUser user) {
    return firestore
        .collection('chats/${getConversationID(user.uid)}/messages/')
        .orderBy('sent', descending: true)
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getLastMessage(AppUser user) {
    return firestore
        .collection('chats/${getConversationID(user.uid)}/messages/')
        .orderBy('sent', descending: true)
        .limit(1).snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getAllUsers(
      List<String> userIds) {
    log('\nUserIds: $userIds');

    return firestore
        .collection('users')
        .where('uid',
            whereIn: userIds.isEmpty
                ? ['']
                : userIds) //because empty list throws an error
        // .where('id', isNotEqualTo: user.uid)
        .snapshots();
  }

  Future<void> signOut() async {
    await firebaseAuth.signOut();
    await GoogleSignIn().signOut();
  }

  Future<bool> userExists() async {
    return (await firestore.collection('users').doc(user.uid).get()).exists;
  }

  Future<bool> addChatUser(String email) async {
    final data = await firestore
        .collection('users')
        .where('userEmail', isEqualTo: email)
        .get();

    log('data: ${data.docs}');

    if (data.docs.isNotEmpty && data.docs.first.id != user.uid) {
      log('user exists: ${data.docs.first.data()}');

      await firestore
          .collection('users')
          .doc(user.uid)
          .collection('my_users')
          .doc(data.docs.first.id)
          .set({});
      return true;
    } else {
      return false;
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getMyUsersId() {
    return firestore
        .collection('users')
        .doc(user.uid)
        .collection('my_users')
        .snapshots();
  }

  Future<void> sendFirstMessage(AppUser appUser, String msg) async {
    await firestore
        .collection('users')
        .doc(appUser.uid)
        .collection('my_users')
        .doc(user.uid)
        .set({}).then((value) => sendMessage(appUser, msg));
  }
}
