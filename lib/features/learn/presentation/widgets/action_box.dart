import 'package:ctue_app/features/skeleton/providers/selected_page_provider.dart';
import 'package:ctue_app/features/word/business/entities/word_entity.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ActionBox extends StatelessWidget {
  final List<WordEntity> words;
  final int vocabularySetId;
  const ActionBox(
      {super.key, this.words = const [], required this.vocabularySetId});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.blue.shade100,
          boxShadow: const [BoxShadow(color: Colors.grey, blurRadius: 3)]),
      child: Row(
        children: [
          Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.error_outline_sharp,
                        color: Colors.grey,
                      ),
                      const SizedBox(
                        width: 3,
                      ),
                      Flexible(
                        child: Text(
                          vocabularySetId == -1
                              ? 'Bắt đầu học để ghi nhớ từ trong kho từ vựng của bạn nhé'
                              : 'Bạn đang có ${words.length} từ vựng cần ôn tập',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                  // Text(
                  //   '3 từ',
                  //   style: Theme.of(context)
                  //       .textTheme
                  //       .bodyLarge!
                  //       .copyWith(color: Colors.red),
                  // ),
                  const SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        style: ButtonStyle(
                            shape: MaterialStatePropertyAll(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8))),
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.blue.shade600)),
                        onPressed: words.isEmpty
                            ? () {
                                Provider.of<SelectedPageProvider>(context,
                                        listen: false)
                                    .selectedPage = 1;
                              }
                            : () {
                                Navigator.of(context).pushNamed('/learn',
                                    arguments: LearnringArguments(
                                        words: words,
                                        vocabularySetId: vocabularySetId));
                              },
                        child: Text(
                            // ''
                            words.isEmpty ? 'Học từ vựng' : 'Ôn tập ngay')),
                  )
                ],
              )),
          const SizedBox(
            width: 10,
          ),
          Expanded(
              flex: 2,
              child: SizedBox(
                  height: 100,
                  width: 100,
                  child: Image.asset(
                    'assets/images/note.png',
                    fit: BoxFit.fill,
                  )))
        ],
      ),
    );
  }
}

class LearnringArguments {
  List<WordEntity> words = [];
  int vocabularySetId;
  LearnringArguments({required this.words, required this.vocabularySetId});
}
