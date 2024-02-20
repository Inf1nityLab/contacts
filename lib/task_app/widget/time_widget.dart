import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimeWidget extends StatelessWidget {
  final String text;
  const TimeWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedTime = DateFormat.Hm().format(now);
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         Text(
          text,
          style: const TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        const SizedBox(
          height: 5,
        ),
        SizedBox(
          width: 170,
          child: TextField(
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20
            ),
            maxLength: 5,
            decoration: InputDecoration(
              counterText: '',
              filled: true,
              fillColor: Colors.black12,
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(15),
              ),
              hintText: '$formattedTime',
              suffixIcon: IconButton(
                onPressed: (){},
                icon: const Icon(Icons.watch_later_outlined),
              )
            ),
          ),
        ),
      ],
    );
  }
}
