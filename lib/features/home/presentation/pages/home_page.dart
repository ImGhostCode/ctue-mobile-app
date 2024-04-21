import 'package:ctue_app/core/constants/constants.dart';
import 'package:ctue_app/core/errors/failure.dart';
import 'package:ctue_app/features/home/presentation/providers/home_provider.dart';
import 'package:ctue_app/features/home/presentation/widgets/recent_widget.dart';
import 'package:ctue_app/features/learn/presentation/providers/learn_provider.dart';
import 'package:ctue_app/features/notification/presentation/widgets/notification_icon.dart';
import 'package:ctue_app/features/skeleton/widgets/custom_error_widget.dart';
import 'package:ctue_app/features/word/presentation/widgets/look_up_dic_bar.dart';
import 'package:ctue_app/features/learn/presentation/widgets/action_box.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  // bool isDark = false;

  @override
  Widget build(BuildContext context) {
    final List<LearningSource> learningSources = [
      LearningSource(
        icon: Icons.abc,
        title: 'Bảng phiên âm IPA',
        bgColor: Colors.green,
        onTap: () {
          Navigator.pushNamed(context, RouteNames.ipa);
          Provider.of<HomeProvider>(context, listen: false)
              .saveRecentPage(RouteNames.ipa);
        },
      ),
      LearningSource(
        icon: Icons.record_voice_over_outlined,
        title: 'Mẫu câu giao tiếp',
        bgColor: Colors.blueAccent,
        onTap: () {
          Navigator.pushNamed(context, RouteNames.communicationPhrases);
          Provider.of<HomeProvider>(context, listen: false)
              .saveRecentPage(RouteNames.communicationPhrases);
        },
      ),
      LearningSource(
        icon: Icons.menu_book,
        title: 'Từ điển',
        bgColor: Colors.yellow,
        onTap: () {
          Navigator.pushNamed(context, RouteNames.dictionary);
          Provider.of<HomeProvider>(context, listen: false)
              .saveRecentPage(RouteNames.dictionary);
        },
      ),
      LearningSource(
        icon: Icons.article,
        title: 'Động từ bất quy tắc',
        bgColor: Colors.orange,
        onTap: () {
          Navigator.pushNamed(context, RouteNames.irregularVerbs);
          Provider.of<HomeProvider>(context, listen: false)
              .saveRecentPage(RouteNames.irregularVerbs);
        },
      ),
      // LearningSource(
      //   icon: Icons.sports_esports,
      //   title: 'Game',
      //   bgColor: Colors.teal.shade400,
      //   onTap: () {
      //     Navigator.pushNamed(context, '/games');
      //   },
      // ),
    ];

    if (Provider.of<LearnProvider>(context, listen: false).upcomingReminder ==
            null ||
        Provider.of<LearnProvider>(context, listen: false).currReminder ==
            null) {
      Provider.of<LearnProvider>(context, listen: false)
          .eitherFailureOrGetUpcomingReminder(null);
    }

    return Scaffold(
        appBar: AppBar(
          // centerTitle: true,
          title: Image.asset(
              'assets/images/ctue-high-resolution-logo-transparent2.png',
              width: 150),

          actions: const [NotificationIcon()],
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
                  padding: const EdgeInsets.all(16),
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
                      const LookUpDicBar()
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Consumer<LearnProvider>(
                  builder: (context, provider, child) {
                    bool isLoading = provider.isLoading;

                    Failure? failure = provider.failure;

                    if (failure != null) {
                      // Handle failure, for example, show an error message
                      // return Text(failure.errorMessage);
                      return CustomErrorWidget(
                          title: failure.errorMessage,
                          onTryAgain: () {
                            Provider.of<LearnProvider>(context, listen: false)
                                .eitherFailureOrGetUpcomingReminder(null);
                          });
                    }
                    // else if (!isLoading && provider.currReminder != null) {
                    //   return Container(
                    //     decoration: const BoxDecoration(color: Colors.white),
                    //     padding: const EdgeInsets.all(16.0),
                    //     child: ActionBox(
                    //       vocabularySetId:
                    //           provider.currReminder!.vocabularySetId,
                    //       words: provider.currReminder!.learnedWords
                    //           .map((e) => e.word!)
                    //           .toList(),
                    //       reviewAt: provider.currReminder!.reviewAt,
                    //       userLearnedWords: provider.currReminder!.learnedWords,
                    //     ),
                    //   );
                    // }
                    else if (!isLoading && provider.upcomingReminder != null) {
                      return Container(
                        decoration: const BoxDecoration(color: Colors.white),
                        padding: const EdgeInsets.all(16.0),
                        child: ActionBox(
                          reviewReminderId: provider.upcomingReminder!.id,
                          vocabularySetId:
                              provider.upcomingReminder!.vocabularySetId,
                          words: provider.upcomingReminder!.learnedWords
                              .map((e) => e.word!)
                              .toList(),
                          reviewAt: provider.upcomingReminder!.reviewAt,
                          userLearnedWords:
                              provider.upcomingReminder!.learnedWords,
                        ),
                      );
                    } else {
                      return Skeletonizer(
                          enabled: isLoading,
                          child: Container(
                            decoration:
                                const BoxDecoration(color: Colors.white),
                            padding: const EdgeInsets.all(16.0),
                            child: ActionBox(
                              isLoadingPage: isLoading,
                              vocabularySetId: -1,
                              words: const [],
                            ),
                          ));
                    }
                  },
                ),

                /*
                 return const Center(
                          child: Text(
                              'Không có dữ liệu'));
                */

                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(16),
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
                          itemCount: learningSources.length,
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
                              onTap: learningSources[index].onTap,
                              child: Column(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(bottom: 5),
                                    padding: const EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                      color: learningSources[index].bgColor,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Icon(
                                      learningSources[index].icon,
                                      size: 26,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    learningSources[index].title,
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
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(color: Colors.white),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Truy cập gần đây',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(fontWeight: FontWeight.w600),
                        ),
                        RecentPagesWidget()
                      ]),
                )
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
