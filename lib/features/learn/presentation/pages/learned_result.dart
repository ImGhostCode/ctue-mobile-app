import 'package:ctue_app/core/constants/memory_level_constants.dart';
import 'package:ctue_app/features/learn/presentation/pages/learn_page.dart';
import 'package:ctue_app/features/profile/presentation/widgets/radial_bar_chart.dart';
import 'package:ctue_app/features/word/business/entities/word_entity.dart';
import 'package:flutter/material.dart';

class LearningResult extends StatelessWidget {
  const LearningResult({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as LearningResultArguments;

    List<WordEntity> rememberedWords = [];
    List<WordEntity> forgotWords = [];
    List<int> rememberedMemoryLevels = [];
    List<int> forgotMemoryLevels = [];

    for (int i = 0; i < args.learnedWords.length; i++) {
      if (args.memoryLevels[i] > args.oldMemoryLevels[i]) {
        rememberedWords.add(args.learnedWords[i]);
        rememberedMemoryLevels.add(args.memoryLevels[i]);
      } else {
        forgotWords.add(args.learnedWords[i]);
        forgotMemoryLevels.add(args.memoryLevels[i]);
      }
    }

    return Scaffold(
      appBar: AppBar(
          // centerTitle: true,
          // title: null,
          backgroundColor: Colors.white,
          scrolledUnderElevation: 0,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.close,
              size: 30,
            ),
          )),
      body: Container(
        decoration: const BoxDecoration(color: Colors.white),
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          SizedBox(
            height: 150,
            width: 250,
            child: Image.asset('assets/images/congratulation.png'),
          ),
          Text(
            '${rememberedWords.isNotEmpty ? 'Chúc mừng! ' : ''}Bạn hãy tiếp tục học để giỏi hơn nữa nhé!!!',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    height: 30,
                    width: 30,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.green.shade500),
                    child: const Icon(
                      Icons.north,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    '${rememberedWords.length} từ',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
              ),
              Wrap(
                spacing: 6,
                alignment: WrapAlignment.start,
                children: [
                  ...List.generate(rememberedWords.length, (index) {
                    MemoryLevel level =
                        getMemoryLevel(rememberedMemoryLevels[index]);
                    return Chip(
                      backgroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 6),
                      shape: RoundedRectangleBorder(
                          side: const BorderSide(width: 2, color: Colors.green),
                          borderRadius: BorderRadius.circular(20)),
                      avatar: RadialBarChart(
                          fontWeight: FontWeight.normal,
                          radius: '100%',
                          innerRadius: '70%',
                          title: level.title,
                          color: level.color,
                          initialPercent: level.percent,
                          diameter: level.diameter,
                          fontSize: level.fontSize),
                      label: Text(rememberedWords[index].content),
                    );
                  })
                ],
              )
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    height: 30,
                    width: 30,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Colors.redAccent),
                    child: const Icon(
                      Icons.south,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    '${forgotWords.length} từ',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
              ),
              Wrap(
                spacing: 6,
                alignment: WrapAlignment.start,
                children: [
                  ...List.generate(forgotWords.length, (index) {
                    MemoryLevel level =
                        getMemoryLevel(forgotMemoryLevels[index]);
                    return Chip(
                      backgroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 6),
                      shape: RoundedRectangleBorder(
                          side: const BorderSide(
                              width: 2, color: Colors.redAccent),
                          borderRadius: BorderRadius.circular(20)),
                      avatar: RadialBarChart(
                          fontWeight: FontWeight.normal,
                          radius: '100%',
                          innerRadius: '70%',
                          title: level.title,
                          color: level.color,
                          initialPercent: level.percent,
                          diameter: level.diameter,
                          fontSize: level.fontSize),
                      label: Text(forgotWords[index].content),
                    );
                  })
                ],
              )
            ],
          ),
        ]),
      ),
    );
  }
}

MemoryLevel getMemoryLevel(int level) {
  switch (level) {
    case 1:
      return level_1;
    case 2:
      return level_2;
    case 3:
      return level_3;
    case 4:
      return level_4;
    case 5:
      return level_5;
    case 6:
      return level_6;
    default:
      return level_1;
  }
}
