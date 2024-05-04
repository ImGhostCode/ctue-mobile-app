import 'dart:async';

import 'package:ctue_app/core/constants/constants.dart';
import 'package:ctue_app/core/errors/failure.dart';
import 'package:ctue_app/features/sentence/business/entities/sentence_entity.dart';
import 'package:ctue_app/features/sentence/presentation/providers/sentence_provider.dart';
import 'package:ctue_app/features/skeleton/widgets/custom_error_widget.dart';
// import 'package:ctue_app/features/speech/presentation/pages/voice_setting_page.dart';
import 'package:ctue_app/features/topic/business/entities/topic_entity.dart';
import 'package:ctue_app/features/topic/presentation/providers/topic_provider.dart';
import 'package:ctue_app/features/type/business/entities/type_entity.dart';
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
  final SearchController _searchController = SearchController();
  final FocusNode _searchFocusNode = FocusNode();
  final PagingController<int, SentenceEntity> _pagingController =
      PagingController(firstPageKey: 1);
  List<int> userInterestTopics = [];
  List<TopicEntity> listTopics = [
    // TopicEntity(id: 0, name: 'Tất cả', isWord: false, isSelected: true)
  ];
  int? selectedType;
  Timer? _searchTimer;
  bool isSearching = false;

  @override
  void initState() {
    Provider.of<TopicProvider>(context, listen: false).eitherFailureOrTopics(
        null, false, null
        // TopicEntity(id: 0, name: 'Tất cả', isWord: false, isSelected: true)

        );

    Provider.of<TypeProvider>(context, listen: false).eitherFailureOrGetTypes(
      false,
    );

    userInterestTopics = Provider.of<UserProvider>(context, listen: false)
        .getUserInterestTopics(false);

    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    _searchFocusNode.addListener(() {
      if (!_searchFocusNode.hasFocus) {
        setState(() {
          isSearching = false;
        });
      }
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    listTopics =
        Provider.of<TopicProvider>(context, listen: true).listTopicEntity;
    super.didChangeDependencies();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      // List<int> selectedTopics =
      //     Provider.of<TopicProvider>(context, listen: false)
      //         .getSelectedTopics();

      List<int> selectedTopics = listTopics
          .where((topic) => topic.isSelected)
          .map((e) => e.id)
          .toList();

      await Provider.of<SentenceProvider>(context, listen: false)
          .eitherFailureOrSentences(
              (selectedTopics.isEmpty || selectedTopics[0] == 0)
                  ? userInterestTopics
                  : selectedTopics,
              selectedType,
              pageKey,
              'asc',
              _searchController.text);
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
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  void dispose() {
    _pagingController.dispose();
    _searchFocusNode.dispose();
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
          SizedBox(
              height: 45,
              child: SearchBar(
                controller: _searchController,
                hintText: 'Nhập câu để tìm kiếm',
                overlayColor:
                    const MaterialStatePropertyAll(Colors.transparent),
                hintStyle: const MaterialStatePropertyAll<TextStyle>(TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                    fontWeight: FontWeight.normal)),
                elevation: const MaterialStatePropertyAll(0),
                shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                    side: const BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(12))),
                backgroundColor:
                    const MaterialStatePropertyAll(Colors.transparent),
                // controller: _searchController,
                padding: const MaterialStatePropertyAll<EdgeInsets>(
                    EdgeInsets.symmetric(horizontal: 12.0, vertical: 2)),
                // focusNode: _searchFocusNode,
                onSubmitted: (String value) {
                  // Handle editing complete (e.g., when user presses Enter)
                  setState(() {
                    isSearching = false;
                  });
                },
                onTap: () {
                  // _searchController.openView();
                },
                onChanged: (value) {
                  setState(() {
                    isSearching = true;
                  });
                  _searchTimer?.cancel();
                  _searchTimer = Timer(const Duration(milliseconds: 500), () {
                    _pagingController.refresh();
                  });
                },
                leading: Icon(
                  Icons.search,
                  size: 28,
                  color: Theme.of(context).colorScheme.primary,
                ),
                trailing: <Widget>[
                  _searchController.text.isNotEmpty
                      ? IconButton(
                          onPressed: () {
                            _searchController.clear();
                            // _searchFocusNode
                            // FocusScope.of(context)
                            //     .requestFocus(_searchFocusNode);
                            _searchFocusNode.requestFocus();
                            // FocusScope.of(context).unfocus();
                            isSearching = false;
                            // _searchFocusNode.unfocus();
                            _pagingController.refresh();
                            setState(() {});
                          },
                          icon: const Icon(Icons.close))
                      : const SizedBox.shrink()
                ],
              )),
          const SizedBox(
            height: 15,
          ),

          Consumer<TopicProvider>(
            builder: (context, topicProvider, _) {
              // List<TopicEntity>? topics = topicProvider.listTopicEntity;
              listTopics = topicProvider.listTopicEntity;

              bool isLoading = topicProvider.isLoading;
              Failure? failure = topicProvider.failure;

              // print(topicProvider.getSelectedTopics());

              if (failure != null) {
                return CustomErrorWidget(
                    title: failure.errorMessage,
                    onTryAgain: () {
                      topicProvider.eitherFailureOrTopics(null, false, null);
                    });
              } else if (!isLoading && listTopics.isEmpty) {
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
                          label: Text(listTopics[index].name),
                          // You may need to adjust the properties based on your TopicEntity

                          backgroundColor: listTopics[index].isSelected
                              ? Colors.tealAccent.shade200.withOpacity(0.6)
                              : Colors.grey.shade200,

                          labelStyle: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  color: listTopics[index].isSelected
                                      ? Theme.of(context)
                                          .colorScheme
                                          .primary
                                          .withOpacity(0.8)
                                      : Colors.grey.shade700),
                          onPressed: () {
                            // Provider.of<TopicProvider>(context, listen: false)
                            //     .handleSelectTopicComPhrase(index);
                            // if (index != 0) {
                            //   listTopics[0].isSelected = false;
                            // } else {
                            //   for (var topic in listTopics) {
                            //     topic.isSelected = false;
                            //   }
                            // }
                            listTopics[index].isSelected =
                                !listTopics[index].isSelected;
                            // if (!listTopics
                            //     .where((topic) => topic.isSelected)
                            //     .isNotEmpty) {
                            //   listTopics[0].isSelected = true;
                            // }
                            setState(() {});

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
                      itemCount: listTopics.length,
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
                  onPressed: () {
                    showModalBottomSheet<void>(
                        backgroundColor: Colors.white,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20)),
                        ),
                        context: context,
                        builder: (BuildContext context) {
                          return StatefulBuilder(builder: (context, setState) {
                            List<TypeEntity> listTypes =
                                Provider.of<TypeProvider>(context, listen: true)
                                    .listTypes;
                            return Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text('Chọn loại câu',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium),
                                  const SizedBox(height: 8.0),
                                  Wrap(
                                    spacing: 8.0,
                                    runSpacing: 8.0,
                                    children: listTypes
                                        .map(
                                          (topic) => ActionChip(
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(
                                                    25.0), // Set the border radius here
                                              ),
                                              side: BorderSide(
                                                  color: topic.id ==
                                                          selectedType
                                                      ? Colors.green.shade500
                                                      : Colors.grey.shade200,
                                                  width: 2),
                                              // backgroundColor: topic.isSelected
                                              //     ? Colors.green.shade500
                                              //     : Colors.white,
                                              label: Text(
                                                topic.name,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium!
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        color: Colors.black),
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  selectedType = topic.id;
                                                  _pagingController.refresh();
                                                });
                                              }),
                                        )
                                        .toList(),
                                  ),
                                ],
                              ),
                            );
                          });
                        });
                  },
                  icon: const Icon(Icons.filter_alt_outlined))
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
