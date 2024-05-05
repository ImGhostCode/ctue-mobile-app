import 'dart:async';

import 'package:ctue_app/features/manage/presentation/widgets/action_dialog.dart';
import 'package:ctue_app/features/sentence/business/entities/sentence_entity.dart';
import 'package:ctue_app/features/sentence/presentation/pages/communication_phrase_page.dart';
import 'package:ctue_app/features/sentence/presentation/providers/sentence_provider.dart';
import 'package:ctue_app/features/topic/business/entities/topic_entity.dart';
import 'package:ctue_app/features/topic/presentation/providers/topic_provider.dart';
import 'package:ctue_app/features/type/business/entities/type_entity.dart';
import 'package:ctue_app/features/type/presentation/providers/type_provider.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';

class SentenceManagementPage extends StatefulWidget {
  const SentenceManagementPage({super.key});

  @override
  State<SentenceManagementPage> createState() => _SentenceManagementPageState();
}

class _SentenceManagementPageState extends State<SentenceManagementPage> {
  final SearchController _searchController = SearchController();
  final FocusNode _searchFocusNode = FocusNode();
  bool isSearching = false;
  final PagingController<int, SentenceEntity> _pagingController =
      PagingController(firstPageKey: 1);
  List<int> userInterestTopics = [];
  List<TopicEntity> listTopics = [];
  int? selectedType;
  Timer? _searchTimer;

  @override
  void initState() {
    Provider.of<TopicProvider>(context, listen: false).listTopicEntity = [];
    Provider.of<TopicProvider>(context, listen: false)
        .eitherFailureOrTopics(null, false, null);

    Provider.of<TypeProvider>(context, listen: false).eitherFailureOrGetTypes(
      false,
    );

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
      List<int> selectedTopics = listTopics
          .where((topic) => topic.isSelected)
          .map((e) => e.id)
          .toList();

      await Provider.of<SentenceProvider>(context, listen: false)
          .eitherFailureOrSentences(selectedTopics, selectedType, pageKey,
              'asc', _searchController.text);
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
            'Quản lý câu',
            style: Theme.of(context).textTheme.titleMedium!.copyWith(),
          ),
          centerTitle: true,
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/add-sentence');
                },
                child: Text(
                  'Thêm câu',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(color: Colors.teal),
                )),
            const SizedBox(
              width: 10,
            )
          ],
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
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
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
                  _searchTimer = Timer(const Duration(milliseconds: 300), () {
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
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Tổng cộng: ${Provider.of<SentenceProvider>(context, listen: true).sentenceResEntity?.total ?? 'Đang tải...'}',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Colors.blue),
              ),
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
                              List<TypeEntity> listTypes =
                                  Provider.of<TypeProvider>(context,
                                          listen: true)
                                      .listTypes;
                              return StatefulBuilder(
                                  builder: (context, setState) {
                                return SingleChildScrollView(
                                  child: SizedBox(
                                    width: double.infinity,
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text('Chọn chủ đề',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge),
                                          const SizedBox(height: 8.0),
                                          Wrap(
                                            spacing: 8.0,
                                            runSpacing: 8.0,
                                            children: listTopics
                                                .map(
                                                  (topic) => ActionChip(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                25.0), // Set the border radius here
                                                      ),
                                                      side: BorderSide(
                                                          color:
                                                              topic.isSelected
                                                                  ? Colors.green
                                                                      .shade500
                                                                  : Colors.grey
                                                                      .shade200,
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
                                                                    FontWeight
                                                                        .normal,
                                                                color: Colors
                                                                    .black),
                                                      ),
                                                      onPressed: () {
                                                        setState(() {
                                                          topic.isSelected =
                                                              !topic.isSelected;
                                                        });
                                                        _pagingController
                                                            .refresh();
                                                      }),
                                                )
                                                .toList(),
                                          ),
                                          const SizedBox(height: 10.0),
                                          Text('Chọn loại câu',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge),
                                          const SizedBox(height: 8.0),
                                          Wrap(
                                            spacing: 8.0,
                                            runSpacing: 8.0,
                                            children: listTypes
                                                .map(
                                                  (topic) => ActionChip(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                25.0), // Set the border radius here
                                                      ),
                                                      side: BorderSide(
                                                          color: topic.id ==
                                                                  selectedType
                                                              ? Colors.green
                                                                  .shade500
                                                              : Colors.grey
                                                                  .shade200,
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
                                                                    FontWeight
                                                                        .normal,
                                                                color: Colors
                                                                    .black),
                                                      ),
                                                      onPressed: () {
                                                        setState(() {
                                                          selectedType =
                                                              topic.id;
                                                          _pagingController
                                                              .refresh();
                                                        });
                                                      }),
                                                )
                                                .toList(),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              });
                            });
                      },
                      icon: const Icon(Icons.filter_alt_outlined))
                ],
              ),
            ],
          ),
          // const SizedBox(
          //   height: 5,
          // ),
          const Divider(),
          Expanded(
            child: PagedListView<int, SentenceEntity>(
              pagingController: _pagingController,
              shrinkWrap: true,
              // physics: const NeverScrollableScrollPhysics(),
              builderDelegate: PagedChildBuilderDelegate<SentenceEntity>(
                  itemBuilder: (context, item, index) => ListTile(
                        onLongPress: () =>
                            showActionDialog(context, false, () {}, () {}),
                        minVerticalPadding: 0,
                        leading: Text(
                          '${index + 1}',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        minLeadingWidth: 15,
                        contentPadding: const EdgeInsets.only(
                            left: 4, top: 0, bottom: 0, right: 0),
                        title: Text(item.content),
                        subtitle: Text(
                          item.meaning,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        trailing: IconButton(
                          icon: const Icon(
                            Icons.more_vert,
                          ),
                          onPressed: () {
                            showActionDialog(
                              context,
                              false,
                              () async {
                                await Provider.of<SentenceProvider>(context,
                                        listen: false)
                                    .eitherFailureOrDelSentence(item.id);

                                // ignore: use_build_context_synchronously
                                Navigator.of(context).pop();
                                // ignore: use_build_context_synchronously
                                if (Provider.of<SentenceProvider>(context,
                                            listen: false)
                                        .statusCode ==
                                    200) {
                                  setState(() {
                                    _pagingController.itemList!.remove(item);
                                  });
                                }
                              },
                              () async {
                                Navigator.pop(context);
                                Navigator.pushNamed(context, '/edit-sentence',
                                    arguments: EditSentenceArguments(
                                        sentenceEntity: item));
                              },
                            );
                          },
                        ),
                        onTap: () {
                          Navigator.pushNamed(
                              context, '/communication-phrase-detail',
                              arguments: ComPhraseArguments(id: item.id));
                        },
                      )),
            ),
          ),
        ]),
      ),
    );
  }
}

class EditSentenceArguments {
  SentenceEntity sentenceEntity;

  EditSentenceArguments({required this.sentenceEntity});
}
