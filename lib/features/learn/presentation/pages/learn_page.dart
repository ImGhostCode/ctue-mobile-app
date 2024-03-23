import 'package:ctue_app/features/profile/presentation/widgets/colored_line.dart';
import 'package:ctue_app/features/vocabulary_set/presentation/widgets/word_detail_%20in_voca_set.dart';
import 'package:ctue_app/features/word/business/entities/word_entity.dart';
import 'package:flutter/material.dart';

class LearnPage extends StatefulWidget {
  const LearnPage({Key? key}) : super(key: key);

  @override
  State<LearnPage> createState() => _LearnPageState();
}

class _LearnPageState extends State<LearnPage> {
  int totalStep = 5;
  int currStep = 1;
  Widget? currQuestion;
  // List<String> learnData = ['word1', 'word2', 'word3', 'word4', 'word5'];
  List<LearnData> learnData = [
    LearnData(word: 'word1', numOfMistakes: 0, currStep: 1),
    LearnData(word: 'word2', numOfMistakes: 0, currStep: 1),
  ];
  int currWordIndex = 0;
  // dynamic currAnswer;
  // int correctIndex = 0;

  void _displayQuestion(LearnData learnData) {
    // Logic to select the appropriate question type
    // Update UI based on the selected question
    switch (learnData.currStep) {
      case 1:
        print('writting question: ${learnData.word}');
        currQuestion = _buildWritingQuestion(context, learnData.word);
        break;
      case 2:
        print('choose meaning question: ${learnData.word}');
        currQuestion = _buildChooseMeaningQuestion(context, learnData.word);
        break;
      case 3:
        print('listening question: ${learnData.word}');
        currQuestion = _buildListeningQuestion(context, learnData.word);
        break;
      case 4:
        print('choose word question: ${learnData.word}');
        currQuestion = _buldChooseWordQuestion(context, learnData.word);
        break;
      case 5:
        _displayResult();
        // TODO check if any word is not at step 5 then show question this word
        break;
      default:
    }
  }

  void _displayResult() {
    print('Display result...');
  }

  void _checkAnswer(dynamic userAnswer) {
    print(userAnswer);
    print(learnData[currWordIndex].word);
    bool isCorrect = learnData[currWordIndex].word == userAnswer;
    print('Checking answer... ${isCorrect}');
    if (!isCorrect) {
      learnData[currWordIndex].numOfMistakes++;
      if (learnData[currWordIndex].numOfMistakes >= totalStep) {
        _displayResult();
      }
    } else {
      learnData[currWordIndex].currStep++;
    }
    _next();
    setState(() {});
  }

  void _next() {
    if (currWordIndex < (learnData.length - 1)) {
      currWordIndex++;
    } else {
      // currStep = currStep + 1;
      currWordIndex = 0;
    }
  }

  List<LearnData> getShuffledAnswers() {
    List<LearnData> temp = [...learnData];
    temp.shuffle();
    return temp.sublist(0, temp.length > 4 ? 4 : temp.length);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _displayQuestion(learnData[currWordIndex]);

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
                  _checkAnswer('userAnswer');
                  // });
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

  Column _buldChooseWordQuestion(BuildContext context, String word) {
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
                  _checkAnswer(shuffledAnswers[index].word);
                },
                child: Text(shuffledAnswers[index].word),
                style: ButtonStyle(
                  // backgroundColor: MaterialStatePropertyAll(Colors.white),
                  // foregroundColor: MaterialStatePropertyAll(Colors.black),
                  // textStyle:,
                  side:
                      MaterialStateProperty.all(BorderSide(color: Colors.grey)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12))),
                  elevation:
                      MaterialStateProperty.all(2), // Set the elevation value
                  // You can also set other properties like shadowColor if needed
                ),
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

  Column _buildQuoteRows(BuildContext context, String word) {
    return Column(
      children: [
        // Test
        Text(word),
        //
        Container(
          height: 100,
          width: 130,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              'https://cdn-blog.novoresume.com/articles/career-aptitude-test/bg.png',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        ...List.generate(
            2,
            (index) => Row(
                  children: [
                    Text(
                      'Danh từ.',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Colors.black87, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      '- thử nghiệm, thử, kiểm tra',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Colors.black54, fontWeight: FontWeight.normal),
                    ),
                  ],
                )),
        const SizedBox(
          height: 10,
        ),
        ...List.generate(
            2,
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
                          'The class are doing/having a spelling ___ today. dddd ddd ddd dd',
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

  Column _buildListeningQuestion(BuildContext context, String word) {
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
                      padding: MaterialStatePropertyAll(EdgeInsets.all(4))),
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

  Column _buildChooseMeaningQuestion(BuildContext context, String word) {
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
                word,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: Colors.blue),
              ),
            )),
        // Spacer(),
        Expanded(
          flex: 3,
          child: ListView.separated(
              // padding: EdgeInsets.only(bottom: 1),
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return SizedBox(
                  height: 60,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      _checkAnswer(shuffledAnswers[index].word);
                    },
                    child: Text(shuffledAnswers[index].word),
                    style: ButtonStyle(
                      // backgroundColor: MaterialStatePropertyAll(Colors.white),
                      // foregroundColor: MaterialStatePropertyAll(Colors.black),
                      // textStyle:,
                      side: MaterialStateProperty.all(
                          BorderSide(color: Colors.grey)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12))),
                      elevation: MaterialStateProperty.all(
                          2), // Set the elevation value
                      // You can also set other properties like shadowColor if needed
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(
                  height: 5,
                );
              },
              itemCount: shuffledAnswers.length),
        ),
      ],
    );
  }

  Column _buildWritingQuestion(BuildContext context, String word) {
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
            Icons.mic,
            color: Theme.of(context).colorScheme.primary,
          ),
          onPressed: () {},
        ),
        suffixIcon: IconButton(
          icon: Icon(
            Icons.lightbulb,
            color: Theme.of(context).colorScheme.primary,
          ),
          onPressed: () {},
        ),
      ),
      onSubmitted: (value) {
        _checkAnswer(value);
        value = '';
      },
    );
  }
}

void _showAnswerDialog(context, String word) {
  showDialog<String>(
    context: context,
    builder: (BuildContext context) => Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // Test
          Text(word),
          // Test
          Container(
            width: double.infinity,
            // height: 30,
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12), topRight: Radius.circular(12)),
              color: Colors.green.shade400,
            ),
            child: Text(
              'CHÍNH XÁC!',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: Colors.black87),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Column(
              children: [
                WordDetailInVocaSet(),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Tiếp tục'),
                ),
              ],
            ),
          )
        ],
      ),
    ),
  );
}

class LearnData {
  final String word;
  int numOfMistakes;
  int currStep;
  LearnData(
      {required this.word, required this.numOfMistakes, this.currStep = 0});
}
