import 'package:flutter/material.dart';

class ChatHomeListWidget extends StatelessWidget {
  const ChatHomeListWidget({required this.sessions});

  final List<dynamic> sessions;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: sessions.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            elevation: 2.0,
            child: ListTile(
              title: Text(
                "Session Number "+(index + 1).toString(),
              ),
              subtitle: Text(
                "Agent Code : " + sessions[index].toString(),
              ),

            ),
          );
        },
      ),
    );
  }
}
