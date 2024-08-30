import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ration_go/chat/chat_message.dart';
import 'package:ration_go/colors.dart';
import 'package:ration_go/common/constants.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController _controller = TextEditingController();
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();

  List<Map<String, dynamic>> messages = [];

  @override
  void initState() {
    super.initState();
    getChatMessages();
  }

  void _addMessage(String text, bool isUserMessage) async {
    Dio dio = Dio();
    try {
      final response = await dio.post(
        '${ServerConstants.server_url}/fps/add_chat_message',
        data: {
          "ration_card_id": "RC001",
          "fps_id": "FPS002",
          "message": text,
          "is_sender": isUserMessage
        },
        options: Options(
          validateStatus: (status) {
            return status != null && status < 502;
          },
        ),
      );
      if (response.statusCode == 200) {
        getChatMessages();
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> getChatMessages() async {
    Dio dio = Dio();
    try {
      final response = await dio.post(
        '${ServerConstants.server_url}/fps/get_chat_messages',
        data: {"ration_card_id": "RC001", "fps_id": "FPS002"},
        options: Options(
          validateStatus: (status) {
            return status != null && status < 502;
          },
        ),
      );
      if (response.statusCode == 200) {
        List<Map<String, dynamic>> newMessages = [];

        response.data['messages'].sort((a, b) {
          return DateTime.parse(b['timestamp'])
              .compareTo(DateTime.parse(a['timestamp']));
        });
        for (var message in response.data['messages']) {
          newMessages.add({
            'text': message['message'],
            'isUserMessage': message['is_sender'],
            'timestamp': message['timestamp']
          });
        }
        setState(() {
          messages = newMessages;
        });
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print(e);
    }
  }

  void _sendMessage() async {
    if (_controller.text.trim().isEmpty) return;
    final newMessage = {
      'text': _controller.text,
      'isUserMessage': true,
      'timestamp': DateTime.now().toIso8601String()
    };

    // Add message to list and animated list
    setState(() {
      messages.insert(0, newMessage); // Insert at the beginning
      _listKey.currentState?.insertItem(0); // Add to AnimatedList
    });

    _addMessage(_controller.text, true);
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        centerTitle: false,
        scrolledUnderElevation: 0.0,
        backgroundColor: Colors.white,
        title:
            const Text('RationGo!', style: TextStyle(color: AppColors.primary)),
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 60),
        child: Column(
          children: [
            messages.isNotEmpty
                ? Expanded(
                    child: AnimatedList(
                      shrinkWrap: false,
                      key: _listKey,
                      reverse: true,
                      initialItemCount: messages.length,
                      itemBuilder: (context, index, animation) {
                        final message = messages[index];
                        return FadeTransition(
                          opacity: animation,
                          child: ChatMessage(
                            text: message['text'],
                            isUserMessage: message['isUserMessage'],
                            timestamp: message['timestamp'],
                          ),
                        );
                      },
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ),
      bottomSheet: customBottomSheet(),
    );
  }

  Widget customBottomSheet() {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          20.0,
          0,
          5,
          0,
        ),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                autocorrect: true,
                enableSuggestions: true,
                onSubmitted: (_) => _sendMessage(),
                minLines: 1,
                controller: _controller,
                decoration: InputDecoration(
                  hintText: "Type your message...",
                  border: InputBorder.none,
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.send_rounded, color: AppColors.primary),
              onPressed: _sendMessage,
            ),
          ],
        ),
      ),
    );
  }
}
