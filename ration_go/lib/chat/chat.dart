import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ration_go/chat/chat_message.dart';
import 'package:ration_go/colors.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<Map<String, dynamic>> messages = [];
  TextEditingController _controller = TextEditingController();
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();

  void _sendMessage() async {
    if (_controller.text.trim().isEmpty) return;

    _addMessage(_controller.text, true);
    setState(() {});

    _controller.clear();
  }

  void _addMessage(String text, bool isUserMessage) {
    final int index = messages.length;
    messages.add({'text': text, 'isUserMessage': isUserMessage});
    _listKey.currentState?.insertItem(index);
  }

  Future<void> _generateBotResponse(String input) async {
    Dio dio = Dio();

    final url = 'https://atharvmendhe18-sit-internal.hf.space/process';

    final data = {
      'text': input,
    };

    try {
      Response response = await dio.post(url,
          data: data,
          options: Options(headers: {
            'Content-Type': 'application/json',
            "Accept": "application/json",
            "Access-Control-Allow-Origin": "*",
          }));

      if (response.statusCode == 200) {
        final responseData = response.data;
        // GoogleTranslator()
        //     .translate(responseData['response'], from: 'en', to: 'mr')
        //     .then((s) {
        //   _addMessage(s.text, false);
        // });

        String response_op = responseData['response'];
        _addMessage(response_op, false);
      } else {
        print('Failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
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
            messages.length > 0
                ? Expanded(
                    child: Column(
                      children: [
                        Expanded(
                          child: AnimatedList(
                            shrinkWrap: false,
                            key: _listKey,
                            reverse: true,
                            initialItemCount: messages.length,
                            itemBuilder: (context, index, animation) {
                              final message =
                                  messages[messages.length - 1 - index];
                              return FadeTransition(
                                opacity: animation,
                                child: ChatMessage(
                                  text: message['text'],
                                  isUserMessage: message['isUserMessage'],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
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
