import 'package:flutter/material.dart';
import 'package:ration_go/colors.dart';
import 'package:intl/intl.dart';

class ChatMessage extends StatelessWidget {
  final String text;
  final bool isUserMessage;
  final String timestamp;

  const ChatMessage({
    required this.text,
    required this.isUserMessage,
    required this.timestamp,
  });

  @override
  Widget build(BuildContext context) {
    final formattedTime = DateFormat.jm().format(DateTime.parse(timestamp));

    return Align(
      alignment: isUserMessage ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        decoration: BoxDecoration(
          color: isUserMessage ? AppColors.primary : AppColors.secondary,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment:
              isUserMessage ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Text(
              text,
              style: TextStyle(
                color: isUserMessage ? Colors.white : Colors.black,
              ),
            ),
            SizedBox(height: 5),
            Text(
              formattedTime,
              style: TextStyle(
                color: isUserMessage ? Colors.white70 : Colors.black54,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
