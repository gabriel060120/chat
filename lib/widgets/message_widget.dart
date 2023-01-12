// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class MessageWidget extends StatelessWidget {
  final String name;
  final String message;
  final bool isMe;
  const MessageWidget({
    Key? key,
    required this.name,
    required this.message,
    required this.isMe,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 30.0, left: 8.0, right: 8.0),
        padding: const EdgeInsets.all(8.0),
        // width: 100,
        constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.7, minWidth: 10),
        decoration: BoxDecoration(
          color: isMe
              ? const Color.fromARGB(255, 176, 238, 178)
              : const Color.fromARGB(255, 236, 234, 234),
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!isMe) ...[
              Text(
                name,
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 24, 88, 26)),
              ),
              const SizedBox(
                height: 8,
              )
            ],
            Text(
              message,
              style: const TextStyle(fontSize: 24, color: Colors.black),
            )
          ],
        ),
      ),
    );
  }
}
