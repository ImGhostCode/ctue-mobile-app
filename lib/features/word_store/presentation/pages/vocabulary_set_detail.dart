import 'package:ctue_app/features/word_store/presentation/pages/word_store_page.dart';
import 'package:flutter/material.dart';

class VocabularySetDetail extends StatelessWidget {
  const VocabularySetDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as VocabularySetArguments;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Default',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Text('${args.id}'),
    );
  }
}

// class VocabularySetArguments {
//   final int id;

//   VocabularySetArguments({required this.id});
// }
