import 'package:flutter/material.dart';

class Snapchat_ui extends StatelessWidget {
  Snapchat_ui({super.key});
  List<String> name = ["Mr Crysta", "jesus"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: name.length,
        itemBuilder: (context, index) {
          return ListTile(
            trailing: Icon(
              Icons.chat_bubble_outline,
              color: const Color.fromARGB(255, 203, 201, 201),
            ),
            leading: CircleAvatar(
              child: Image.network(
                  'https://cdn-icons-png.flaticon.com/128/3670/3670166.png'),
            ),
            title: Text(
              name[index],
              style: TextStyle(fontWeight: FontWeight.w800),
            ),
            subtitle: Row(
              children: [
                Container(
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(3)),
                    height: 10,
                    width: 10),
                SizedBox(
                  width: 2,
                ),
                Text(
                  'New snap',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 10,
                      color: Color.fromARGB(255, 237, 66, 66)),
                ),
                SizedBox(
                  width: 4,
                ),
                Text(
                  '30',
                  style: TextStyle(
                      fontSize: 10,
                      color: Color.fromARGB(255, 9, 9, 9),
                      fontWeight: FontWeight.w400),
                ),
                Text(
                  '🔥',
                  style: TextStyle(color: Color.fromARGB(255, 231, 58, 28)),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
