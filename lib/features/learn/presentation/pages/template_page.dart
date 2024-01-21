import 'package:flutter/material.dart';

class LearnPage extends StatelessWidget {
  const LearnPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('CTUE'),
      ),
      body: Center(
        child: ElevatedButton(
            child: Text('login page'),
            onPressed: () {
              Navigator.pushNamed(context, '/login');
            }),
      ),
    );
  }
}
