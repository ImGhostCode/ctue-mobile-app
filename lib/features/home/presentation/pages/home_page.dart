import 'package:ctue_app/features/word/presentation/widgets/look_up_dic_bar.dart';
import 'package:ctue_app/features/word_store/presentation/widgets/reminder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  bool isDark = false;

  @override
  Widget build(BuildContext context) {
    final List<LearningSource> _learningSources = [
      LearningSource(
        icon: Icons.abc,
        title: 'Bảng phiên âm IPA',
        bgColor: Colors.green,
        onTap: () {
          Navigator.pushNamed(context, '/api');
        },
      ),
      LearningSource(
        icon: Icons.record_voice_over_outlined,
        title: 'Mẫu câu giao tiếp',
        bgColor: Colors.blueAccent,
        onTap: () {
          Navigator.pushNamed(context, '/communication-phrases');
        },
      ),
      LearningSource(
        icon: Icons.menu_book,
        title: 'Từ điển',
        bgColor: Colors.yellow,
        onTap: () {
          Navigator.pushNamed(context, '/dictionary');
        },
      ),
      LearningSource(
        icon: Icons.article,
        title: 'Động từ bất quy tắc',
        bgColor: Colors.orange,
        onTap: () {
          Navigator.pushNamed(context, '/irregular-verb');
        },
      ),
      LearningSource(
        icon: Icons.sports_esports,
        title: 'Game',
        bgColor: Colors.teal.shade400,
        onTap: () {
          Navigator.pushNamed(context, '/games');
        },
      ),
    ];

    return Scaffold(
        appBar: AppBar(
          // centerTitle: true,
          title: Image.asset(
              'assets/images/ctue-high-resolution-logo-transparent2.png',
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
        body: SingleChildScrollView(
            child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(color: Colors.grey.shade100),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Từ điển',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      LookUpDicBar()
                    ],
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),

                // Text(
                //   'Đề xuất cho bạn',
                //   style: Theme.of(context).textTheme.titleLarge,
                // ),
                // SizedBox(
                //   height: 90.0, // Set a fixed height for the ListView
                //   child: ListView.builder(
                //     scrollDirection: Axis.horizontal,
                //     itemCount: 1, // Number of items in your list
                //     itemBuilder: (BuildContext context, int index) {
                //       return Padding(
                //         padding: const EdgeInsets.all(8.0),
                //         child: Column(
                //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //           children: [
                //             ClipRRect(
                //               borderRadius: BorderRadius.circular(10),
                //               child: Image.asset(
                //                 'assets/images/chatbot.png',
                //                 height: 52,
                //                 width: 52,
                //               ),
                //             ),
                //             Text(
                //               'CTUE AI',
                //               style: Theme.of(context).textTheme.bodyMedium,
                //             )
                //           ],
                //         ),
                //       );
                //     },
                //   ),
                // ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Reminder(),
                ),

                const SizedBox(
                  height: 8,
                ),

                Container(
                  height: 240,
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(color: Colors.white),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Nguồn học',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Expanded(
                        child: GridView.builder(
                          itemCount: _learningSources.length,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            crossAxisSpacing: 18,
                            mainAxisSpacing: 16,
                          ),
                          primary: false,
                          // padding: const EdgeInsets.all(8),
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: _learningSources[index].onTap,
                              child: Column(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(bottom: 5),
                                    padding: const EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                      color: _learningSources[index].bgColor,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Icon(
                                      _learningSources[index].icon,
                                      size: 26,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    _learningSources[index].title,
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                        ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
        )));
  }
}

class LearningSource {
  final IconData icon;
  final String title;
  final Color bgColor;
  final VoidCallback onTap;

  LearningSource(
      {required this.icon,
      required this.title,
      required this.bgColor,
      required this.onTap});
}
