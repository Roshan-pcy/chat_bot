import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class Message {
  final bool isUser;
  final String message;

  Message({
    required this.isUser,
    required this.message,
  });
}

class MessageWiget extends StatelessWidget {
  final bool isUser;
  final String message;
  const MessageWiget({super.key, required this.isUser, required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.symmetric(vertical: 15)
          .copyWith(left: isUser ? 100 : 10, right: isUser ? 10 : 100),
      decoration: BoxDecoration(
          color: isUser
              ? Color.fromARGB(255, 24, 24, 24)
              : Color.fromARGB(255, 18, 19, 18),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
              bottomRight: isUser ? Radius.circular(0) : Radius.circular(15),
              bottomLeft: isUser ? Radius.circular(15) : Radius.circular(0))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          !isUser
              ? AnimatedTextKit(
                  isRepeatingAnimation: false,
                  repeatForever: false,
                  animatedTexts: [
                    TypewriterAnimatedText(message,
                        textStyle:
                            TextStyle(color: Colors.white, fontSize: 15)),
                  ],
                  onTap: () {
                    print("Tap Event");
                  },
                )
              : Text(
                  message,
                  style: TextStyle(
                      color: isUser
                          ? const Color.fromARGB(255, 249, 248, 248)
                          : Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w600),
                ),
          !isUser
              ? Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: InkWell(
                    onTap: () {
                      Clipboard.setData(ClipboardData(text: message));
                      final snackBar = SnackBar(
                        backgroundColor: Color.fromARGB(255, 222, 121, 155),
                        content: Text('Text copied'),
                        duration: Duration(seconds: 1),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    },
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Icon(
                        Icons.copy_sharp,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              : SizedBox()
        ],
      ),
    );
  }
}
