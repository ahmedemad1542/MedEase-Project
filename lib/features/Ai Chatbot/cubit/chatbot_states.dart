abstract class ChatState {}

class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {}

class ChatSuccess extends ChatState {
  final String prompt;
  final List<String> options;
  final String state;
  final String? userInput;

  ChatSuccess({
    required this.prompt,
    required this.options,
    required this.state,
    this.userInput,
  });
}

class ChatError extends ChatState {
  final String message;

  ChatError(this.message);
}