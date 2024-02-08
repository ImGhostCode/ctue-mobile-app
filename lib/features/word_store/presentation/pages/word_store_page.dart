import 'package:ctue_app/core/constants/constants.dart';
import 'package:ctue_app/features/word_store/presentation/pages/spaced_repetition_detail.dart';
import 'package:ctue_app/features/word_store/presentation/providers/statistic_chart.dart';
import 'package:ctue_app/features/word_store/presentation/widgets/reminder.dart';
import 'package:flutter/material.dart';

class WordStorePage extends StatefulWidget {
  const WordStorePage({Key? key}) : super(key: key);

  @override
  State<WordStorePage> createState() => _WordStorePageState();
}

enum SampleItem { itemOne, itemTwo, itemThree }

class _WordStorePageState extends State<WordStorePage> {
  final List<VocabularySet> _vocabularySets = [
    VocabularySet(
        title: 'Default',
        image:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSBO6Wl5_gZWvGZN_-cJJzEVLhJo9Y0uauwnw&usqp=CAU'),
    VocabularySet(
        title: 'Figures of speech',
        image:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSBO6Wl5_gZWvGZN_-cJJzEVLhJo9Y0uauwnw&usqp=CAU')
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        SliverAppBar(
          title: Image.asset(
              'assets/images/ctue-high-resolution-logo-transparent2.png',
              fit: BoxFit.fill,
              width: 150),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/notification');
                },
                icon: const Icon(
                  Icons.notifications,
                  color: Colors.white,
                  size: 28,
                ))
          ],
        ),
        SliverList(
            delegate: SliverChildListDelegate([
          Container(
            decoration: BoxDecoration(color: Colors.grey.shade100),
            child: Stack(
              children: [
                Container(
                  height: 160,
                  width: double.infinity,
                  color: Colors.blue.shade800,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const SpacedRepetitionDetail()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Wrap(
                      children: [
                        Text(
                            'Học ít - Nhớ sâu từ vựng với phương phát khoa học',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                    fontWeight: FontWeight.normal,
                                    color: Colors.white)),
                        const Text('Spaced Repetition ',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                decoration: TextDecoration.underline,
                                decorationColor: Colors.white,
                                color: Colors.white)),
                        const Icon(
                          Icons.info_outline,
                          color: Colors.white,
                          size: 18,
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 390,
                ),
                Positioned(
                    top: 60, // Center vertically
                    left: 16,
                    child: StatisticChart())
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            color: Colors.grey.shade200,
            child: Reminder(),
          ),
          _buildVocabularySetManagement(context),
          const SizedBox(
            height: 10,
          ),
        ])),
      ],
    ));
  }

  Container _buildVocabularySetManagement(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.grey.shade100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Bộ từ của bạn',
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  child: Container(
                height: 50,
                margin: const EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12)),
                child: ElevatedButton(
                  style: ButtonStyle(
                      shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: BorderSide.none)),
                      elevation: const MaterialStatePropertyAll(0),
                      backgroundColor:
                          const MaterialStatePropertyAll(Colors.white)),
                  onPressed: () {
                    Navigator.pushNamed(context, '/create-vocabulary-set');
                  },
                  child: Row(children: [
                    const Icon(
                      Icons.create_new_folder_rounded,
                      color: Colors.teal,
                    ),
                    const SizedBox(
                      width: 3,
                    ),
                    Text(
                      'Tạo bộ từ mới',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: Colors.black),
                    )
                  ]),
                ),
              )),
              Expanded(
                  child: Container(
                height: 50,
                margin: const EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12)),
                child: ElevatedButton(
                  style: ButtonStyle(
                      shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: BorderSide.none)),
                      elevation: const MaterialStatePropertyAll(0),
                      backgroundColor:
                          const MaterialStatePropertyAll(Colors.white)),
                  onPressed: () {
                    Navigator.pushNamed(context, '/vocabulary-sets');
                  },
                  child: Row(children: [
                    const Icon(
                      Icons.library_books,
                      color: Colors.teal,
                    ),
                    const SizedBox(
                      width: 3,
                    ),
                    Text(
                      'Tải bộ từ',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: Colors.black),
                    )
                  ]),
                ),
              )),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          _buildListVocabularySets()
        ],
      ),
    );
  }

  SizedBox _buildListVocabularySets() {
    return SizedBox(
      height: 500,
      child: ListView.separated(
        separatorBuilder: (context, index) {
          return const SizedBox(
            height: 3,
          );
        },
        physics: const NeverScrollableScrollPhysics(),
        itemCount: _vocabularySets.length,
        itemBuilder: (context, index) {
          return Card(
              color: Colors.white, // Set the background color here
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/vocabulary-set-detail',
                      arguments: VocabularySetArguments(id: index));
                },
                child: ListTile(
                  contentPadding: const EdgeInsets.all(12),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  tileColor: Colors.white,
                  leading: _vocabularySets[index].title == 'Default'
                      ? Container(
                          height: 55,
                          width: 55,
                          decoration: BoxDecoration(
                            // color: const Color(0xff7c94b6),
                            color: Colors.blue.shade50,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.folder,
                            color: Colors.blue,
                            size: 30,
                          ),
                        )
                      : Container(
                          height: 55,
                          width: 55,
                          decoration: BoxDecoration(
                            // color: const Color(0xff7c94b6),
                            image: const DecorationImage(
                              image: NetworkImage(
                                  'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg'),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                  title: Text(_vocabularySets[index].title),
                  trailing: _vocabularySets[index].title != 'Default'
                      ? IconButton(
                          icon: const Icon(Icons.more_vert),
                          onPressed: () => showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              // title: Text(
                              //   'AlertDialog Title $index',
                              // ),
                              buttonPadding: EdgeInsets.zero,
                              contentPadding: EdgeInsets.zero,
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(3)),
                              content: SizedBox(
                                height: 65,
                                width: MediaQuery.of(context).size.width - 100,
                                child: ListView(children: [
                                  TextButton(
                                      style: const ButtonStyle(
                                          shape: MaterialStatePropertyAll(
                                              RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.zero)),
                                          backgroundColor:
                                              MaterialStatePropertyAll(
                                                  Colors.white)),
                                      onPressed: () {},
                                      child: const Text(
                                          textAlign: TextAlign.left,
                                          'Đổi tên')),
                                  TextButton(
                                      style: const ButtonStyle(
                                          padding: MaterialStatePropertyAll(
                                              EdgeInsets.all(8)),
                                          shape: MaterialStatePropertyAll(
                                              RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.zero)),
                                          backgroundColor:
                                              MaterialStatePropertyAll(
                                                  Colors.white)),
                                      onPressed: () {},
                                      child: const Text(
                                          textAlign: TextAlign.right, 'Xóa'))
                                ]),
                              ),
                              // actions: <Widget>[
                              //   TextButton(
                              //     onPressed: () =>
                              //         Navigator.pop(context, 'Cancel'),
                              //     child: const Text('Cancel'),
                              //   ),
                              //   TextButton(
                              //     onPressed: () => Navigator.pop(context, 'OK'),
                              //     child: const Text('OK'),
                              //   ),
                              // ],
                            ),
                          ),
                        )
                      : null,
                ),
              ));
        },
      ),
    );
  }
}

class VocabularySet {
  final String? image;
  final String title;

  VocabularySet({this.image, required this.title});
}

// class VocabularySetArguments {
//   final int id;

//   VocabularySetArguments({required this.id});
// }
