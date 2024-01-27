import 'package:flutter/material.dart';

class CorrectWordPage extends StatelessWidget {
  const CorrectWordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            'Hãy chọn từ đúng',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.navigate_before,
                size: 32,
              )),
        ),
        body: const Text('Correct word'));
  }
}
