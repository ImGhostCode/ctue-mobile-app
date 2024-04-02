import 'package:ctue_app/features/home/presentation/pages/dictionary_page.dart';
import 'package:ctue_app/features/manage/presentation/widgets/action_dialog.dart';
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

  final PagingController<int, WordEntity> _pagingController =
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
      await Provider.of<WordProvider>(context, listen: false)
          .eitherFailureOrWords([], [], pageKey, 'asc', '');
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
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          SizedBox(
              height: 45,
              child: SearchBar(
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
                'Tổng cộng: ${Provider.of<WordProvider>(context, listen: true).wordResEntity?.total}',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Colors.blue),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(onPressed: () {}, icon: const Icon(Icons.sort)),
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
                            onPressed: () =>
                                showActionDialog(context, true, () {})),
                        onLongPress: () =>
                            showActionDialog(context, true, () {}),
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
