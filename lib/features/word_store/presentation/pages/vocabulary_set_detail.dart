import 'package:ctue_app/core/constants/constants.dart';
import 'package:ctue_app/features/word_store/presentation/widgets/statistic_chart.dart';
import 'package:ctue_app/features/word_store/presentation/widgets/reminder.dart';
import 'package:ctue_app/features/word_store/presentation/widgets/word_detail_%20in_voca_set.dart';
import 'package:flutter/material.dart';

class VocabularySetDetail extends StatefulWidget {
  const VocabularySetDetail({super.key});

  @override
  State<VocabularySetDetail> createState() => _VocabularySetDetailState();
}

class _VocabularySetDetailState extends State<VocabularySetDetail> {
  String sortBy = 'Mới nhất';

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as VocabularySetArguments;

    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Đêm giao thừa',
            style: Theme.of(context).textTheme.titleMedium,
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
          )),
      body: SingleChildScrollView(
        child: Container(
          // height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(16),
          color: Colors.grey.shade200,
          child: Column(
            children: [
              StatisticChart(),
              const SizedBox(
                height: 20,
              ),
              const Reminder(),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 40,
                child: SearchBar(
                  hintText: 'Tìm bằng từ hoặc nghĩa',
                  // padding: MaterialStatePropertyAll(
                  //     EdgeInsets.symmetric(vertical: 0, horizontal: 16)),
                  overlayColor:
                      const MaterialStatePropertyAll(Colors.transparent),
                  hintStyle: MaterialStatePropertyAll<TextStyle>(TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 14,
                      fontWeight: FontWeight.normal)),
                  elevation: const MaterialStatePropertyAll(0),
                  shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12))),
                  backgroundColor: const MaterialStatePropertyAll(Colors.white),
                  onSubmitted: ((value) {
                    if (value.isNotEmpty) {
                      // Navigator.pushNamed(
                      //   context,
                      //   '/search-voca-set',
                      //   arguments: SearchVocaSetArgument(
                      //       titleAppBar: 'Tìm kiếm bộ từ', title: value),
                      // );
                    }
                  }),
                  leading: Icon(
                    Icons.search,
                    size: 28,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                Text(
                  'Xếp theo: ',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(color: Colors.blue),
                ),
                Text(
                  sortBy,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Colors.blue, fontWeight: FontWeight.bold),
                ),
                PopupMenuButton<String>(
                  icon: const Icon(Icons.sort),
                  onSelected: (value) {
                    setState(() {
                      sortBy = value;
                    });
                  },
                  color: Colors.white,
                  itemBuilder: (BuildContext context) =>
                      <PopupMenuEntry<String>>[
                    const PopupMenuItem<String>(
                      value: 'Mới nhất',
                      child: Text('Mới nhất'),
                    ),
                    const PopupMenuItem<String>(
                      value: 'Chưa học',
                      child: Text('Chưa học'),
                    ),
                    // Add more items if needed
                  ],
                ),
              ]),

              ...List.generate(5, (index) => WordDetailInVocaSet())
              // Expanded(
              //   child: ListView.builder(
              //       physics: const NeverScrollableScrollPhysics(),
              //       scrollDirection: Axis.vertical,
              //       itemBuilder: (context, index) {
              //         return WordDetailInVocaSet();
              //       },
              //       // separatorBuilder: (context, index) {
              //       //   return const SizedBox(
              //       //     height: 5,
              //       //   );
              //       // },
              //       itemCount: 4),
              // )
            ],
          ),
        ),
      ),
    );
  }
}

// class VocabularySetArguments {
//   final int id;

//   VocabularySetArguments({required this.id});
// }
