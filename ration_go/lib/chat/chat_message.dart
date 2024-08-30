import 'package:flutter/material.dart';
import 'package:ration_go/colors.dart';

class ChatMessage extends StatelessWidget {
  final String text;
  final bool isUserMessage;

  const ChatMessage({required this.text, required this.isUserMessage});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isUserMessage ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        decoration: BoxDecoration(
          color: isUserMessage ? AppColors.primary : AppColors.secondary,
          borderRadius: BorderRadius.circular(15),
        ),
        child: isUserMessage
            ? Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                ),
              )
            : Text(
                text,
                style: const TextStyle(
                  color: Colors.black,
                ),
              ),
      ),
    );
  }
}
