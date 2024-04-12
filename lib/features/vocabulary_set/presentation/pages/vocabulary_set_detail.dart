import 'package:ctue_app/core/constants/constants.dart';
import 'package:ctue_app/core/errors/failure.dart';
import 'package:ctue_app/features/learn/presentation/providers/learn_provider.dart';
import 'package:ctue_app/features/manage/presentation/pages/voca_set_management.dart';
import 'package:ctue_app/features/vocabulary_set/business/entities/voca_set_entity.dart';
import 'package:ctue_app/features/vocabulary_set/business/entities/voca_statistics_entity.dart';
import 'package:ctue_app/features/vocabulary_set/presentation/providers/voca_set_provider.dart';
import 'package:ctue_app/features/learn/presentation/widgets/statistic_chart.dart';
import 'package:ctue_app/features/learn/presentation/widgets/action_box.dart';
import 'package:ctue_app/features/vocabulary_set/presentation/widgets/word_detail_in_voca_set.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VocabularySetDetail extends StatefulWidget {
  const VocabularySetDetail({super.key});

  @override
  State<VocabularySetDetail> createState() => _VocabularySetDetailState();
}

class _VocabularySetDetailState extends State<VocabularySetDetail> {
  String sortBy = 'Mới nhất';
  dynamic args;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    args = ModalRoute.of(context)!.settings.arguments as VocabularySetArguments;
    Provider.of<LearnProvider>(context, listen: false)
        .eitherFailureOrGetUpcomingReminder();
    Provider.of<VocaSetProvider>(context, listen: false)
        .eitherFailureOrGerVocaSetDetail(args.id);
    Provider.of<VocaSetProvider>(context, listen: false)
        .eitherFailureOrGerVocaSetStatistics(args.id);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<VocaSetProvider>(builder: (context, provider, child) {
      VocaSetEntity? vocaSetEntity = provider.vocaSetEntity;
      VocaSetStatisticsEntity? vocaSetStatisticsEntity =
          provider.vocaSetStatisticsEntity;

      bool isLoading = provider.isLoading;

      Failure? failure = provider.failure;

      if (failure != null) {
        // Handle failure, for example, show an error message
        return Scaffold(body: Center(child: Text(failure.errorMessage)));
      } else if (isLoading) {
        // Handle the case where topics are empty
        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      } else if (!isLoading && vocaSetEntity != null) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              provider.vocaSetEntity!.title,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            backgroundColor: Colors.white,
            scrolledUnderElevation: 0,
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
              args.isAdmin
                  ? const SizedBox.shrink()
                  : IconButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/edit-voca-set',
                            arguments: EditVocaSetArguments(
                              vocaSetEntity: vocaSetEntity,
                              isAdmin: false,
                              callback: () {
                                Provider.of<VocaSetProvider>(context,
                                        listen: false)
                                    .eitherFailureOrGerUsrVocaSets();
                                Navigator.pop(context);
                              },
                            ));
                      },
                      icon: const Icon(
                        Icons.add_circle_outline_rounded,
                        color: Colors.blue,
                      ))
            ],
          ),
          body: Stack(
            children: [
              SingleChildScrollView(
                child: Container(
                  // height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(16),
                  color: Colors.grey.shade200,
                  child: Column(
                    children: [
                      StatisticChart(
                          totalWords: vocaSetEntity.words.length,
                          dataStatistics: vocaSetStatisticsEntity ??
                              VocaSetStatisticsEntity(
                                  numberOfWords: 0,
                                  detailVocaSetStatisEntity:
                                      DetailVocaSetStatisEntity())),
                      const SizedBox(
                        height: 20,
                      ),
                      vocaSetEntity.words.isNotEmpty
                          ? Consumer<LearnProvider>(
                              builder: (context, learnProvider, child) {
                              bool isLoading = learnProvider.isLoading;

                              Failure? failure = learnProvider.failure;

                              if (failure != null) {
                                // Handle failure, for example, show an error message
                                return Text(failure.errorMessage);
                              } else if (isLoading) {
                                // Handle the case where topics are empty
                                return const Center(
                                    child:
                                        CircularProgressIndicator()); // or show an empty state message
                              } else if (learnProvider.upcomingReminder !=
                                  null) {
                                if (learnProvider
                                        .upcomingReminder!.vocabularySetId ==
                                    provider.vocaSetEntity!.id) {
                                  return ActionBox(
                                    words: vocaSetEntity.words,
                                    vocabularySetId: vocaSetEntity.id,
                                    reviewAt: learnProvider
                                        .upcomingReminder!.reviewAt,
                                  );
                                } else {
                                  return ActionBox(
                                    words: vocaSetEntity.words,
                                    vocabularySetId: vocaSetEntity.id,
                                  );
                                }
                              } else {
                                return ActionBox(
                                  words: vocaSetEntity.words,
                                  vocabularySetId: vocaSetEntity.id,
                                );
                              }
                            })
                          : const SizedBox.shrink(),

                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 40,
                        child: SearchBar(
                          hintText: 'Tìm bằng từ hoặc nghĩa',
                          // padding: MaterialStatePropertyAll(
                          //     EdgeInsets.symmetric(vertical: 0, horizontal: 16)),
                          overlayColor: const MaterialStatePropertyAll(
                              Colors.transparent),
                          hintStyle: MaterialStatePropertyAll<TextStyle>(
                              TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal)),
                          elevation: const MaterialStatePropertyAll(0),
                          shape: MaterialStatePropertyAll(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12))),
                          backgroundColor:
                              const MaterialStatePropertyAll(Colors.white),
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
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold),
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

                      ...List.generate(
                          args.isAdmin ||
                                  provider
                                      .isDownloaded(provider.vocaSetEntity!.id)
                              ? provider.vocaSetEntity!.words.length
                              : provider.vocaSetEntity!.words.length >
                                      maxDisplayedWords
                                  ? maxDisplayedWords
                                  : provider.vocaSetEntity!.words.length,
                          (index) => WordDetailInVocaSet(
                                wordEntity:
                                    provider.vocaSetEntity!.words[index],
                              ))
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
              args.isAdmin || provider.isDownloaded(provider.vocaSetEntity!.id)
                  ? const SizedBox.shrink()
                  : Positioned(
                      bottom: 0,
                      left: 0,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        // height: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 16),
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                stops: const [
                              0.1,
                              0.3,
                              1
                            ],
                                colors: [
                              Colors.white.withOpacity(0.1),
                              Colors.white.withOpacity(0.8),
                              Colors.white
                            ])),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 50,
                            ),
                            Text('Tải đề xem toàn bộ từ vựng',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(fontWeight: FontWeight.bold)),
                            const SizedBox(
                              height: 10,
                            ),
                            OutlinedButton(
                                onPressed: provider.isLoading
                                    ? null
                                    : () async {
                                        await provider
                                            .eitherFailureOrDownVocaSet(
                                                provider.vocaSetEntity!.id);
                                        // provider.eitherFailureOrGerVocaSets(
                                        //     null, null, null);
                                        setState(() {});
                                      },
                                child: provider.isLoading
                                    ? const CircularProgressIndicator()
                                    : Text(
                                        'TẢI BỘ TỪ',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                                fontWeight: FontWeight.w600,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primary),
                                      )),
                          ],
                        ),
                      ))
            ],
          ),
        );
      } else {
        // Handle the case where topics are empty
        return const Scaffold(body: Center(child: Text('Không có dữ liệu')));
      }
    });
  }
}
