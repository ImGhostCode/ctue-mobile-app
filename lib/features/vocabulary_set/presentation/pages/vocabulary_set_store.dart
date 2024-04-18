import 'package:ctue_app/core/constants/constants.dart';
import 'package:ctue_app/core/errors/failure.dart';
import 'package:ctue_app/features/topic/business/entities/topic_entity.dart';
import 'package:ctue_app/features/topic/presentation/providers/topic_provider.dart';
import 'package:ctue_app/features/user/presentation/providers/user_provider.dart';
import 'package:ctue_app/features/vocabulary_set/business/entities/voca_set_entity.dart';
import 'package:ctue_app/features/vocabulary_set/presentation/providers/voca_set_provider.dart';
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
            'Các bộ từ vựng',
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
          // Handle failure, for example, show an error message
          return Center(child: Text(failure.errorMessage));
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
                                        return InkWell(
                                          onTap: () {
                                            Navigator.pushNamed(context,
                                                '/vocabulary-set-detail',
                                                arguments:
                                                    VocabularySetArguments(
                                                        id: _downloadedVocaSets[
                                                                index]
                                                            .id));
                                          },
                                          child: Container(
                                            // height: 50,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 12, vertical: 8),
                                            width: 130,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                border: Border.all(
                                                    color:
                                                        Colors.grey.shade400)),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  height: 100,
                                                  width: double.infinity,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                    child: Image.network(
                                                      _downloadedVocaSets[index]
                                                          .picture!,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Flexible(
                                                  // flex: 2,
                                                  child: Text(
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    _downloadedVocaSets[index]
                                                        .title,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium!
                                                        .copyWith(
                                                            color:
                                                                Colors.black87),
                                                  ),
                                                ),
                                                const Spacer(),
                                                // const SizedBox(
                                                //   height: 5,
                                                // ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        const Icon(
                                                          Icons.list_rounded,
                                                          size: 16,
                                                          color: Colors.grey,
                                                        ),
                                                        Text(
                                                          '${_downloadedVocaSets[index].words.length}',
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodySmall!
                                                                  .copyWith(
                                                                      fontSize:
                                                                          11),
                                                        )
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                    Row(
                                                      children: [
                                                        const Icon(
                                                          Icons
                                                              .download_rounded,
                                                          size: 16,
                                                          color: Colors.grey,
                                                        ),
                                                        Text(
                                                          '${_downloadedVocaSets[index].downloads}',
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodySmall!
                                                                  .copyWith(
                                                                      fontSize:
                                                                          11),
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        );
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                                color: Colors.yellow.shade700,
                                size: 30,
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          _recommendVocaSets.isNotEmpty
                              ? SizedBox(
                                  height: 185,
                                  child: ListView.separated(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: () {
                                            Navigator.pushNamed(context,
                                                '/vocabulary-set-detail',
                                                arguments:
                                                    VocabularySetArguments(
                                                        id: _recommendVocaSets[
                                                                index]
                                                            .id));
                                          },
                                          child: Container(
                                            // height: 50,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 12, vertical: 8),
                                            width: 130,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                border: Border.all(
                                                    color:
                                                        Colors.grey.shade400)),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  height: 100,
                                                  width: double.infinity,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                    child: Image.network(
                                                      _recommendVocaSets[index]
                                                          .picture!,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Flexible(
                                                  // flex: 2,
                                                  child: Text(
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    _recommendVocaSets[index]
                                                        .title,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium!
                                                        .copyWith(
                                                            color:
                                                                Colors.black87),
                                                  ),
                                                ),
                                                const Spacer(),
                                                // const SizedBox(
                                                //   height: 5,
                                                // ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        const Icon(
                                                          Icons.list_rounded,
                                                          size: 16,
                                                          color: Colors.grey,
                                                        ),
                                                        Text(
                                                          '${_recommendVocaSets[index].words.length}',
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodySmall!
                                                                  .copyWith(
                                                                      fontSize:
                                                                          11),
                                                        )
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                    Row(
                                                      children: [
                                                        const Icon(
                                                          Icons
                                                              .download_rounded,
                                                          size: 16,
                                                          color: Colors.grey,
                                                        ),
                                                        Text(
                                                          '${_recommendVocaSets[index].downloads}',
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodySmall!
                                                                  .copyWith(
                                                                      fontSize:
                                                                          11),
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        );
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
                                        return InkWell(
                                          onTap: () {
                                            Navigator.pushNamed(context,
                                                '/vocabulary-set-detail',
                                                arguments:
                                                    VocabularySetArguments(
                                                        id: _vocaSetBySpec[
                                                                index]
                                                            .id));
                                          },
                                          child: Container(
                                            // height: 50,
                                            padding: const EdgeInsets.all(8),
                                            width: 130,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                border: Border.all(
                                                    color:
                                                        Colors.grey.shade400)),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  height: 100,
                                                  width: double.infinity,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                    child: Image.network(
                                                      _vocaSetBySpec[index]
                                                          .picture!,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Flexible(
                                                  // flex: 2,
                                                  child: Text(
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    _vocaSetBySpec[index].title,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium!
                                                        .copyWith(
                                                            color:
                                                                Colors.black87),
                                                  ),
                                                ),
                                                const Spacer(),
                                                // const SizedBox(
                                                //   height: 5,
                                                // ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        const Icon(
                                                          Icons.list_rounded,
                                                          size: 16,
                                                          color: Colors.grey,
                                                        ),
                                                        Text(
                                                          '${_vocaSetBySpec[index].words.length}',
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodySmall,
                                                        )
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                    Row(
                                                      children: [
                                                        const Icon(
                                                          Icons
                                                              .download_rounded,
                                                          size: 16,
                                                          color: Colors.grey,
                                                        ),
                                                        Text(
                                                          '${_vocaSetBySpec[index].downloads}',
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodySmall,
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                      separatorBuilder: (context, index) {
                                        return const SizedBox(
                                          width: 10,
                                        );
                                      },
                                      itemCount: _vocaSetBySpec.length),
                                )
                              : const SizedBox.shrink(),
                          const SizedBox(
                            height: 10,
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
                                        return InkWell(
                                          onTap: () {
                                            Navigator.pushNamed(context,
                                                '/vocabulary-set-detail',
                                                arguments:
                                                    VocabularySetArguments(
                                                        id: _vocaSetByTopic[
                                                                index]
                                                            .id));
                                          },
                                          child: Container(
                                            // height: 50,
                                            padding: const EdgeInsets.all(8),
                                            width: 130,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                border: Border.all(
                                                    color:
                                                        Colors.grey.shade400)),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  height: 100,
                                                  width: double.infinity,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                    child: Image.network(
                                                      _vocaSetByTopic[index]
                                                          .picture!,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Flexible(
                                                  // flex: 2,
                                                  child: Text(
                                                    maxLines: 2,
                                                    textAlign: TextAlign.left,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    _vocaSetByTopic[index]
                                                        .title,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium!
                                                        .copyWith(
                                                            color:
                                                                Colors.black87),
                                                  ),
                                                ),
                                                const Spacer(),
                                                // const SizedBox(
                                                //   height: 5,
                                                // ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        const Icon(
                                                          Icons.list_rounded,
                                                          size: 16,
                                                          color: Colors.grey,
                                                        ),
                                                        Text(
                                                          '${_vocaSetByTopic[index].words.length}',
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodySmall,
                                                        )
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                    Row(
                                                      children: [
                                                        const Icon(
                                                          Icons
                                                              .download_rounded,
                                                          size: 16,
                                                          color: Colors.grey,
                                                        ),
                                                        Text(
                                                          '${_vocaSetByTopic[index].downloads}',
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodySmall,
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        );
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
                                          width: 2,
                                          color: provider.isLoading
                                              ? Colors.grey.shade100
                                              : Colors.green,
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
