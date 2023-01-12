// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_chat/services/firebase_service.dart';
import 'package:flutter_chat/widgets/message_widget.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({
    Key? key,
    required this.name,
  }) : super(key: key);
  final String name;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late List messageList;
  final TextEditingController messageController = TextEditingController();

  @override
  void initState() {
    messageList = [];
    super.initState();
    FirebaseService().initDatabase();
  }

  @override
  Widget build(BuildContext context) {
    final DatabaseReference database = FirebaseService.database.ref('messages');
    database.onValue.listen((event) {
      Map messageMap = event.snapshot.value as Map;
      setState(() {
        List dbList = messageMap['messages'];
        if (messageList.length != dbList.length) {
          messageList = messageMap['messages'];
          messageList = messageList.reversed.toList();
        }
        // print(messageList);
      });
      // print(event.snapshot.value);
    });
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        title: const Center(
          child: Text('Zapzap dos cria'),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.8,
              child: ListView(
                reverse: true,
                children: List.generate(
                    messageList.length,
                    (index) => MessageWidget(
                        name: messageList[index]['name'],
                        message: messageList[index]['message'],
                        isMe: messageList[index]['name'] == widget.name)),
              ),
            ),
            // SizedBox(
            //   height: MediaQuery.of(context).size.height * 0.8,
            //   child: Padding(
            //     padding: const EdgeInsets.all(8.0),
            //     child: ListView.builder(
            //       reverse: true,
            //       itemCount: messageList.length,
            //       itemBuilder: (context, index) => MessageWidget(
            //           name: messageList[index]['name'],
            //           message: messageList[index]['message'],
            //           isMe: messageList[index]['name'] == widget.name),
            //     ),
            //   ),
            // ),
            Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.88,
                  child: TextField(
                    controller: messageController,
                    decoration: const InputDecoration(
                      hintText: "Digite sua mensagem",
                      labelStyle: TextStyle(
                        fontSize: 20,
                      ),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                    onPressed: () async {
                      if (messageController.text.isNotEmpty) {
                        List messageDatabase = messageList.reversed.toList();
                        messageDatabase.add({
                          "name": widget.name,
                          "message": messageController.text
                        });
                        await database.update({"messages": messageDatabase});
                        messageController.text = "";
                      }
                    },
                    icon: const Icon(Icons.send)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
