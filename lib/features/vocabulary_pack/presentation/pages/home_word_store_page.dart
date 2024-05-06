import 'package:ctue_app/core/constants/constants.dart';
import 'package:ctue_app/core/errors/failure.dart';
import 'package:ctue_app/features/learn/presentation/providers/learn_provider.dart';
import 'package:ctue_app/features/manage/presentation/pages/voca_set_management.dart';
import 'package:ctue_app/features/notification/presentation/widgets/notification_icon.dart';
import 'package:ctue_app/features/skeleton/widgets/custom_error_widget.dart';
import 'package:ctue_app/features/user/presentation/providers/user_provider.dart';
import 'package:ctue_app/features/vocabulary_pack/business/entities/voca_set_entity.dart';
import 'package:ctue_app/features/vocabulary_pack/business/entities/voca_statistics_entity.dart';
import 'package:ctue_app/features/vocabulary_pack/presentation/pages/spaced_repetition_detail.dart';
import 'package:ctue_app/features/vocabulary_pack/presentation/providers/voca_set_provider.dart';
import 'package:ctue_app/features/learn/presentation/widgets/dialog_text_input.dart';
import 'package:ctue_app/features/learn/presentation/widgets/statistic_chart.dart';
import 'package:ctue_app/features/learn/presentation/widgets/action_box.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

class WordStorePage extends StatefulWidget {
  const WordStorePage({Key? key}) : super(key: key);

  @override
  State<WordStorePage> createState() => _WordStorePageState();
}

class _WordStorePageState extends State<WordStorePage> {
  // int totalWords = 0;

  @override
  void initState() {
    Provider.of<VocaSetProvider>(context, listen: false).userVocaSets = [];
    Provider.of<VocaSetProvider>(context, listen: false).failure = null;
    Provider.of<VocaSetProvider>(context, listen: false)
        .vocaSetStatisticsEntity = null;
    Provider.of<LearnProvider>(context, listen: false).currReminder = null;
    Provider.of<VocaSetProvider>(context, listen: false)
        .eitherFailureOrGerUsrVocaSets();
    Provider.of<VocaSetProvider>(context, listen: false)
        .eitherFailureOrGerVocaSetStatistics(null);
    Provider.of<LearnProvider>(context, listen: false)
        .eitherFailureOrGetUpcomingReminder(null);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade100,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: Image.asset(
                  'assets/images/ctue-high-resolution-logo-transparent2.png',
                  fit: BoxFit.fill,
                  width: 150),
              actions: const [NotificationIcon()],
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

                          if (!isLoading &&
                              provider.vocaSetStatisticsEntity == null) {
                            return StatisticChart(
                                dataStatistics: VocaSetStatisticsEntity(
                                    detailVocaSetStatisEntity:
                                        DetailVocaSetStatisEntity(),
                                    numberOfWords: 0));
                          } else {
                            return Skeletonizer(
                              enabled: isLoading,
                              child: StatisticChart(
                                  dataStatistics: isLoading
                                      ? VocaSetStatisticsEntity(
                                          detailVocaSetStatisEntity:
                                              DetailVocaSetStatisEntity(),
                                          numberOfWords: 0)
                                      : provider.vocaSetStatisticsEntity!),
                            );
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
                    return CustomErrorWidget(
                        title: failure.errorMessage,
                        onTryAgain: () {
                          provider.eitherFailureOrGetUpcomingReminder(null);
                        });
                  }
                  // else if (!isLoading && provider.currReminder != null) {
                  //   return Container(
                  //     padding:
                  //         const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  //     color: Colors.grey.shade200,
                  //     child: ActionBox(
                  //       vocabularySetId: provider.currReminder!.vocabularySetId,
                  //       userLearnedWords: provider.currReminder!.learnedWords,
                  //       reviewAt: provider.currReminder!.reviewAt,
                  //     ),
                  //   );
                  // }
                  else if (!isLoading && provider.upcomingReminder != null) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      color: Colors.grey.shade200,
                      child: ActionBox(
                        isLoadingPage: isLoading,
                        reviewReminderId: provider.upcomingReminder!.id,
                        vocabularySetId:
                            provider.upcomingReminder!.vocabularySetId,
                        userLearnedWords:
                            provider.upcomingReminder!.learnedWords,
                        words: provider.upcomingReminder!.learnedWords
                            .map((e) => e.word!)
                            .toList(),
                        reviewAt: provider.upcomingReminder!.reviewAt,
                      ),
                    );
                  } else if (!isLoading && provider.upcomingReminder == null) {
                    return const SizedBox.shrink();
                  } else {
                    return Skeletonizer(
                        enabled: isLoading,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          color: Colors.grey.shade200,
                          child: ActionBox(
                            isLoadingPage: isLoading,
                            vocabularySetId: -1,
                            words: const [],
                          ),
                        ));
                    // return const SizedBox.shrink();
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
            'Gói từ của bạn',
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
                        arguments: CreateVocaSetArgument(
                            isAdmin: false,
                            callback: () {
                              Provider.of<VocaSetProvider>(context,
                                      listen: false)
                                  .eitherFailureOrGerUsrVocaSets();
                            }));
                  },
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.create_new_folder_rounded,
                          color: Colors.teal,
                        ),
                        const SizedBox(
                          width: 3,
                        ),
                        Flexible(
                          child: Text(
                            'Tạo gói từ mới',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(color: Colors.black),
                          ),
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
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.library_books,
                          color: Colors.teal,
                        ),
                        const SizedBox(
                          width: 3,
                        ),
                        Flexible(
                          child: Text(
                            'Tải gói từ',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(color: Colors.black),
                          ),
                        )
                      ]),
                ),
              )),
            ],
          ),
          // const SizedBox(
          //   height: 5,
          // ),
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
        return CustomErrorWidget(
            title: failure.errorMessage,
            onTryAgain: () {
              provider.eitherFailureOrGerUsrVocaSets();
            });
      } else if (!isLoading && listUsrVocaSets.isEmpty) {
        // Handle the case where topics are empty
        return Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            const SizedBox(
              height: 40,
            ),
            Center(
              child: Text(
                'Bạn chưa có bộ từ nào',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontWeight: FontWeight.normal),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, RouteNames.vocabularySets);
                },
                child: const Text('Tải bộ từ ngay'))
          ],
        );
      } else {
        return Skeletonizer(
            enabled: isLoading,
            child: ListView.separated(
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
                                              textAlign: TextAlign.left,
                                              'Đổi tên'))
                                      : const SizedBox.shrink(),
                                  TextButton(
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
                                      onPressed: () => showDialog<String>(
                                            context: context,
                                            builder: (BuildContext context) =>
                                                AlertDialog(
                                              backgroundColor: Colors.white,
                                              shadowColor: Colors.white,
                                              surfaceTintColor: Colors.white,
                                              // title: const Text('Cảnh báo'),
                                              content: const Text(
                                                  'Bạn có chắc chắn muốn xóa bộ từ này không?'),
                                              actions: <Widget>[
                                                ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        Colors.grey.shade400,
                                                    textStyle: Theme.of(context)
                                                        .textTheme
                                                        .labelLarge,
                                                  ),
                                                  child: const Text('Trở về'),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                                ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    textStyle: Theme.of(context)
                                                        .textTheme
                                                        .labelLarge,
                                                  ),
                                                  onPressed: provider.isLoading
                                                      ? null
                                                      : () async {
                                                          await provider.eitherFailureOrRmVocaSet(
                                                              provider
                                                                  .userVocaSets[
                                                                      index]
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
                                                          if (provider
                                                                  .statusCode ==
                                                              200) {
                                                            listUsrVocaSets
                                                                .removeAt(
                                                                    index);
                                                            Provider.of<LearnProvider>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .eitherFailureOrGetUpcomingReminder(
                                                                    null);
                                                          }
                                                          // ignore: use_build_context_synchronously
                                                          Navigator.pop(
                                                              context, 'OK');
                                                          // ignore: use_build_context_synchronously
                                                          Navigator.pop(
                                                            context,
                                                          );
                                                        },
                                                  child: provider.isLoading
                                                      ? const SizedBox(
                                                          height: 25,
                                                          width: 25,
                                                          child:
                                                              CircularProgressIndicator(
                                                            color: Colors.white,
                                                          ),
                                                        )
                                                      : const Text('Đồng ý'),
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
            ));
      }
    });
  }
}

Future<String?> showDialogInput(
    BuildContext context, String title, VocaSetEntity data) {
  return showDialog<String>(
      context: context,
      builder: (BuildContext context) => DialogTextInput(
          initialValue: data.title,
          title: title,
          callback: (newTitle) async {
            await Provider.of<VocaSetProvider>(context, listen: false)
                .eitherFailureOrUpdateVocaSet(data.id, newTitle, null, null,
                    data.picture, null, null, null, null);

            if (Provider.of<VocaSetProvider>(context, listen: false)
                    .statusCode ==
                200) {
              data.title = newTitle;
            }
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
