import 'package:flutter/material.dart';
import 'package:flutter_chat/chat/chat_page.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    const storage = FlutterSecureStorage();
    super.initState();
    storage.read(key: 'name').then((value) {
      if (value != null && value.isNotEmpty) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => ChatPage(
                name: value,
              ),
            ),
            (route) => false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: "Nome",
                hintText: "Digite seu nome",
                labelStyle: TextStyle(
                  fontSize: 20,
                ),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            ElevatedButton(
              onPressed: () async {
                const storage = FlutterSecureStorage();
                await storage.write(key: 'name', value: nameController.text);
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChatPage(
                        name: nameController.text,
                      ),
                    ),
                    (route) => false);
              },
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(8.0),
                  child: const Text(
                    "Entrar",
                    style: TextStyle(fontSize: 30),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
