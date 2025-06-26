abstract class ChatEvent {}

/// Initialize chat session
class InitChat extends ChatEvent {
  final String userId;  // sender ID
  final String peerId;  // recipient ID
  InitChat(this.userId, this.peerId);
}

/// Send a message
class SendMessage extends ChatEvent {
  final String text;
  SendMessage(this.text);
}

/// Receive a message (internal use by BLoC when Firestore triggers a listener)
class MessageReceived extends ChatEvent {
  final String from;
  final String text;
  MessageReceived(this.from, this.text);
}
