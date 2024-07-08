import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:simple_messenger/data/models/app_user.dart';
import 'package:simple_messenger/data/models/chat_message.dart';
import 'package:simple_messenger/domain/firebase_api.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc({required FirebaseApi firebaseApi})
      : _firebaseApi = firebaseApi,
        super(const ChatState()) {
    on<AddUserForChat>((event, emit) async {
      await _firebaseApi.addChatUser(event.email);
    });

    on<SignOut>((event,emit)async{
      await _firebaseApi.signOut();
    });
    on<SendMessage>((event,emit)async{
      await _firebaseApi.sendMessage(event.sendPerson,event. message);
    });
  }

  final FirebaseApi _firebaseApi;

  Stream<QuerySnapshot<Map<String, dynamic>>> getFirebaseStream(AppUser user)=> _firebaseApi.getAllMessages(user);
  Stream<QuerySnapshot<Map<String, dynamic>>> getAllUsers(List<String> usersID)=> _firebaseApi.getAllUsers(usersID);
  Stream<QuerySnapshot<Map<String, dynamic>>> getMyUsersId()=> _firebaseApi.getMyUsersId();
  String getUserID()=> FirebaseApi.user.uid;

  void sendMessage(AppUser appUser,String message)=> _firebaseApi.sendFirstMessage(appUser,message);

   Stream<QuerySnapshot<Map<String, dynamic>>> getLastMessage(AppUser appUser) => _firebaseApi.getLastMessage(appUser);



}
