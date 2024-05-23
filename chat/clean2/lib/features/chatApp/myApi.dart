import 'package:clean2/features/chatApp/Mykey.dart';
import 'package:clean2/features/chatApp/message.dart';
import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class MyAPi extends StatefulWidget {
  const MyAPi({super.key});

  @override
  State<MyAPi> createState() => _MyAPiState();
}

class _MyAPiState extends State<MyAPi> {
  TextEditingController usertext = TextEditingController();
  List<Message> listOFMessage = [];
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 134, 46, 124),
        title: Text(
          'my chat bot',
          style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Color.fromARGB(255, 254, 251, 251),
              fontSize: 25),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.exit_to_app,
              color: Color.fromARGB(255, 253, 250, 250),
            ),
          )
        ],
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: listOFMessage.isEmpty
                  ? Center(
                      child: Text(
                        ' pcy chat bot',
                        style: TextStyle(color: Colors.black),
                      ),
                    )
                  : ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: listOFMessage.length,
                      itemBuilder: (context, index) {
                        final data = listOFMessage[index];
                        print('see the data ${data.message}');

                        if (listOFMessage.isEmpty) {
                          return Center(
                              child: Text(
                            'Lets start',
                            style: TextStyle(color: Colors.black),
                          ));
                        }
                        return MessageWiget(
                            isUser: data.isUser, message: data.message);
                      },
                    ),
            ),
            Row(
              children: [
                Expanded(
                    flex: 14,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: usertext,
                        decoration: InputDecoration(
                          hintStyle: TextStyle(color: Colors.white),
                          hintText: 'message',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(
                                    255, 213, 98, 98)), // Border color
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          filled: true, // Add background color
                          fillColor: Color.fromARGB(255, 188, 121, 239),
                        ),
                      ),
                    )),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                      onTap: () {
                        taklWithAi();
                        usertext.text = '';
                        FocusScope.of(context).unfocus();
                      },
                      child: !isLoading
                          ? Icon(
                              Icons.send,
                              color: Colors.green,
                              size: 35,
                            )
                          : CircularProgressIndicator(
                              color: Color.fromARGB(255, 52, 197, 78),
                            )),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<void> taklWithAi() async {
    listOFMessage.add(Message(
      isUser: true,
      message: usertext.text,
    ));
    isLoading = true;
    setState(() {});

    final model = GenerativeModel(model: 'gemini-pro', apiKey: MyApiKey.APIKEY);
    final message = usertext.text;
    final contenct = Content.text(message);
    final responce = await model.generateContent([contenct]);
    listOFMessage.add(
        Message(isUser: false, message: responce.text ?? ' Sorry  No Found'));
    isLoading = false;
    setState(() {});
  }
}
