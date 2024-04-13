import 'package:ctue_app/features/learn/presentation/providers/learn_provider.dart';
import 'package:ctue_app/features/learn/presentation/widgets/action_box.dart';
import 'package:ctue_app/features/vocabulary_set/presentation/widgets/word_detail_in_voca_set.dart';
import 'package:ctue_app/features/word/business/entities/word_entity.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelectWordPage extends StatefulWidget {
  const SelectWordPage({super.key});

  @override
  State<SelectWordPage> createState() => _SelectWordPageState();
}

class _SelectWordPageState extends State<SelectWordPage> {
  final List<WordEntity> skippedWords = [];
  final List<WordEntity> selectedWords = [];
  int? maxNumOfWords;
  dynamic args;

  int currentIndex = 0;

  void saveSkippedWord(WordEntity word) {
    skippedWords.add(word);
  }

  void saveSelectedWord(WordEntity word) {
    selectedWords.add(word);
    if (selectedWords.length >= maxNumOfWords!) {
      Navigator.pop(context);
      // args.callback(selectedWords);

      // Navigator.of(context).pop(selectedWords);
      Navigator.of(context).pushNamed('/learn',
          arguments: LearnringArguments(
              memoryLevels: List.filled(selectedWords.length, 0),
              words: selectedWords,
              vocabularySetId: args.vocabularySetId));
    } else {
      navigateToNextWord();
    }
  }

  void navigateToNextWord() {
    setState(() {
      if (currentIndex + 1 >= args.words.length) {
        Navigator.pop(context);
        // args.callback(selectedWords);
        if (selectedWords.isNotEmpty) {
          Navigator.of(context).pushNamed('/learn',
              arguments: LearnringArguments(
                  memoryLevels: List.filled(selectedWords.length, 0),
                  words: selectedWords,
                  vocabularySetId: args.vocabularySetId));
        }
      } else {
        currentIndex++;
      }
    });
  }

  @override
  void didChangeDependencies() {
    maxNumOfWords =
        Provider.of<LearnProvider>(context, listen: false).nWMaxNumOfWords;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context)!.settings.arguments as SelectWordArguments;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Chọn các từ để học (${selectedWords.length}/$maxNumOfWords)',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        backgroundColor: Colors.white,
        elevation: 2,
        shadowColor: Colors.grey.shade100,
        surfaceTintColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.chevron_left_rounded,
            size: 30,
          ),
        ),
        actions: const [],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          children: [
            Expanded(
                child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(width: 2, color: Colors.grey.shade300),
              ),
              child: WordDetailInVocaSet(
                // how to add slide animation to this widget?
                wordEntity: args.words[currentIndex],
              ),
            )),
            const SizedBox(
              height: 10,
            ),
            Column(
              children: [
                /*  Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Bạn không học từ này?',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    ElevatedButton(
                        style: ButtonStyle(
                            padding: const MaterialStatePropertyAll(
                                EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 8)),
                            shape: MaterialStatePropertyAll(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(32))),
                            backgroundColor:
                                const MaterialStatePropertyAll(Colors.white)),
                        onPressed: () {
                          saveSkippedWord(args.words[0]);
                          navigateToNextWord();
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.visibility_off,
                                color: Colors.grey.shade800),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              'Bỏ qua',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(fontWeight: FontWeight.bold),
                            )
                          ],
                        ))
                  ],
                ),
                const SizedBox(
                  height: 5,
                ), */
                SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () {
                          navigateToNextWord();
                        },
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.grey.shade100)),
                        child: Text('Đã biết từ này',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey.shade800,
                                )))),
                const SizedBox(
                  height: 5,
                ),
                SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () {
                          saveSelectedWord(args.words[currentIndex]);
                        },
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.blue.shade600)),
                        child: const Text('Học từ này')))
              ],
            )
          ],
        ),
      ),
    );
  }
}
