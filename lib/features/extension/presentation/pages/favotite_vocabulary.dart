import 'dart:async';

import 'package:ctue_app/features/extension/business/entities/favorite_entity.dart';
import 'package:ctue_app/features/extension/presentation/providers/favorite_provider.dart';
import 'package:ctue_app/features/home/presentation/pages/dictionary_page.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';

class FavoriteVocabulary extends StatefulWidget {
  const FavoriteVocabulary({super.key});

  @override
  State<FavoriteVocabulary> createState() => _FavoriteVocabularyState();
}

class _FavoriteVocabularyState extends State<FavoriteVocabulary> {
  final TextEditingController _searchController = TextEditingController();

  final FocusNode _searchFocusNode = FocusNode();
  Timer? _searchTimer;

  final List<Word> _searchResults = [
    // Word(
    //     id: 1,
    //     content: 'orange',
    //     meaning: 'quả cam',
    //     picture:
    //         'https://quickblox.com/wp-content/uploads/2019/12/what-is-flutter.png'),
    // Word(
    //     id: 2,
    //     content: 'test',
    //     meaning: 'kiem tra',
    //     picture:
    //         'https://quickblox.com/wp-content/uploads/2019/12/what-is-flutter.png'),
    // Word(
    //     id: 3,
    //     content: 'make',
    //     meaning: 'lam',
    //     picture:
    //         'https://quickblox.com/wp-content/uploads/2019/12/what-is-flutter.png'),
  ];

  final PagingController<int, FavoriteEntity> _pagingController =
      PagingController(firstPageKey: 1);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });

    _searchFocusNode.addListener(() {
      if (!_searchFocusNode.hasFocus) {
        // setState(() {
        //   isSearching = false;
        // });
      }
    });
    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      await Provider.of<FavoriteProvider>(context, listen: false)
          .eitherFailureOrGetFavorites(pageKey, 'asc', _searchController.text);
      final newItems =
          // ignore: use_build_context_synchronously
          Provider.of<FavoriteProvider>(context, listen: false)
              .favoriteResEntity!
              .data;

      // ignore: use_build_context_synchronously
      final isLastPage = Provider.of<FavoriteProvider>(context, listen: false)
              .favoriteResEntity!
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
          centerTitle: true,
          title: Text(
            'Từ vựng yêu thích của bạn',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          surfaceTintColor: Colors.white,
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
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Column(
          children: [
            SizedBox(
                height: 45,
                child: SearchBar(
                  controller: _searchController,
                  focusNode: _searchFocusNode,
                  hintText: 'Nhập từ để tra cứu',
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
                  padding: const MaterialStatePropertyAll<EdgeInsets>(
                      EdgeInsets.symmetric(horizontal: 12.0, vertical: 2)),
                  onChanged: (_) {
                    // _searchController.openView();
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
                    Visibility(
                      visible: _searchController.text.isNotEmpty,
                      child: IconButton(
                        onPressed: () {
                          _searchController.clear();
                          _searchResults
                              .clear(); // Clear the search results list
                          setState(() {}); // Update the UI
                          _searchFocusNode.requestFocus();
                        },
                        icon: const Icon(Icons.close),
                      ),
                    )
                  ],
                )),
            const SizedBox(
              height: 8,
            ),
            if (_searchResults.isEmpty)
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
                      onPressed: () {},
                      icon: const Icon(Icons.filter_alt_outlined)),
                ],
              ),
            const Divider(),
            Expanded(
              child: PagedListView<int, FavoriteEntity>(
                pagingController: _pagingController,
                shrinkWrap: true,
                // physics: const NeverScrollableScrollPhysics(),

                builderDelegate: PagedChildBuilderDelegate<FavoriteEntity>(
                    itemBuilder: (context, item, index) {
                  return ListTile(
                    shape: RoundedRectangleBorder(
                        // side: BorderSide(color: Colors.black)
                        borderRadius: BorderRadius.circular(12)),
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                    leading: Container(
                      decoration: const BoxDecoration(
                          // border: Border.all(),
                          // borderRadius: BorderRadius.circular(15)
                          ),
                      height: 40,
                      width: 40,
                      child: item.word!.pictures.isNotEmpty
                          ? Image.network(
                              item.word!.pictures[0],
                              fit: BoxFit.cover,
                            )
                          : Container(),
                    ),
                    title: Text(item.word!.content),
                    subtitle: Text(
                      item.word!.meanings[0].meaning,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Colors.grey.shade500,
                          fontWeight: FontWeight.w600),
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, '/word-detail',
                          arguments: WordDetailAgrument(id: item.word!.id));
                    },
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
