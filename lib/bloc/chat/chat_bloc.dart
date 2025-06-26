import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'chat_event.dart';
import 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  String? userId;
  String? peerId;
  final List<String> messages = [];
  final _firestore = FirebaseFirestore.instance;

  ChatBloc() : super(ChatInitial()) {
    on<InitChat>(_onInit);
    on<SendMessage>(_onSend);
    on<MessageReceived>(_onReceive);
  }

  void _onInit(InitChat event, Emitter<ChatState> emit) {
    userId = event.userId;
    peerId = event.peerId;

    _firestore
        .collection('chats')
        .doc(_chatId())
        .collection('messages')
        .orderBy('timestamp')
        .snapshots()
        .listen((snapshot) {
      for (var doc in snapshot.docChanges) {
        final data = doc.doc.data();
        if (data != null) {
          add(MessageReceived(data['from'], data['text']));
        }
      }
    });

    emit(ChatLoaded(List.from(messages)));
  }

  void _onSend(SendMessage event, Emitter<ChatState> emit) async {
    try {
      final ref = await _firestore
          .collection('chats')
          .doc(_chatId())
          .collection('messages')
          .add({
        'from': userId,
        'to': peerId,
        'text': event.text,
        'timestamp': FieldValue.serverTimestamp(),
      });

      print("✅ Message written at: ${ref.path}");
    } catch (e) {
      emit(ChatError(e.toString()));
    }
  }

  void _onReceive(MessageReceived event, Emitter<ChatState> emit) {
    messages.add("${event.from}: ${event.text}");
    emit(ChatLoaded(List.from(messages)));
  }

  String _chatId() {
    final ids = [userId!, peerId!]..sort();
    return ids.join('_');
  }
}
