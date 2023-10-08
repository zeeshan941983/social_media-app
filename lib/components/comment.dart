import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class comment extends StatefulWidget {
  final String text;
  final String user;
  final String time;

  const comment({
    super.key,
    required this.text,
    required this.user,
    required this.time,
  });

  @override
  State<comment> createState() => _commentState();
}

class _commentState extends State<comment> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(color: Theme.of(context).colorScheme.secondary),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ///comment
          Row(
            children: [
              Text(widget.text),
              SizedBox(
                width: 10,
              ),
              Text(widget.time, style: TextStyle(color: Colors.grey)),
            ],
          ),

          Row(
            children: [
              //time , user
              Text(
                widget.user,
                style: TextStyle(color: Colors.grey),
              ),
              Text('.  ', style: TextStyle(color: Colors.grey)),
            ],
          )
        ],
      ),
    );
  }
}
