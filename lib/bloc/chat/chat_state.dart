abstract class ChatState {}

/// Initial state before anything starts
class ChatInitial extends ChatState {}

/// Loading (e.g. starting listener)
class ChatLoading extends ChatState {}

/// Chat loaded and messages available
class ChatLoaded extends ChatState {
  final List<String> messages;
  ChatLoaded(this.messages);
}

/// Error state
class ChatError extends ChatState {
  final String error;
  ChatError(this.error);
}
