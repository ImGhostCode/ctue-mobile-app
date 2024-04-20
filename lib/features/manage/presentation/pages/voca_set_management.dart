import 'package:ctue_app/core/constants/constants.dart';
import 'package:ctue_app/features/vocabulary_set/business/entities/voca_set_entity.dart';
import 'package:ctue_app/features/vocabulary_set/presentation/providers/voca_set_provider.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';

class VocaSetManagementPage extends StatefulWidget {
  const VocaSetManagementPage({super.key});

  @override
  State<VocaSetManagementPage> createState() => _VocaSetManagementPageState();
}

class _VocaSetManagementPageState extends State<VocaSetManagementPage> {
  final PagingController<int, VocaSetEntity> _pagingController =
      PagingController(firstPageKey: 1);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      await Provider.of<VocaSetProvider>(context, listen: false)
          .eitherFailureOrGetVocaSetsByAdmin(null, null, '', pageKey);
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
                              // Handle editing complete (e.g., when user presses Enter)
                              // setState(() {
                              //   isSearching = false;
                              // });
                            },
                            onTap: () {
                              // _searchController.openView();
                            },
                            onChanged: (_) {
                              // _searchController.openView();
                              // setState(() {
                              //   isSearching = true;
                              // });
                            },
                            leading: Icon(
                              Icons.search,
                              size: 28,
                              color: Theme.of(context).colorScheme.primary,
                            ),
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
                                  onPressed: () {},
                                  icon: const Icon(Icons.sort)),
                              IconButton(
                                  onPressed: () {},
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
