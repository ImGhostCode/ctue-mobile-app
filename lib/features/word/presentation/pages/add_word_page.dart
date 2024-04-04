import 'package:ctue_app/features/word/presentation/providers/word_provider.dart';
import 'package:ctue_app/features/word/presentation/widgets/word_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddWordPage extends StatelessWidget {
  const AddWordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          scrolledUnderElevation: 0,
          title: Text(
            'Thêm từ',
            style: Theme.of(context).textTheme.titleMedium!.copyWith(),
          ),
          centerTitle: true,
          // actions: [
          //   TextButton(
          //       onPressed: () {},
          //       child: Text(
          //         'Thêm',
          //         style: Theme.of(context)
          //             .textTheme
          //             .bodyLarge!
          //             .copyWith(color: Colors.teal),
          //       )),
          //   const SizedBox(
          //     width: 10,
          //   )
          // ],
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.chevron_left_rounded,
              size: 30,
            ),
          )),
      body: WordForm(
        titleBtnSubmit: "Xác nhận",
        callback: (data) async {
          final wordData = data.elementAt(1);

          await Provider.of<WordProvider>(context, listen: false)
              .eitherFailureOrCreWord(
                  wordData.topicId,
                  wordData.levelId,
                  wordData.specializationId,
                  wordData.content,
                  wordData.meanings,
                  wordData.note,
                  wordData.phonetic,
                  wordData.examples,
                  wordData.synonyms,
                  wordData.antonyms,
                  wordData.pictures);
          Navigator.of(context).pop();
        },
        isLoading: Provider.of<WordProvider>(context, listen: true).isLoading,
      ),
    );
  }
}
