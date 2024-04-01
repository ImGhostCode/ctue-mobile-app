import 'package:ctue_app/core/constants/constants.dart';
import 'package:ctue_app/core/errors/failure.dart';
import 'package:ctue_app/features/learn/presentation/providers/learn_provider.dart';
import 'package:ctue_app/features/manage/presentation/pages/voca_set_management.dart';
import 'package:ctue_app/features/user/presentation/providers/user_provider.dart';
import 'package:ctue_app/features/vocabulary_set/business/entities/voca_set_entity.dart';
import 'package:ctue_app/features/vocabulary_set/business/entities/voca_statistics_entity.dart';
import 'package:ctue_app/features/vocabulary_set/presentation/pages/spaced_repetition_detail.dart';
import 'package:ctue_app/features/vocabulary_set/presentation/providers/voca_set_provider.dart';
import 'package:ctue_app/features/learn/presentation/widgets/dialog_text_input.dart';
import 'package:ctue_app/features/learn/presentation/widgets/statistic_chart.dart';
import 'package:ctue_app/features/learn/presentation/widgets/action_box.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WordStorePage extends StatefulWidget {
  const WordStorePage({Key? key}) : super(key: key);

  @override
  State<WordStorePage> createState() => _WordStorePageState();
}

class _WordStorePageState extends State<WordStorePage> {
  // int totalWords = 0;

  @override
  void initState() {
    Provider.of<VocaSetProvider>(context, listen: false)
        .eitherFailureOrGerUsrVocaSets();
    Provider.of<VocaSetProvider>(context, listen: false)
        .eitherFailureOrGerVocaSetStatistics(null);
    super.initState();
  }

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
                  child: Consumer<VocaSetProvider>(
                    builder: (context, provider, child) {
                      bool isLoading = provider.isLoading;

                      if (isLoading) {
                        return const Center(
                            child: CircularProgressIndicator(
                          color: Colors.white,
                        ));
                      } else if (provider.vocaSetStatisticsEntity == null) {
                        return StatisticChart(
                            dataStatistics: VocaSetStatisticsEntity(
                                detailVocaSetStatisEntity:
                                    DetailVocaSetStatisEntity(),
                                numberOfWords: 0));
                      } else {
                        return StatisticChart(
                            dataStatistics: provider.vocaSetStatisticsEntity!);
                      }
                    },
                  ),
                )
              ],
            ),
          ),
          Consumer<LearnProvider>(
            builder: (context, provider, child) {
              bool isLoading = provider.isLoading;

              Failure? failure = provider.failure;

              if (failure != null) {
                // Handle failure, for example, show an error message
                return Text(failure.errorMessage);
              } else if (isLoading) {
                // Handle the case where topics are empty
                return const Center(
                    child:
                        CircularProgressIndicator()); // or show an empty state message
              } else if (provider.currReminder != null) {
                return Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  color: Colors.grey.shade200,
                  child: ActionBox(
                    vocabularySetId: provider.currReminder!.vocabularySetId,
                    words: provider.currReminder!.words,
                  ),
                );
              } else if (provider.upcomingReminder != null) {
                return Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  color: Colors.grey.shade200,
                  child: ActionBox(
                    vocabularySetId: provider.upcomingReminder!.vocabularySetId,
                    words: provider.upcomingReminder!.words,
                  ),
                );
              } else {
                // return Container(
                //   padding:
                //       const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                //   color: Colors.grey.shade200,
                //   child: const ActionBox(
                //     vocabularySetId: -1,
                //     words: [],
                //   ),
                // );
                return const SizedBox.shrink();
              }
            },
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
                // height: 50,
                alignment: Alignment.center,
                margin: const EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12)),
                child: ElevatedButton(
                  style: ButtonStyle(
                      padding: const MaterialStatePropertyAll(
                          EdgeInsets.symmetric(horizontal: 12)),
                      shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: BorderSide.none)),
                      elevation: const MaterialStatePropertyAll(0),
                      backgroundColor:
                          const MaterialStatePropertyAll(Colors.white)),
                  onPressed: () {
                    Navigator.pushNamed(context, '/create-vocabulary-set',
                        arguments: CreateVocaSetArgument(isAdmin: false));
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
                // height: 50,
                // margin: const EdgeInsets.only(right: 5),
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
            height: 5,
          ),
          _buildListVocabularySets()
        ],
      ),
    );
  }

  Consumer _buildListVocabularySets() {
    return Consumer<VocaSetProvider>(builder: (context, provider, child) {
      List<VocaSetEntity> listUsrVocaSets = provider.userVocaSets;

      bool isLoading = provider.isLoading;

      // Access the failure from the provider
      Failure? failure = provider.failure;

      if (failure != null) {
        // Handle failure, for example, show an error message
        return Text(failure.errorMessage);
      } else if (isLoading) {
        // Handle the case where topics are empty
        return const Center(
            child:
                CircularProgressIndicator()); // or show an empty state message
      } else if (listUsrVocaSets.isEmpty) {
        // Handle the case where topics are empty
        return const Center(
            child: Text('Không có dữ liệu')); // or show an empty state message
      } else {
        return ListView.separated(
          shrinkWrap: true,
          separatorBuilder: (context, index) {
            return const SizedBox(
              height: 3,
            );
          },
          physics: const NeverScrollableScrollPhysics(),
          itemCount: listUsrVocaSets.length,
          itemBuilder: (context, index) {
            return Card(
                color: Colors.white, // Set the background color here
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/vocabulary-set-detail',
                        arguments: VocabularySetArguments(
                            id: listUsrVocaSets[index].id));
                  },
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(12),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    tileColor: Colors.white,
                    leading: listUsrVocaSets[index].picture == null
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
                              // border: Border.all(color: Colors.blue, width: 2),
                              image: DecorationImage(
                                image: NetworkImage(
                                    listUsrVocaSets[index].picture!),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                    title: Text(listUsrVocaSets[index].title),
                    trailing: IconButton(
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
                            // height: 65,
                            width: MediaQuery.of(context).size.width - 100,
                            child: ListView(shrinkWrap: true, children: [
                              listUsrVocaSets[index].userId ==
                                      Provider.of<UserProvider>(context,
                                              listen: false)
                                          .userEntity!
                                          .id
                                  ? TextButton(
                                      style: const ButtonStyle(
                                          padding: MaterialStatePropertyAll(
                                              EdgeInsets.symmetric(
                                                  horizontal: 16,
                                                  vertical: 18)),
                                          shape: MaterialStatePropertyAll(
                                              RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.zero)),
                                          backgroundColor:
                                              MaterialStatePropertyAll(
                                                  Colors.white)),
                                      onPressed: () async {
                                        showDialogInput(context, 'Đổi tên',
                                            listUsrVocaSets[index]);

                                        // await provider.eitherFailureOrUpdateVocaSet(listUsrVocaSets[index].id, _ti, topicId, specId, oldPicture, picture, isPublic, words)
                                      },
                                      child: const Text(
                                          textAlign: TextAlign.left, 'Đổi tên'))
                                  : const SizedBox.shrink(),
                              TextButton(
                                  style: const ButtonStyle(
                                      padding: MaterialStatePropertyAll(
                                          EdgeInsets.symmetric(
                                              horizontal: 16, vertical: 18)),
                                      shape: MaterialStatePropertyAll(
                                          RoundedRectangleBorder(
                                              borderRadius: BorderRadius.zero)),
                                      backgroundColor: MaterialStatePropertyAll(
                                          Colors.white)),
                                  onPressed: () => showDialog<String>(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            AlertDialog(
                                          backgroundColor: Colors.white,
                                          // title: const Text('Cảnh báo'),
                                          content: const Text(
                                              'Bạn có chắc chắn muốn xóa bộ từ này không?'),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.pop(context, 'Xóa'),
                                              child: const Text('Trở lại'),
                                            ),
                                            TextButton(
                                              onPressed: () async {
                                                await provider
                                                    .eitherFailureOrRmVocaSet(
                                                        provider
                                                            .userVocaSets[index]
                                                            .id,
                                                        provider
                                                                .userVocaSets[
                                                                    index]
                                                                .userId !=
                                                            Provider.of<UserProvider>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .userEntity!
                                                                .id);
                                                if (provider.statusCode ==
                                                    200) {
                                                  listUsrVocaSets
                                                      .removeAt(index);
                                                }
                                                Navigator.pop(context, 'OK');
                                                Navigator.pop(
                                                  context,
                                                );
                                              },
                                              child: const Text('OK'),
                                            ),
                                          ],
                                        ),
                                      ),
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
                    ),
                  ),
                ));
          },
        );
      }
    });
  }
}

Future<String?> showDialogInput(
    BuildContext context, String title, dynamic data) {
  return showDialog<String>(
      context: context,
      builder: (BuildContext context) => DialogTextInput(
          initialValue: data.title,
          title: title,
          callback: (title) async {
            await Provider.of<VocaSetProvider>(context, listen: false)
                .eitherFailureOrUpdateVocaSet(
                    data.id, title, null, null, null, null, null, null);

            Navigator.pop(context);
            Navigator.pop(context);
          }));
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
