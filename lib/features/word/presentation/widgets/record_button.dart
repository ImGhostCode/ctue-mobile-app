import 'package:flutter/material.dart';

class RecordButton extends StatelessWidget {
  const RecordButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
            shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24))),
            padding: const MaterialStatePropertyAll(
                EdgeInsets.symmetric(horizontal: 32, vertical: 12))),
        onPressed: () {},
        child: const Icon(
          Icons.mic_rounded,
          size: 50,
          color: Colors.white,
        ));
  }
}
