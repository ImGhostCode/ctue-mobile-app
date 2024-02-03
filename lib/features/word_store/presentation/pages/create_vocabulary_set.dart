import 'package:flutter/material.dart';

class CreateVocabularySet extends StatelessWidget {
  const CreateVocabularySet({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Tạo bộ từ mới',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        backgroundColor: Colors.transparent,
      ),
      body: const Text('data'),
    );
  }
}
