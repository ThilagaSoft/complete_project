import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:map_pro/bloc/chat/chat_bloc.dart';
import 'package:map_pro/bloc/chat/chat_event.dart';
import 'package:map_pro/bloc/chat/chat_state.dart';


class ChatPage extends StatefulWidget {
  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final myIdController = TextEditingController();
  final peerIdController = TextEditingController();
  final textController = TextEditingController();
  final scrollController = ScrollController();

  bool started = false;

  @override
  void initState() {
    super.initState();

    // Get FCM token
    FirebaseMessaging.instance.getToken().then((token) {
      print("My FCM Token: $token");
    });

    // Handle foreground messages
    FirebaseMessaging.onMessage.listen((message) {
      if (message.notification != null) {
        if (!mounted) return;
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text(message.notification!.title ?? "New Message"),
            content: Text(message.notification!.body ?? ""),
          ),
        );
      }
    });

    // Handle background message tap
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      if (message.notification != null) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Opened from notification: ${message.notification!.title ?? ''}")),
        );
      }
    });

    // Handle app launch from terminated state
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message?.notification != null) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Launched from notification: ${message!.notification!.title ?? ''}")),
        );
      }
    });
  }

  @override
  void dispose() {
    myIdController.dispose();
    peerIdController.dispose();
    textController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    if (scrollController.hasClients) {
      scrollController.jumpTo(scrollController.position.maxScrollExtent);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Firestore Chat")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            if (!started) ...[
              TextField(
                controller: myIdController,
                decoration: InputDecoration(labelText: 'Your ID'),
              ),
              TextField(
                controller: peerIdController,
                decoration: InputDecoration(labelText: 'Peer ID'),
              ),
              ElevatedButton(
                onPressed: () {
                  final myId = myIdController.text.trim();
                  final peerId = peerIdController.text.trim();
                  if (myId.isEmpty || peerId.isEmpty) return;

                  context.read<ChatBloc>().add(InitChat(myId, peerId));
                  setState(() {
                    started = true;
                  });
                },
                child: Text("Start Chat"),
              )
            ] else ...[
              Expanded(
                child: BlocBuilder<ChatBloc, ChatState>(
                  builder: (context, state) {
                    if (state is ChatLoaded) {
                      WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
                      return ListView(
                        controller: scrollController,
                        children: state.messages
                            .map((m) => ListTile(title: Text(m)))
                            .toList(),
                      );
                    } else if (state is ChatError) {
                      return Center(child: Text("Error: ${state.error}"));
                    }
                    return Center(child: CircularProgressIndicator());
                  },
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: textController,
                      decoration: InputDecoration(hintText: "Enter message"),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.send),
                    onPressed: () {
                      final text = textController.text.trim();
                      if (text.isEmpty) return;
                      context.read<ChatBloc>().add(SendMessage(text));
                      textController.clear();
                    },
                  )
                ],
              )
            ]
          ],
        ),
      ),
    );
  }
}
