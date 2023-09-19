
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:messegeme/screens/login_sc.dart';

final _firestore = FirebaseFirestore.instance;
late User signedinuser;


class ChatSc extends StatefulWidget {
  static const String scChat = "scChat";


  const ChatSc({Key? key}) : super(key: key);

  @override
  State<ChatSc> createState() => _ChatScState();
}

class _ChatScState extends State<ChatSc> {
  final messageTextController = TextEditingController();
  final _auth = FirebaseAuth.instance;

  String? messageText;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrntUser();
  }

  void getCurrntUser() {
    final user = _auth.currentUser;
    try {
      if (user != null) {
        signedinuser = user;
        print(signedinuser);
        print(signedinuser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  // void getMessages () async {
  //   final messages = await _firestore.collection('messages').get();
  //   for(var message in messages.docs){
  //     print(message.data());
  //   }
  // }
  void messagesStreams() async {
    await for (var snapshot in _firestore.collection('messages').snapshots()) {
      for (var message in snapshot.docs) {
        print(message.data());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF324A5E),
        title: Row(
          children: [
            Image.asset(
              "images/1.png",
              height: 30,
            ),
            const SizedBox(
              width: 5,
            ),
            const Text("Chat")
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {
                // messagesStreams();
                _auth.signOut();
                Navigator.pushReplacementNamed(context,LoginSc.scLogin);
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const MessageStreamBuilder(),
            Container(
              color: Color(0x7EF1543F),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: messageTextController,
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          hintText: ("Write your message here ..")),
                      onChanged: (value) {
                        messageText = value;
                      },
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        messageTextController.clear();
                        _firestore.collection('messages').add({
                          'sender': signedinuser.email,
                          'text': messageText,
                          'time':FieldValue.serverTimestamp(), // تعطينا التوقيت
                        });
                      },
                      child: const Text("Send"))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageStreamBuilder extends StatelessWidget {
  const MessageStreamBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('messages').orderBy('time').snapshots(),
      builder: (context, snapshot) {
        List<MessageLine> messagesWidgets = [];

        if (!snapshot.hasData) {
          const Center(child: CircularProgressIndicator(),);
        }
        final messages = snapshot.data!.docs.reversed;
        for (var message in messages) {
          final messageText = message.get('text');
          final messageSender = message.get('sender');
          final currentUser = signedinuser.email;

          final messageWidget = MessageLine(isMe: currentUser==messageSender,
            text: messageText, sender: messageSender);
          messagesWidgets.add(messageWidget);
        }

        return Expanded(
          child: ListView(
            reverse: true,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            children: messagesWidgets,

          ),
        );
      },
    );
  }
}


class MessageLine extends StatelessWidget {
  const MessageLine({this.text, this.sender, required this.isMe ,Key? key}) : super(key: key);

  final String? sender;
  final String? text;
  final bool isMe ;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment:isMe ?CrossAxisAlignment.end: CrossAxisAlignment.start,
        children: [
          Text(sender!, style: const TextStyle(fontSize: 11, color: Colors.black45),),
          Material(
              elevation: 5,
              borderRadius: isMe
                  ? const BorderRadius.only(
                      topRight: Radius.circular(3),
                      topLeft: Radius.circular(15),
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15))
                  : const BorderRadius.only(
                      topRight: Radius.circular(15),
                      topLeft: Radius.circular(3),
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15)),
              color: isMe?Color(0xFFF1543F):Color(0xFF324A5E),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  '$text',
                  style: const TextStyle(fontSize: 14, color: Colors.white),
                ),
              )),
        ],
      ),
    );
  }
}
