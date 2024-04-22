import 'dart:async';

import 'package:ctue_app/core/constants/memory_level_constants.dart';
import 'package:ctue_app/core/params/learn_params.dart';
import 'package:ctue_app/features/learn/presentation/providers/learn_provider.dart';
import 'package:ctue_app/features/learn/presentation/widgets/action_box.dart';
import 'package:ctue_app/features/profile/presentation/widgets/colored_line.dart';
import 'package:ctue_app/features/vocabulary_pack/presentation/widgets/word_detail_in_voca_set.dart';
import 'package:ctue_app/features/word/business/entities/word_entity.dart';
import 'package:flutter/material.dart';
import 'dart:collection';

import 'package:provider/provider.dart';

class LearnPage extends StatefulWidget {
  const LearnPage({Key? key}) : super(key: key);

  @override
  State<LearnPage> createState() => _LearnPageState();
}

class _LearnPageState extends State<LearnPage> {
  bool _dataInitialized = false; // Flag to track initialization
  List<int> initMemoryLevels = [];
  int totalStep = 4;
  int currStep = 1;
  Widget? currQuestion;
  List<LearnData> listLearningData = [];
  int currWordIndex = 0;
  int? vocabularySetId;
  int? reviewReminderId;

  final TextEditingController _answerController = TextEditingController();
  Queue<Widget> questionQueue = Queue();
  Queue<int> indexStep = Queue();
  Queue<int> indexWord = Queue();

  Widget _buildQuestion(LearnData learnData, int step) {
    switch (step) {
      case 1:
        // print('writting question: ${learnData.word}');
        return _buildWritingQuestion(context, learnData.word);
      // break;
      case 2:
        // print('choose meaning question: ${learnData.word}');
        return _buildChooseMeaningQuestion(context, learnData.word);
      // break;
      case 3:
        // print('listening question: ${learnData.word}');
        return _buildListeningQuestion(context, learnData.word);
      // break;
      case 4:
        // print('choose word question: ${learnData.word}');
        return _buldChooseWordQuestion(context, learnData.word);
      default:
        return const SizedBox();
    }
  }

  DateTime getTimeToReview(int level, DateTime now) {
    switch (level) {
      case 1:
        return now.add(const Duration(hours: 2));
      case 2:
        return now.add(const Duration(days: 1));
      case 3:
        return now.add(const Duration(days: 2));
      case 4:
        return now.add(const Duration(days: 3));
      case 5:
        return now.add(const Duration(days: 5));
      case 6:
        return now.add(const Duration(days: 8));
      default:
        return now;
    }
  }

  void _displayResult() {
    DateTime now = DateTime.now();
    List<WordEntity> learnedWords = [];
    List<int> memoryLevels = [];
    for (int idx = 0; idx < listLearningData.length; idx++) {
      // remembered
      if (listLearningData[idx].currStep == 4) {
        learnedWords.add(listLearningData[idx].word);
        if (initMemoryLevels[idx] >= MemoryLevels.level_6) {
          memoryLevels.add(initMemoryLevels[idx]);
        } else {
          memoryLevels.add(initMemoryLevels[idx] + 1);
        }

        // not remembered
      } else if (listLearningData[idx].numOfMistakes == 4) {
        learnedWords.add(listLearningData[idx].word);
        if (initMemoryLevels[idx] - 1 > 0) {
          memoryLevels.add(initMemoryLevels[idx] - 1);
        } else {
          memoryLevels.add(initMemoryLevels[idx]);
        }
      }
    }
    // print('learnedWords: $learnedWords');
    // print('memoryLevels: $memoryLevels');

// Save result
    _saveLearnedResult(learnedWords, memoryLevels, reviewReminderId);

// Create review reminder
    _createReviewReminder(learnedWords, memoryLevels, now);

// Show result
    // Navigator.pop(context);
    Navigator.pushReplacementNamed(context, '/learned-result',
        arguments: LearningResultArguments(
            oldMemoryLevels: initMemoryLevels,
            learnedWords: learnedWords,
            memoryLevels: memoryLevels));
  }

  void _saveLearnedResult(List<WordEntity> learnedWords, List<int> memoryLevels,
      int? reviewReimderId) {
    Provider.of<LearnProvider>(context, listen: false)
        .eitherFailureOrSaveLearnedResult(
            learnedWords.map((e) => e.id).toList(),
            vocabularySetId!,
            reviewReimderId,
            memoryLevels);
  }

  void _createReviewReminder(
      List<WordEntity> learnedWords, List<int> memoryLevels, DateTime now) {
    List<DataRemindParams> dataRemind = [];
    for (var i = 0; i < learnedWords.length; i++) {
      dataRemind.add(DataRemindParams(
          wordId: learnedWords[i].id,
          reviewAt: getTimeToReview(memoryLevels[i], now)));
    }
    Provider.of<LearnProvider>(context, listen: false)
        .eitherFailureOrCreReviewReminder(vocabularySetId!, dataRemind);
  }

  void _checkAnswer(dynamic userAnswer) {
    // print(userAnswer);
    bool isCorrect =
        listLearningData[indexWord.first].word.content == userAnswer;
    // print(isCorrect);
    _showAnswerResult(
        context, listLearningData[indexWord.first].word, isCorrect);
    if (!isCorrect) {
      if (++listLearningData[currWordIndex].numOfMistakes == 5) {
        _displayResult();
        return;
      }
      questionQueue
          .addLast(_buildQuestion(listLearningData[currWordIndex], currStep));
      indexWord.addLast(currWordIndex);
      indexStep.addLast(currStep);
    } else {
      listLearningData[currWordIndex].currStep++;
    }
    currStep = indexStep.removeFirst();
    currWordIndex = indexWord.removeFirst();
    _displayNextQuestion();
  }

  void _displayNextQuestion() {
    if (questionQueue.isNotEmpty) {
      Widget nextQuestion = questionQueue.removeFirst();
      currStep = indexStep.first;
      currWordIndex = indexWord.first;
      setState(() {
        currQuestion = nextQuestion;
      });
    } else {
      _displayResult();
    }
  }

  List<LearnData> getShuffledAnswers() {
    List<LearnData> temp = [...listLearningData];
    temp.shuffle();
    return temp.sublist(0, temp.length > 4 ? 4 : temp.length);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
  }

  void _initializeData() {
    final args =
        ModalRoute.of(context)!.settings.arguments as LearnringArguments;
    // Check arguments are not null
    _processArguments(args);
  }

  void _processArguments(LearnringArguments args) {
    listLearningData =
        args.words.map((e) => LearnData(word: e, numOfMistakes: 0)).toList();
    initMemoryLevels = args.memoryLevels;
    vocabularySetId = args.vocabularySetId;
    reviewReminderId = args.reviewReminderId;
    _prepareQuestionQueue(); // Moved into separate method
  }

  void _prepareQuestionQueue() {
    for (var step = 1; step <= totalStep; step++) {
      for (var index = 0; index < listLearningData.length; index++) {
        questionQueue.addLast(_buildQuestion(listLearningData[index], step));
        indexWord.addLast(index);
        indexStep.addLast(step);
      }
    }
    _displayNextQuestion();
  }

  @override
  Widget build(BuildContext context) {
    if (!_dataInitialized) {
      _initializeData();
      _dataInitialized = true;
    }
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const ColoredLine(
            height: 4.5,
            colorLeft: Colors.blue,
            colorRight: Colors.grey,
            percentLeft: 0.3,
            percentRight: 0.7,
          ),
          backgroundColor: Colors.grey.shade50,
          // title: Text(
          //   args.titleAppBar,
          //   style: Theme.of(context).textTheme.titleMedium!.copyWith(),
          // ),
          // centerTitle: true,
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
          actions: [
            IconButton(
                onPressed: () {
                  // Navigator.of(context).pushNamed('/learn-setting');
                  // setState(() {
                  // currStep = currStep + 1;
                  // if (currStep > 5) {
                  //   currStep = 1;
                  // }
                  // _checkAnswer('userAnswer');
                  // });
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/learning-result',
                      arguments: LearningResultArguments(
                          oldMemoryLevels: [],
                          learnedWords: [],
                          memoryLevels: []));
                },
                icon: const Icon(
                  Icons.settings_rounded,
                  color: Colors.grey,
                ))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: currQuestion,
        ));
  }

  Column _buldChooseWordQuestion(BuildContext context, WordEntity word) {
    List<LearnData> shuffledAnswers = getShuffledAnswers();
    return Column(children: [
      _buildQuoteRows(context, word),
      const Spacer(),
      Text('Chọn một đáp án',
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(color: Colors.black87)),
      const SizedBox(
        height: 5,
      ),
      ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return SizedBox(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  _checkAnswer(shuffledAnswers[index].word.content);
                },
                style: ButtonStyle(
                  // backgroundColor: MaterialStatePropertyAll(Colors.white),
                  // foregroundColor: MaterialStatePropertyAll(Colors.black),
                  // textStyle:,
                  side: MaterialStateProperty.all(
                      const BorderSide(color: Colors.grey)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12))),
                  elevation:
                      MaterialStateProperty.all(2), // Set the elevation value
                  // You can also set other properties like shadowColor if needed
                ),
                child: Text(shuffledAnswers[index].word.content),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return const SizedBox(
              height: 5,
            );
          },
          itemCount: shuffledAnswers.length),
      const SizedBox(
        height: 10,
      )
    ]);
  }

  Column _buildQuoteRows(BuildContext context, WordEntity word) {
    return Column(
      children: [
        word.pictures.isNotEmpty
            ? Container(
                margin: const EdgeInsets.all(16),
                height: 100,
                width: 130,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    word.pictures[0],
                    errorBuilder: (context, error, stackTrace) => Image.asset(
                      'assets/images/broken-image.png',
                      color: Colors.grey.shade300,
                      fit: BoxFit.cover,
                    ),
                    fit: BoxFit.fill,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
              )
            : const SizedBox.shrink(),
        const SizedBox(
          height: 10,
        ),
        ...List.generate(
            word.meanings.length,
            (index) => Row(
                  children: [
                    Text(
                      word.meanings[index].type!.name,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Colors.black87, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      '- ${word.meanings[index].meaning}',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Colors.black54, fontWeight: FontWeight.normal),
                    ),
                  ],
                )),
        const SizedBox(
          height: 10,
        ),
        ...List.generate(
            word.examples.length,
            (index) => Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.format_quote,
                      color: Colors.grey,
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Flexible(
                      child: Text(
                          word.examples[index].replaceAll(word.content, '____'),
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black87)),
                    )
                  ],
                )),
      ],
    );
  }

  Column _buildListeningQuestion(BuildContext context, WordEntity word) {
    return Column(children: [
      Expanded(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Nghe và viết lại từ',
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: Colors.black87),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 100,
                width: 100,
                child: ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12))),
                  ),
                  child: const Icon(
                    Icons.volume_up_rounded,
                    size: 50,
                  ),
                  onPressed: () {},
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              SizedBox(
                height: 50,
                width: 50,
                child: ElevatedButton(
                  style: ButtonStyle(
                      shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12))),
                      padding:
                          const MaterialStatePropertyAll(EdgeInsets.all(4))),
                  child: const Icon(
                    Icons.slow_motion_video,
                    size: 30,
                  ),
                  onPressed: () {},
                ),
              )
            ],
          ),
        ],
      )),
      _buildAnswerInput(context)
    ]);
  }

  Column _buildChooseMeaningQuestion(BuildContext context, WordEntity word) {
    List<LearnData> shuffledAnswers = getShuffledAnswers();
    return Column(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // _buildWritingQuestion(context),
        // _buildAnswerInput(context),
        Expanded(
            flex: 5,
            child: Center(
              child: Text(
                word.content,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: Colors.blue),
              ),
            )),
        // Spacer(),
        ListView.separated(
            // padding: EdgeInsets.only(bottom: 1),
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return SizedBox(
                height: 60,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    _checkAnswer(shuffledAnswers[index].word.content);
                  },
                  style: ButtonStyle(
                    // backgroundColor: MaterialStatePropertyAll(Colors.white),
                    // foregroundColor: MaterialStatePropertyAll(Colors.black),
                    // textStyle:,
                    side: MaterialStateProperty.all(
                        const BorderSide(color: Colors.grey)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12))),
                    elevation:
                        MaterialStateProperty.all(2), // Set the elevation value
                    // You can also set other properties like shadowColor if needed
                  ),
                  child: Text(shuffledAnswers[index].word.meanings[0].meaning),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(
                height: 5,
              );
            },
            itemCount: shuffledAnswers.length),
      ],
    );
  }

  Column _buildWritingQuestion(BuildContext context, WordEntity word) {
    return Column(
      children: [
        _buildQuoteRows(context, word),
        const Spacer(),
        _buildAnswerInput(context)
      ],
    );
  }

  TextField _buildAnswerInput(BuildContext context) {
    return TextField(
      controller: _answerController,
      style: const TextStyle(fontWeight: FontWeight.normal),
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.only(left: 18, top: 4, right: 4, bottom: 4),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(color: Colors.grey.shade200),
        ),
        // enabledBorder: OutlineInputBorder(
        //     borderRadius: BorderRadius.circular(18),
        //     borderSide: BorderSide(color: Colors.grey.shade200)),
        // focusedBorder: OutlineInputBorder(
        //     borderRadius: BorderRadius.circular(18),
        //     borderSide:
        //         BorderSide(color: Colors.grey.shade500, width: 1.2)),
        hintText: 'Nhập câu trả lời',
        alignLabelWithHint: true,

        prefixIcon: IconButton(
          icon: Icon(
            Icons.send,
            color: Theme.of(context).colorScheme.primary,
          ),
          onPressed: () {},
        ),
        suffixIcon: IconButton(
          icon: Icon(
            Icons.lightbulb,
            color: Theme.of(context).colorScheme.primary,
          ),
          onPressed: () {
            _showAnswerResult(
                context, listLearningData[indexWord.first].word, null);
          },
        ),
      ),
      onSubmitted: (value) {
        _checkAnswer(value);
        setState(() {
          _answerController.clear();
        });
      },
    );
  }
}

void _showAnswerResult(context, WordEntity word, bool? isCorrect) {
  setTimeout(callback, time) {
    Duration timeDelay = Duration(milliseconds: time);
    return Timer(timeDelay, callback);
  }

  setTimeout(
      () => showDialog<String>(
            context: context,
            builder: (BuildContext context) => Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              backgroundColor: Colors.white,
              surfaceTintColor: Colors.white,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  isCorrect != null
                      ? Container(
                          width: double.infinity,
                          // height: 30,
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 8),
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(12),
                                topRight: Radius.circular(12)),
                            color:
                                isCorrect ? Colors.green.shade400 : Colors.red,
                          ),
                          child: Text(
                            isCorrect ? 'CHÍNH XÁC!' : 'CHƯA CHÍNH XÁC',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(
                                    color: isCorrect
                                        ? Colors.black87
                                        : Colors.white),
                          ),
                        )
                      : const SizedBox.shrink(),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Column(
                      children: [
                        WordDetailInVocaSet(
                          wordEntity: word,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(isCorrect != null ? 'Tiếp tục' : "Đóng"),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
      200);
}

class LearnData {
  final WordEntity word;
  int numOfMistakes;
  int currStep;
  LearnData(
      {required this.word, required this.numOfMistakes, this.currStep = 0});
}

class LearningResultArguments {
  List<WordEntity> learnedWords = [];
  List<int> memoryLevels = [];
  List<int> oldMemoryLevels = [];

  LearningResultArguments(
      {required this.learnedWords,
      required this.memoryLevels,
      required this.oldMemoryLevels});
}
