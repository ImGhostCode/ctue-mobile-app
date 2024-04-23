import 'dart:async';

import 'package:ctue_app/core/constants/constants.dart';
import 'package:ctue_app/features/specialization/business/entities/specialization_entity.dart';
import 'package:ctue_app/features/specialization/presentation/providers/spec_provider.dart';
import 'package:ctue_app/features/topic/business/entities/topic_entity.dart';
import 'package:ctue_app/features/topic/presentation/providers/topic_provider.dart';
import 'package:ctue_app/features/vocabulary_pack/business/entities/voca_set_entity.dart';
import 'package:ctue_app/features/vocabulary_pack/presentation/providers/voca_set_provider.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';

class VocaSetManagementPage extends StatefulWidget {
  const VocaSetManagementPage({super.key});

  @override
  State<VocaSetManagementPage> createState() => _VocaSetManagementPageState();
}

class _VocaSetManagementPageState extends State<VocaSetManagementPage> {
  final FocusNode _searchFocusNode = FocusNode();

  final TextEditingController _searchController = TextEditingController();
  String sort = 'asc';
  // static const _pageSize = 20;
  bool isSearching = false;
  Timer? _debounce;
  List<TopicEntity> listTopics = [];
  int? selectedSpecialization;
  int? selectedTopic;

  final PagingController<int, VocaSetEntity> _pagingController =
      PagingController(firstPageKey: 1);

  @override
  void initState() {
    Provider.of<TopicProvider>(context, listen: false)
        .eitherFailureOrTopics(null, true, null);
    Provider.of<SpecializationProvider>(context, listen: false)
        .eitherFailureOrGetSpecializations();
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
      await Provider.of<VocaSetProvider>(context, listen: false)
          .eitherFailureOrGetVocaSetsByAdmin(selectedSpecialization,
              selectedTopic, _searchController.text, pageKey);
      final newItems =
          // ignore: use_build_context_synchronously
          Provider.of<VocaSetProvider>(context, listen: false)
              .vocabularySetResEntity!
              .data;

      final isLastPage =
          // ignore: use_build_context_synchronously
          Provider.of<VocaSetProvider>(context, listen: false)
                  .vocabularySetResEntity!
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          scrolledUnderElevation: 0,
          title: Text(
            'Quản lý bộ từ vựng',
            style: Theme.of(context).textTheme.titleMedium!.copyWith(),
          ),
          centerTitle: true,
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/create-vocabulary-set',
                      arguments: CreateVocaSetArgument(
                          isAdmin: true,
                          callback: () {
                            Navigator.pop(context);
                            _pagingController.refresh();
                          }));
                },
                child: Text(
                  'Thêm',
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
        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
        child: Column(
          children: [
            Column(
              children: [
                Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      SizedBox(
                          height: 45,
                          child: SearchBar(
                            controller: _searchController,
                            hintText: 'Nhập câu để tìm kiếm',
                            overlayColor: const MaterialStatePropertyAll(
                                Colors.transparent),
                            hintStyle:
                                const MaterialStatePropertyAll<TextStyle>(
                                    TextStyle(
                                        color: Colors.grey,
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal)),
                            elevation: const MaterialStatePropertyAll(0),
                            shape: MaterialStatePropertyAll(
                                RoundedRectangleBorder(
                                    side: const BorderSide(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(12))),
                            backgroundColor: const MaterialStatePropertyAll(
                                Colors.transparent),
                            // controller: _searchController,
                            padding: const MaterialStatePropertyAll<EdgeInsets>(
                                EdgeInsets.symmetric(
                                    horizontal: 12.0, vertical: 2)),
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
                              _debounce?.cancel();
                              _debounce =
                                  Timer(const Duration(milliseconds: 500), () {
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
                                  : const SizedBox.shrink(),
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
                            'Tổng cộng: ${Provider.of<VocaSetProvider>(context, listen: true).vocabularySetResEntity?.total ?? 'Đang tải...'}',
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
                                        _pagingController.itemList!.reversed
                                            .toList();
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
                                          return StatefulBuilder(
                                              builder: (context, setState) {
                                            List<SpecializationEntity>
                                                listSpecicalizations =
                                                Provider.of<SpecializationProvider>(
                                                        context,
                                                        listen: true)
                                                    .listSpecializations;

                                            return SingleChildScrollView(
                                              child: SizedBox(
                                                width: double.infinity,
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      16.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Text('Chọn chủ đề',
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyLarge),
                                                      const SizedBox(
                                                          height: 8.0),
                                                      SizedBox(
                                                        height: 120,
                                                        child:
                                                            ListView.separated(
                                                                shrinkWrap:
                                                                    true,
                                                                scrollDirection:
                                                                    Axis
                                                                        .horizontal,
                                                                itemBuilder:
                                                                    (context,
                                                                        index) {
                                                                  return GestureDetector(
                                                                      onTap:
                                                                          () {
                                                                        setState(
                                                                            () {
                                                                          listTopics[index].isSelected =
                                                                              !listTopics[index].isSelected;
                                                                          if (listTopics[index]
                                                                              .isSelected) {
                                                                            selectedTopic =
                                                                                listTopics[index].id;
                                                                          } else {
                                                                            selectedTopic =
                                                                                null;
                                                                          }
                                                                        });
                                                                        _pagingController
                                                                            .refresh();
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        height:
                                                                            100,
                                                                        width:
                                                                            100,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          borderRadius:
                                                                              BorderRadius.circular(15),
                                                                          border: Border.all(
                                                                              color: listTopics[index].isSelected ? Colors.green.shade500 : Colors.grey.shade100,
                                                                              width: 2),
                                                                        ),
                                                                        child:
                                                                            Column(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.center,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.center,
                                                                          children: [
                                                                            ClipOval(
                                                                              child: listTopics[index].image.isNotEmpty
                                                                                  ? Image.network(
                                                                                      listTopics[index].image,
                                                                                      errorBuilder: (context, error, stackTrace) => Image.asset(
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
                                                                              style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.normal, color: Colors.black),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ));
                                                                },
                                                                separatorBuilder:
                                                                    (context,
                                                                        index) {
                                                                  return const SizedBox(
                                                                    width: 4,
                                                                  );
                                                                },
                                                                itemCount:
                                                                    listTopics
                                                                        .length),
                                                      ),
                                                      const SizedBox(
                                                          height: 10.0),
                                                      Text('Chọn chuyên ngành',
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyLarge),
                                                      const SizedBox(
                                                          height: 8.0),
                                                      Wrap(
                                                        spacing: 8.0,
                                                        runSpacing: 8.0,
                                                        children:
                                                            listSpecicalizations
                                                                .map(
                                                                  (spec) => ActionChip(
                                                                      shape: RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(25.0), // Set the border radius here
                                                                      ),
                                                                      side: BorderSide(color: selectedSpecialization == spec.id ? Colors.green.shade500 : Colors.grey.shade200, width: 2),
                                                                      // backgroundColor: topic.isSelected
                                                                      //     ? Colors.green.shade500
                                                                      //     : Colors.white,
                                                                      label: Text(
                                                                        spec.name,
                                                                        style: Theme.of(context)
                                                                            .textTheme
                                                                            .bodyMedium!
                                                                            .copyWith(
                                                                                fontWeight: FontWeight.normal,
                                                                                color: Colors.black),
                                                                      ),
                                                                      onPressed: () {
                                                                        setState(
                                                                            () {
                                                                          selectedSpecialization =
                                                                              spec.id;
                                                                        });
                                                                        _pagingController
                                                                            .refresh();
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
                                  icon: const Icon(Icons.filter_alt_outlined)),
                            ],
                          ),
                        ],
                      ),
                      // const SizedBox(
                      //   height: 5,
                      // ),
                      const Divider(),
                    ],
                  ),
                ),
              ],
            ),
            Expanded(
              child: PagedListView<int, VocaSetEntity>.separated(
                pagingController: _pagingController,
                shrinkWrap: true,
                // physics: const NeverScrollableScrollPhysics(),
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 5,
                  );
                },
                builderDelegate: PagedChildBuilderDelegate<VocaSetEntity>(
                    itemBuilder: (context, item, index) => ListTile(
                        minVerticalPadding: 4,
                        onTap: () {
                          Navigator.pushNamed(context, '/vocabulary-set-detail',
                              arguments: VocabularySetArguments(
                                  id: item.id, isAdmin: true));
                        },
                        onLongPress: () => showActionDialog(context, item),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 10),
                        shape: RoundedRectangleBorder(
                            side: BorderSide(
                                color: item.isPublic
                                    ? Colors.green
                                    : Colors.yellow.shade700,
                                width: 1.5),
                            borderRadius: BorderRadius.circular(12)),
                        tileColor: Colors.white,
                        leading: item.picture == null
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
                                    image: NetworkImage(item.picture!),
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                        title: Text(item.title),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              height: 8,
                              width: 8,
                              decoration: BoxDecoration(
                                  color: item.isPublic
                                      ? Colors.green
                                      : Colors.yellow.shade700,
                                  shape: BoxShape.circle),
                            ),
                            IconButton(
                                onPressed: () =>
                                    showActionDialog(context, item),
                                icon: const Icon(Icons.more_vert))
                          ],
                        ))),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<String?> showActionDialog(
      BuildContext context, VocaSetEntity vocaSetEntity) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        // title: Text(
        //   'AlertDialog Title $index',
        // ),
        buttonPadding: EdgeInsets.zero,
        contentPadding: EdgeInsets.zero,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
        content: SizedBox(
          // height: 65,
          width: MediaQuery.of(context).size.width - 100,
          child: ListView(shrinkWrap: true, children: [
            TextButton(
                style: const ButtonStyle(
                    padding: MaterialStatePropertyAll(
                        EdgeInsets.symmetric(horizontal: 16, vertical: 18)),
                    shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero)),
                    backgroundColor: MaterialStatePropertyAll(Colors.white)),
                onPressed: () {
                  Navigator.pushNamed(context, '/edit-voca-set',
                      arguments: EditVocaSetArguments(
                        vocaSetEntity: vocaSetEntity,
                        isAdmin: true,
                        callback: () {
                          Navigator.pop(context);
                          _pagingController.refresh();
                          Navigator.pop(context);
                        },
                      ));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.edit,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    const Text(
                      textAlign: TextAlign.left,
                      'Chỉnh sửa',
                    ),
                  ],
                )),
            TextButton(
                style: const ButtonStyle(
                    padding: MaterialStatePropertyAll(
                        EdgeInsets.symmetric(horizontal: 16, vertical: 18)),
                    shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero)),
                    backgroundColor: MaterialStatePropertyAll(Colors.white)),
                onPressed: () {
                  Navigator.of(context).pop();
                  showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                            backgroundColor: Colors.white,
                            surfaceTintColor: Colors.white,
                            shadowColor: Colors.white,
                            title: Text(
                              'Cảnh báo',
                              style: TextStyle(
                                  color: Colors.red.shade400,
                                  fontWeight: FontWeight.bold),
                            ),
                            content: const Text(
                                'Bạn có chắc chắn muốn xóa bộ từ này không?'),
                            actionsAlignment: MainAxisAlignment.spaceBetween,
                            actions: <Widget>[
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.grey.shade400,
                                  textStyle:
                                      Theme.of(context).textTheme.labelLarge,
                                ),
                                child: const Text('Trở về'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  textStyle:
                                      Theme.of(context).textTheme.labelLarge,
                                ),
                                onPressed: Provider.of<VocaSetProvider>(context,
                                            listen: true)
                                        .isLoading
                                    ? null
                                    : () async {
                                        await Provider.of<VocaSetProvider>(
                                                context,
                                                listen: false)
                                            .eitherFailureOrRmVocaSet(
                                                vocaSetEntity.id, false);
                                        _pagingController.itemList!
                                            .remove(vocaSetEntity);
                                        Navigator.of(context).pop();
                                      },
                                child: Provider.of<VocaSetProvider>(context,
                                            listen: true)
                                        .isLoading
                                    ? const SizedBox(
                                        height: 25,
                                        width: 25,
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                        ),
                                      )
                                    : const Text('Đồng ý'),
                              ),
                            ],
                          ));
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                        textAlign: TextAlign.right,
                        style: TextStyle(color: Colors.red),
                        'Xóa'),
                  ],
                ))
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
    );
  }
}

class CreateVocaSetArgument {
  final bool isAdmin;
  VoidCallback callback;

  CreateVocaSetArgument({required this.isAdmin, required this.callback});
}

class EditVocaSetArguments {
  VocaSetEntity vocaSetEntity;
  bool isAdmin;
  VoidCallback callback;

  EditVocaSetArguments(
      {required this.vocaSetEntity,
      required this.isAdmin,
      required this.callback});
}
