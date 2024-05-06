import 'package:ctue_app/features/learn/presentation/widgets/statistic_chart.dart';
import 'package:ctue_app/features/vocabulary_pack/presentation/widgets/word_detail_in_voca_set.dart';
import 'package:flutter/material.dart';

class StatisticLearnedWordPage extends StatelessWidget {
  const StatisticLearnedWordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as StatisLearnedWordArgument;

    final dataStatistics = args.dataStatistics.detailVocaSetStatisEntity;

    return Scaffold(
      appBar: AppBar(
          forceMaterialTransparency: true,
          centerTitle: true,
          title: Text(
            'Cấp độ nhớ',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          backgroundColor: Colors.transparent,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.chevron_left_rounded,
              size: 30,
            ),
          )),
      body: DefaultTabController(
          initialIndex: 0,
          length: 6,
          child: Column(
            // mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TabBar(
                tabAlignment: TabAlignment.center,
                indicatorSize: TabBarIndicatorSize.tab,
                onTap: (value) {
                  // print(value);
                },
                labelStyle: Theme.of(context).textTheme.bodyMedium,
                isScrollable: true,
                tabs: <Widget>[
                  Tab(
                    text: 'Cấp độ 1 (${dataStatistics.level_1.length})',
                  ),
                  Tab(
                    text: "Cấp độ 2 (${dataStatistics.level_2.length})",
                  ),
                  Tab(
                    text: "Cấp độ 3 (${dataStatistics.level_3.length})",
                  ),
                  Tab(
                    text: "Cấp độ 4 (${dataStatistics.level_4.length})",
                  ),
                  Tab(
                    text: "Cấp độ 5 (${dataStatistics.level_5.length})",
                  ),
                  Tab(
                    text: "Nhớ sâu (${dataStatistics.level_6.length})",
                  ),
                ],
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(color: Colors.grey.shade200),
                  padding: const EdgeInsets.all(16.0),
                  child: TabBarView(
                    children: <Widget>[
                      SingleChildScrollView(
                        child: Column(
                          children: List.generate(
                              dataStatistics.level_1.length,
                              (index) => WordDetailInVocaSet(
                                    wordEntity:
                                        dataStatistics.level_1[index].word,
                                    showLevel: true,
                                    memoryLevel: dataStatistics
                                        .level_1[index].memoryLevel,
                                  )).toList(),
                        ),
                      ),
                      SingleChildScrollView(
                        child: Column(
                          children: List.generate(
                              dataStatistics.level_2.length,
                              (index) => WordDetailInVocaSet(
                                    wordEntity:
                                        dataStatistics.level_2[index].word,
                                    showLevel: true,
                                    memoryLevel: dataStatistics
                                        .level_2[index].memoryLevel,
                                  )).toList(),
                        ),
                      ),
                      SingleChildScrollView(
                        child: Column(
                          children: List.generate(
                              dataStatistics.level_3.length,
                              (index) => WordDetailInVocaSet(
                                    wordEntity:
                                        dataStatistics.level_3[index].word,
                                    showLevel: true,
                                    memoryLevel: dataStatistics
                                        .level_3[index].memoryLevel,
                                  )).toList(),
                        ),
                      ),
                      SingleChildScrollView(
                        child: Column(
                          children: List.generate(
                              dataStatistics.level_4.length,
                              (index) => WordDetailInVocaSet(
                                    wordEntity:
                                        dataStatistics.level_4[index].word,
                                    showLevel: true,
                                    memoryLevel: dataStatistics
                                        .level_4[index].memoryLevel,
                                  )).toList(),
                        ),
                      ),
                      SingleChildScrollView(
                        child: Column(
                          children: List.generate(
                              dataStatistics.level_5.length,
                              (index) => WordDetailInVocaSet(
                                    wordEntity:
                                        dataStatistics.level_5[index].word,
                                    showLevel: true,
                                    memoryLevel: dataStatistics
                                        .level_5[index].memoryLevel,
                                  )).toList(),
                        ),
                      ),
                      SingleChildScrollView(
                        child: Column(
                          children: List.generate(
                              dataStatistics.level_6.length,
                              (index) => WordDetailInVocaSet(
                                    wordEntity:
                                        dataStatistics.level_6[index].word,
                                    showLevel: true,
                                    memoryLevel: dataStatistics
                                        .level_6[index].memoryLevel,
                                  )).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
