import 'package:ctue_app/core/constants/constants.dart';
import 'package:ctue_app/core/errors/failure.dart';
import 'package:ctue_app/features/sentence/business/entities/sentence_entity.dart';
import 'package:ctue_app/features/sentence/presentation/providers/sentence_provider.dart';
import 'package:ctue_app/features/skeleton/widgets/custom_error_widget.dart';
import 'package:ctue_app/features/topic/business/entities/topic_entity.dart';
import 'package:ctue_app/features/topic/presentation/providers/topic_provider.dart';
import 'package:ctue_app/features/type/presentation/providers/type_provider.dart';
import 'package:ctue_app/features/user/presentation/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ComPhrasePage extends StatefulWidget {
  const ComPhrasePage({Key? key}) : super(key: key);

  @override
  State<ComPhrasePage> createState() => _ComPhrasePageState();
}

class _ComPhrasePageState extends State<ComPhrasePage> {
  final PagingController<int, SentenceEntity> _pagingController =
      PagingController(firstPageKey: 1);
  List<int> userInterestTopics = [];

  @override
  void initState() {
    Provider.of<TopicProvider>(context, listen: false).eitherFailureOrTopics(
        null,
        false,
        TopicEntity(id: 0, name: 'Tất cả', isWord: false, isSelected: true));

    Provider.of<TypeProvider>(context, listen: false).eitherFailureOrGetTypes(
      false,
    );

    userInterestTopics = Provider.of<UserProvider>(context, listen: false)
        .getUserInterestTopics(false);

    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      List<int> selectedTopics =
          Provider.of<TopicProvider>(context, listen: false)
              .getSelectedTopics();

      await Provider.of<SentenceProvider>(context, listen: false)
          .eitherFailureOrSentences(
              (selectedTopics.isEmpty || selectedTopics[0] == 0)
                  ? userInterestTopics
                  : selectedTopics,
              null,
              pageKey,
              'asc');
      final newItems =
          // ignore: use_build_context_synchronously
          Provider.of<SentenceProvider>(context, listen: false)
              .sentenceResEntity!
              .data;

      // final isLastPage = newItems.length < _pageSize;
      // ignore: use_build_context_synchronously
      final isLastPage = Provider.of<SentenceProvider>(context, listen: false)
              .sentenceResEntity!
              .totalPages! <=
          pageKey;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + newItems.length;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  void dispose() {
    _pagingController.dispose();
    // Provider.of<TopicProvider>(context, listen: false).refreshTopics();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          scrolledUnderElevation: 0,
          title: Text(
            'Mẫu câu giao tiếp',
            style: Theme.of(context).textTheme.titleMedium!.copyWith(),
          ),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.chevron_left_rounded,
              size: 30,
            ),
          )),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
        child: Column(children: [
          //     const Divider(),

          Consumer<TopicProvider>(
            builder: (context, topicProvider, _) {
              List<TopicEntity>? topics = topicProvider.listTopicEntity;
              bool isLoading = topicProvider.isLoading;
              Failure? failure = topicProvider.failure;

              // print(topicProvider.getSelectedTopics());

              if (failure != null) {
                return CustomErrorWidget(
                    title: failure.errorMessage,
                    onTryAgain: () {
                      topicProvider.eitherFailureOrTopics(
                          null,
                          false,
                          TopicEntity(
                              id: 0,
                              name: 'Tất cả',
                              isWord: false,
                              isSelected: true));
                    });
              } else if (!isLoading && topics.isEmpty) {
                return const Center(child: Text('Chưa có dữ liệu'));
              } else {
                return Skeletonizer(
                  enabled: isLoading,
                  child: SizedBox(
                    height: 35,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return ActionChip(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 8),
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          label: Text(topics[index].name),
                          // You may need to adjust the properties based on your TopicEntity

                          backgroundColor: topics[index].isSelected
                              ? Colors.tealAccent.shade200.withOpacity(0.6)
                              : Colors.grey.shade200,

                          labelStyle: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  color: topics[index].isSelected
                                      ? Theme.of(context)
                                          .colorScheme
                                          .primary
                                          .withOpacity(0.8)
                                      : Colors.grey.shade700),
                          onPressed: () {
                            Provider.of<TopicProvider>(context, listen: false)
                                .handleSelectTopicComPhrase(index);
                            _pagingController.refresh();
                            // setState(() {});
                          },
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          width: 5,
                        );
                      },
                      itemCount: topics.length,
                    ),
                  ),
                );
              }
            },
          ),
          const Divider(),

          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                  onPressed: () {
                    _pagingController.itemList =
                        _pagingController.itemList!.reversed.toList();
                  },
                  icon: const Icon(Icons.sort)),
              IconButton(
                  onPressed: () {}, icon: const Icon(Icons.filter_alt_outlined))
            ],
          ),
          Provider.of<TopicProvider>(context, listen: true).isLoading == false
              ? Expanded(
                  child: PagedListView<int, SentenceEntity>(
                    pagingController: _pagingController,
                    shrinkWrap: true,
                    // physics: const NeverScrollableScrollPhysics(),

                    builderDelegate: PagedChildBuilderDelegate<SentenceEntity>(
                        itemBuilder: (context, item, index) => ListTile(
                              minVerticalPadding: 0,
                              leading: Text(
                                '${index + 1}',
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              minLeadingWidth: 15,
                              contentPadding: const EdgeInsets.only(
                                  left: 0, top: 0, bottom: 0, right: 0),
                              title: Text(item.content),
                              subtitle: Text(
                                item.meaning,
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                              onTap: () {
                                Navigator.pushNamed(context,
                                    RouteNames.communicationPhraseDetail,
                                    arguments: ComPhraseArguments(id: item.id));
                              },
                            )),
                  ),
                )
              : const SizedBox.shrink(),
        ]),
      ),
    );
  }
}

class ComPhraseArguments {
  final int id;

  ComPhraseArguments({required this.id});
}
