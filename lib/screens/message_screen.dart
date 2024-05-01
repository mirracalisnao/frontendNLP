import 'package:ccs249_frontend/api_handler/api.dart';
import 'package:flutter/material.dart';

import '../class/message.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  // message object contains two properties
  // one -> content of message
  // source -> either from user or flask
  List messages = [
    new Message(content: "Welcome to the NLP Project!", sender: "Phone")
  ];

  TextEditingController messageCtrl = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CCS 249 Project"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // message screen
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.orangeAccent,
              ),
              child: ListView.builder(
                reverse: true,
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                        // change the alignment depending on the type of sender
                        mainAxisAlignment: messages[index].sender == 'me'
                            ? MainAxisAlignment.end
                            : MainAxisAlignment.start,
                        children: [
                          Text('${messages[index].sender}: '),
                          Text('${messages[index].content}'),
                        ]),
                  );
                },
              ),
            ),
          ),

          // buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: "Input Message",
                    ),
                    controller: messageCtrl,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    onPressed: () async {
                      // add your message
                      messages.insert(
                          0, Message(sender: 'me', content: messageCtrl.text));

                      var message = await sendMessage(messageCtrl.text);
                      // print(message);
                      setState(() {
                        // this method will add the message on the top
                        // messages.add(message);
                        messages.insert(0, message);
                        messageCtrl.text = "";
                      });
                    },
                    child: Text('Send')),
              )
            ],
          )
        ],
      ),
    );
  }
}
