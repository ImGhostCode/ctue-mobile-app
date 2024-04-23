import 'dart:async';

import 'package:ctue_app/features/home/presentation/pages/dictionary_page.dart';
import 'package:ctue_app/features/manage/presentation/widgets/action_dialog.dart';
import 'package:ctue_app/features/topic/business/entities/topic_entity.dart';
import 'package:ctue_app/features/topic/presentation/providers/topic_provider.dart';
import 'package:ctue_app/features/type/business/entities/type_entity.dart';
import 'package:ctue_app/features/type/presentation/providers/type_provider.dart';
import 'package:ctue_app/features/word/business/entities/word_entity.dart';
import 'package:ctue_app/features/word/presentation/providers/word_provider.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';

class DictionaryManagementPage extends StatefulWidget {
  const DictionaryManagementPage({super.key});

  @override
  State<DictionaryManagementPage> createState() =>
      _DictionaryManagementPageState();
}

class _DictionaryManagementPageState extends State<DictionaryManagementPage> {
  // static const _pageSize = 20;
  final TextEditingController _searchController = TextEditingController();
  bool isSearching = false;
  final FocusNode _searchFocusNode = FocusNode();
  List<int> userInterestTopics = [];
  List<TopicEntity> listTopics = [];
  Timer? _searchTimer;

  List<int> selectedTypes = [];

  final PagingController<int, WordEntity> _pagingController =
      PagingController(firstPageKey: 1);

  @override
  void initState() {
    Provider.of<TopicProvider>(context, listen: false)
        .eitherFailureOrTopics(null, true, null);
    Provider.of<TypeProvider>(context, listen: false).eitherFailureOrGetTypes(
      true,
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
    // Provider.of<WordProvider>(context, listen: false)
    //     .eitherFailureOrWords([], [], 1, 'asc', '');
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      List<int> selectedTopics = listTopics
          .where((topic) => topic.isSelected)
          .map((e) => e.id)
          .toList();

      await Provider.of<WordProvider>(context, listen: false)
          .eitherFailureOrWords(selectedTopics, selectedTypes, pageKey, 'asc',
              _searchController.text);
      final newItems =
          // ignore: use_build_context_synchronously
          Provider.of<WordProvider>(context, listen: false).wordResEntity!.data;

      // final isLastPage = newItems.length < _pageSize;
      // ignore: use_build_context_synchronously
      final isLastPage = Provider.of<WordProvider>(context, listen: false)
              .wordResEntity!
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
    _searchFocusNode.dispose();
    super.dispose();
  }
  // @override
  // void initState() {
  //   Provider.of<WordProvider>(context, listen: false)
  //       .eitherFailureOrWords([], [], 1, 'asc', '');
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          scrolledUnderElevation: 0,
          title: Text(
            'Quản lý từ điển',
            style: Theme.of(context).textTheme.titleMedium!.copyWith(),
          ),
          centerTitle: true,
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/add-word');
                },
                child: Text(
                  'Thêm từ',
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
                hintText: 'Nhập từ để tìm kiếm',
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
                  setState(() {
                    isSearching = false;
                  });
                },
                onTap: () {
                  // _searchController.openView();
                },
                onChanged: (_) {
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
                // trailing: <Widget>[],
              )),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Tổng cộng: ${Provider.of<WordProvider>(context, listen: true).wordResEntity?.total ?? 'Đang tải...'}',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Colors.blue),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                      onPressed: () {
                        _pagingController.itemList =
                            _pagingController.itemList!.reversed.toList();
                      },
                      icon: const Icon(Icons.sort)),
                  IconButton(
                      onPressed: () {
                        showWordFilterModal(context, listTopics, selectedTypes,
                            _pagingController);
                      },
                      icon: const Icon(Icons.filter_alt_outlined)),
                ],
              ),
            ],
          ),
          // const SizedBox(
          //   height: 5,
          // ),
          // const Divider(),
          Expanded(
            child: PagedListView<int, WordEntity>(
              pagingController: _pagingController,
              shrinkWrap: true,
              // physics: const NeverScrollableScrollPhysics(),
              builderDelegate: PagedChildBuilderDelegate<WordEntity>(
                  itemBuilder: (context, item, index) => ListTile(
                        shape: RoundedRectangleBorder(
                            // side: BorderSide(color: Colors.black)
                            borderRadius: BorderRadius.circular(12)),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 0),
                        leading: Container(
                          decoration: const BoxDecoration(
                              // border: Border.all(),
                              // borderRadius: BorderRadius.circular(15)
                              ),
                          height: 40,
                          width: 40,
                          child: item.pictures.isNotEmpty
                              ? Image.network(
                                  item.pictures[0],
                                  errorBuilder: (context, error, stackTrace) =>
                                      Image.asset(
                                    'assets/images/broken-image.png',
                                    color: Colors.grey.shade300,
                                    fit: BoxFit.cover,
                                  ),
                                  fit: BoxFit.cover,
                                )
                              : Container(),
                        ),
                        title: Text(item.content),
                        subtitle: Text(
                          item.meanings[0].meaning,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(
                                  color: Colors.grey.shade500,
                                  fontWeight: FontWeight.w600),
                        ),
                        trailing: IconButton(
                            icon: const Icon(Icons.more_vert),
                            onPressed: () => showActionDialog(
                                  context,
                                  true,
                                  () async {
                                    await Provider.of<WordProvider>(context,
                                            listen: false)
                                        .eitherFailureOrDelWord(item.id);

                                    Navigator.of(context).pop();
                                    if (Provider.of<WordProvider>(context,
                                                listen: false)
                                            .statusCode ==
                                        200) {
                                      setState(() {
                                        _pagingController.itemList!
                                            .remove(item);
                                      });
                                    }
                                  },
                                  () async {
                                    Navigator.pop(context);
                                    Navigator.pushNamed(context, '/edit-word',
                                        arguments: EditWordArguments(
                                            wordEntity: item));
                                  },
                                )),
                        onLongPress: () =>
                            showActionDialog(context, true, () {}, () {}),
                        onTap: () {
                          Navigator.pushNamed(context, '/word-detail',
                              arguments: WordDetailAgrument(id: item.id));
                        },
                      )),
            ),
          ),
        ]),
      ),
    );
  }
}

Future<void> showWordFilterModal(
    BuildContext context,
    List<TopicEntity> listTopics,
    List<int> selectedTypes,
    PagingController<int, WordEntity> _pagingController) {
  return showModalBottomSheet<void>(
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          List<TypeEntity> listTypes =
              Provider.of<TypeProvider>(context, listen: true).listTypes;

          return SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Chọn chủ đề',
                      style: Theme.of(context).textTheme.bodyLarge),
                  const SizedBox(height: 8.0),
                  SizedBox(
                    height: 120,
                    child: ListView.separated(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                              onTap: () {
                                setState(() {
                                  listTopics[index].isSelected =
                                      !listTopics[index].isSelected;
                                });
                                _pagingController.refresh();
                              },
                              child: Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(
                                      color: listTopics[index].isSelected
                                          ? Colors.green.shade500
                                          : Colors.grey.shade100,
                                      width: 2),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    ClipOval(
                                      child: listTopics[index].image.isNotEmpty
                                          ? Image.network(
                                              listTopics[index].image,
                                              errorBuilder: (context, error,
                                                      stackTrace) =>
                                                  Image.asset(
                                                'assets/images/broken-image.png',
                                                color: Colors.grey.shade300,
                                                fit: BoxFit.cover,
                                              ),
                                              fit: BoxFit.cover,
                                              width: 60.0,
                                              height: 60.0,
                                            )
                                          : Container(),
                                    ),
                                    Text(
                                      listTopics[index].name,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                              fontWeight: FontWeight.normal,
                                              color: Colors.black),
                                    ),
                                  ],
                                ),
                              ));
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            width: 4,
                          );
                        },
                        itemCount: listTopics.length),
                  ),
                  const SizedBox(height: 10.0),
                  Text('Chọn loại từ',
                      style: Theme.of(context).textTheme.bodyLarge),
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
                                  color: selectedTypes.contains(topic.id)
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
                                        fontWeight: FontWeight.normal,
                                        color: Colors.black),
                              ),
                              onPressed: () {
                                setState(() {
                                  if (selectedTypes.contains(topic.id)) {
                                    selectedTypes.remove(topic.id);
                                  } else {
                                    selectedTypes.add(topic.id);
                                  }
                                  _pagingController.refresh();
                                });
                              }),
                        )
                        .toList(),
                  ),
                ],
              ),
            ),
          );
        });
      });
}

class EditWordArguments {
  WordEntity wordEntity;

  EditWordArguments({required this.wordEntity});
}
