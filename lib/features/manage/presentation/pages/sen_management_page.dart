import 'package:ctue_app/features/manage/presentation/widgets/action_dialog.dart';
import 'package:ctue_app/features/sentence/business/entities/sentence_entity.dart';
import 'package:ctue_app/features/sentence/presentation/pages/communication_phrase_page.dart';
import 'package:ctue_app/features/sentence/presentation/providers/sentence_provider.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';

class SentenceManagementPage extends StatefulWidget {
  const SentenceManagementPage({super.key});

  @override
  State<SentenceManagementPage> createState() => _SentenceManagementPageState();
}

class _SentenceManagementPageState extends State<SentenceManagementPage> {
  // static const _pageSize = 20;

  final PagingController<int, SentenceEntity> _pagingController =
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
      await Provider.of<SentenceProvider>(context, listen: false)
          .eitherFailureOrSentences([], null, pageKey, 'asc');
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
    super.dispose();
  }

  // @override
  // void initState() {
  //   Provider.of<SentenceProvider>(context, listen: false)
  //       .eitherFailureOrSentences([], null, 1, 'asc');
  //   super.initState();
  // }

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
                'Tổng cộng: ${Provider.of<SentenceProvider>(context, listen: true).sentenceResEntity?.total ?? 'Đang tải...'}',
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
                          item.mean,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        trailing: IconButton(
                          icon: const Icon(
                            Icons.more_vert,
                          ),
                          onPressed: () {
                            showActionDialog(context, false, () {}, () {});
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
