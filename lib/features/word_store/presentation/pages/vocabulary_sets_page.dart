import 'package:flutter/material.dart';

class VocabularySets extends StatelessWidget {
  const VocabularySets({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Các bộ từ vựng',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        backgroundColor: Colors.transparent,
      ),
      body: const Text('data'),
    );
  }
}
