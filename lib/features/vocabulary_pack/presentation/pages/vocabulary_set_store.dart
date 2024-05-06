import 'package:ctue_app/core/errors/failure.dart';
import 'package:ctue_app/features/skeleton/widgets/custom_error_widget.dart';
import 'package:ctue_app/features/topic/business/entities/topic_entity.dart';
import 'package:ctue_app/features/topic/presentation/providers/topic_provider.dart';
import 'package:ctue_app/features/user/presentation/providers/user_provider.dart';
import 'package:ctue_app/features/vocabulary_pack/business/entities/voca_set_entity.dart';
import 'package:ctue_app/features/vocabulary_pack/presentation/providers/voca_set_provider.dart';
import 'package:ctue_app/features/vocabulary_pack/presentation/widgets/vocab_pack_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

class VocabularySetStore extends StatefulWidget {
  const VocabularySetStore({super.key});

  @override
  State<VocabularySetStore> createState() => _VocabularySetStoreState();
}

class _VocabularySetStoreState extends State<VocabularySetStore> {
  // final TextEditingController _searchController = TextEditingController();

  List<VocaSetEntity> _downloadedVocaSets = [];
  List<VocaSetEntity> _publicVocaSets = [];
  List<int> _userVocaSetIds = [];
  List<VocaSetEntity> _vocaSetByTopic = [];
  List<VocaSetEntity> _vocaSetBySpec = [];
  List<int> userInterestTopics = [];
  List<VocaSetEntity> _recommendVocaSets = [];
  bool isLoadingPage = false;

  @override
  void initState() {
    Provider.of<VocaSetProvider>(context, listen: false)
        .eitherFailureOrGerVocaSets(null, null, '');
    Provider.of<TopicProvider>(context, listen: false)
        .eitherFailureOrTopics(null, true, null);

    userInterestTopics = Provider.of<UserProvider>(context, listen: false)
        .getUserInterestTopics(true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Các gói từ vựng',
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
          )),
      body: Consumer<VocaSetProvider>(builder: (context, provider, child) {
        _userVocaSetIds = provider.userVocaSets.map((e) => e.id).toList();
        _publicVocaSets = provider.publicVocaSets;

        _recommendVocaSets = _publicVocaSets
            .where((set) => userInterestTopics.contains(set.topicId))
            .toList();

        _downloadedVocaSets = _publicVocaSets
            .where((set) => _userVocaSetIds.contains(set.id))
            .toList();

        _vocaSetByTopic = _publicVocaSets
            .where((set) =>
                set.topicId != null && !_userVocaSetIds.contains(set.id))
            .toList();
        _vocaSetBySpec = _publicVocaSets
            .where((set) =>
                set.specId != null && !_userVocaSetIds.contains(set.id))
            .toList();

        bool isLoading = provider.isLoading;

        Failure? failure = provider.failure;

        if (!isLoading && failure != null) {
          return CustomErrorWidget(
              title: failure.errorMessage,
              onTryAgain: () {
                Provider.of<VocaSetProvider>(context, listen: false)
                    .eitherFailureOrGerVocaSets(null, null, '');
              });
        } else if (!isLoading && provider.publicVocaSets.isEmpty) {
          // Handle the case where topics are empty
          return const Scaffold(body: Center(child: Text('Không có dữ liệu')));
        } else {
          return Skeletonizer(
            enabled: isLoading,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(children: [
                SearchBar(
                  hintText: 'Tìm kiếm',
                  // padding: MaterialStatePropertyAll(
                  //     EdgeInsets.symmetric(vertical: 0, horizontal: 16)),
                  overlayColor:
                      const MaterialStatePropertyAll(Colors.transparent),
                  hintStyle: const MaterialStatePropertyAll<TextStyle>(
                      TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                          fontWeight: FontWeight.normal)),
                  elevation: const MaterialStatePropertyAll(0),
                  shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                      side: const BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(12))),
                  backgroundColor:
                      const MaterialStatePropertyAll(Colors.transparent),
                  onSubmitted: ((value) {
                    if (value.isNotEmpty) {
                      Navigator.pushNamed(
                        context,
                        '/search-voca-set',
                        arguments: SearchVocaSetArgument(
                            titleAppBar: 'Tìm kiếm bộ từ', title: value),
                      );
                    }
                  }),
                  leading: Icon(
                    Icons.search,
                    size: 28,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Bộ từ đã tải',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.teal.shade400,
                                ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          _downloadedVocaSets.isNotEmpty
                              ? SizedBox(
                                  height: 185,
                                  child: ListView.separated(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        return VocabularyPackItem(
                                            item: _downloadedVocaSets[index]);
                                      },
                                      separatorBuilder: (context, index) {
                                        return const SizedBox(
                                          width: 10,
                                        );
                                      },
                                      itemCount: _downloadedVocaSets.length),
                                )
                              : const SizedBox.shrink(),
                          const SizedBox(
                            height: 15,
                          ),
                          _recommendVocaSets.isNotEmpty
                              ? Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Đề xuất cho bạn',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.teal.shade400,
                                              ),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Icon(
                                          Icons.recommend,
                                          color: Colors.yellow.shade600,
                                          size: 30,
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    _recommendVocaSets.isNotEmpty
                                        ? Container(
                                            margin: const EdgeInsets.only(
                                                bottom: 10),
                                            height: 185,
                                            child: ListView.separated(
                                                shrinkWrap: true,
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemBuilder: (context, index) {
                                                  return VocabularyPackItem(
                                                      item: _recommendVocaSets[
                                                          index]);
                                                },
                                                separatorBuilder:
                                                    (context, index) {
                                                  return const SizedBox(
                                                    width: 10,
                                                  );
                                                },
                                                itemCount:
                                                    _recommendVocaSets.length),
                                          )
                                        : const SizedBox.shrink(),
                                  ],
                                )
                              : const SizedBox.shrink(),
                          Text(
                            'Chuyên ngành',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          _vocaSetBySpec.isNotEmpty
                              ? SizedBox(
                                  height: 185,
                                  child: ListView.separated(
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        return VocabularyPackItem(
                                            item: _vocaSetBySpec[index]);
                                      },
                                      separatorBuilder: (context, index) {
                                        return const SizedBox(
                                          width: 10,
                                        );
                                      },
                                      itemCount: _vocaSetByTopic.length),
                                )
                              : const SizedBox.shrink(),
                          const SizedBox(
                            height: 15,
                          ),
                          Text(
                            'Chủ đề',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          _vocaSetByTopic.isNotEmpty
                              ? SizedBox(
                                  height: 185,
                                  child: ListView.separated(
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        return VocabularyPackItem(
                                            item: _vocaSetByTopic[index]);
                                      },
                                      separatorBuilder: (context, index) {
                                        return const SizedBox(
                                          width: 10,
                                        );
                                      },
                                      itemCount: _vocaSetByTopic.length),
                                )
                              : const SizedBox.shrink(),
                          const SizedBox(
                            height: 15,
                          ),
                          Text(
                            'Từ vựng theo phân loại',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Consumer<TopicProvider>(
                              builder: (context, provider, child) {
                            List<TopicEntity> vocaSetEntity =
                                provider.listTopicEntity;

                            bool isLoading = provider.isLoading;

                            Failure? failure = provider.failure;

                            if (!isLoading && failure != null) {
                              // Handle failure, for example, show an error message
                              return Center(child: Text(failure.errorMessage));
                            } else if (!isLoading && vocaSetEntity.isEmpty) {
                              // Handle the case where topics are empty
                              return const Center(
                                  child: Text('Không có dữ liệu'));
                            } else {
                              return Container(
                                // height: 200,
                                // width: MediaQuery.of(context).size.width - 32,
                                padding: const EdgeInsets.all(8),
                                child: Wrap(
                                  spacing:
                                      6, // Adjust the spacing between items as needed
                                  runSpacing: 6,
                                  children: List.generate(
                                    provider.listTopicEntity.length,
                                    (index) => ActionChip(
                                      onPressed: () {
                                        Navigator.pushNamed(
                                          context,
                                          '/search-voca-set',
                                          arguments: SearchVocaSetArgument(
                                              titleAppBar: provider
                                                  .listTopicEntity[index].name,
                                              topicId: provider
                                                  .listTopicEntity[index].id),
                                        );
                                      },
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 6),
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                          width: 1.5,
                                          color: Colors.grey.shade300,
                                        ),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      label: Text(
                                          '#${provider.listTopicEntity[index].name}'),
                                      backgroundColor: Colors.white,
                                      labelStyle: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                            fontWeight: FontWeight.normal,
                                            color: Colors.black87,
                                          ),
                                    ),
                                  ),
                                ),
                              );
                            }
                          }),
                        ]),
                  ),
                )
              ]),
            ),
          );
        }
      }),
    );
  }
}

class SearchVocaSetArgument {
  final String titleAppBar;
  final String? title;
  final int? topicId;

  SearchVocaSetArgument({required this.titleAppBar, this.title, this.topicId});
}
