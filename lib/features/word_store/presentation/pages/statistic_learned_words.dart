import 'package:flutter/material.dart';

class StatisticLearnedWordPage extends StatelessWidget {
  const StatisticLearnedWordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Cấp độ nhớ',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        backgroundColor: Colors.transparent,
      ),
      body: const Text('data'),
    );
  }
}
