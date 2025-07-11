import 'package:flutter/material.dart';
import 'package:medease1/core/utils/service_locator.dart';
import 'package:medease1/features/realChat/chats/realchat_screen.dart';
import 'package:medease1/features/realChat/conversation/cubit/conversation_cubit.dart';
import 'package:medease1/features/realChat/conversation/cubit/conversation_state.dart';
import 'package:medease1/features/realChat/conversation/repo/chat_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class ConversationListScreen extends StatelessWidget {
  final String currentUserId;

  const ConversationListScreen({required this.currentUserId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ConversationCubit(sl<ChatRepo>())..loadConversations(currentUserId),
      child: Scaffold(
        appBar: AppBar(title: Text("Chats")),
        body: BlocBuilder<ConversationCubit, ConversationState>(
          builder: (context, state) {
            if (state is ConversationLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is ConversationLoaded) {
              final conversations = state.conversations;
              return ListView.builder(
                itemCount: conversations.length,
                itemBuilder: (context, index) {
                  final conv = conversations[index];
                  final otherUser = conv.members.firstWhere((id) => id != currentUserId);

                  return ListTile(
                    title: Text("User: $otherUser"),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => RealChatScreen(
                            conversationId: conv.id,
                            senderId: currentUserId,
                            receiverId: otherUser,
                          ),
                        ),
                      );
                    },
                  );
                },
              );
            } else if (state is ConversationError) {
              return Center(child: Text("Error: ${state.error}"));
            } else {
              return SizedBox();
            }
          },
        ),
      ),
    );
  }
}
