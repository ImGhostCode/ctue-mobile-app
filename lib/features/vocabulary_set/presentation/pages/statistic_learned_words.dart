import 'package:ctue_app/features/vocabulary_set/presentation/widgets/word_detail_%20in_voca_set.dart';
import 'package:flutter/material.dart';

class StatisticLearnedWordPage extends StatelessWidget {
  const StatisticLearnedWordPage({super.key});

  @override
  Widget build(BuildContext context) {
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
      body: SingleChildScrollView(
        child: DefaultTabController(
            initialIndex: 0,
            length: 6,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TabBar(
                  tabAlignment: TabAlignment.center,
                  indicatorSize: TabBarIndicatorSize.tab,
                  onTap: (value) {
                    print(value);
                  },
                  isScrollable: true,
                  tabs: <Widget>[
                    Tab(
                      text: 'Cấp độ 1 (1)',
                    ),
                    Tab(
                      text: "Cấp độ 2 (1)",
                    ),
                    Tab(
                      text: "Cấp độ 3 (0)",
                    ),
                    Tab(
                      text: "Cấp độ 4 (0)",
                    ),
                    Tab(
                      text: "Cấp độ 5 (0)",
                    ),
                    Tab(
                      text: "Nhớ sâu (0)",
                    ),
                  ],
                ),
                Container(
                  decoration: BoxDecoration(color: Colors.grey.shade200),
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children:
                        List.generate(2, (index) => WordDetailInVocaSet()),
                  ),
                )
              ],
            )),
      ),
    );
  }
}
