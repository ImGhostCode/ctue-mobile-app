import 'package:ctue_app/core/services/audio_service.dart';
import 'package:ctue_app/features/irregular_verb/business/entities/irr_verb_entity.dart';
import 'package:ctue_app/features/irregular_verb/presentation/pages/irregular_verb_page.dart';
import 'package:ctue_app/features/irregular_verb/presentation/providers/irr_verb_provider.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';

final audioPlayer = AudioService.player;

class IrreVerbManagementPage extends StatefulWidget {
  const IrreVerbManagementPage({super.key});

  @override
  State<IrreVerbManagementPage> createState() => _IrreVerbManagementPageState();
}

class _IrreVerbManagementPageState extends State<IrreVerbManagementPage> {
  String sort = 'asc';
  // static const _pageSize = 20;

  final PagingController<int, IrrVerbEntity> _pagingController =
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
      await Provider.of<IrrVerbProvider>(context, listen: false)
          .eitherFailureOrIrrVerbs(pageKey, 'asc', null);
      final newItems =
          // ignore: use_build_context_synchronously
          Provider.of<IrrVerbProvider>(context, listen: false)
              .irrVerbResEntity!
              .data;

      // ignore: use_build_context_synchronously
      final isLastPage = Provider.of<IrrVerbProvider>(context, listen: false)
              .irrVerbResEntity!
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
  //   Provider.of<IrrVerbProvider>(context, listen: false)
  //       .eitherFailureOrIrrVerbs(1, 'asc', null);
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          scrolledUnderElevation: 0,
          title: Text(
            maxLines: 2,
            textAlign: TextAlign.center,
            'Quản lý động từ \n bất quy tắc',
            style: Theme.of(context).textTheme.titleMedium!.copyWith(),
          ),
          centerTitle: true,
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/add-irregular-verb');
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
                'Tổng cộng: ${Provider.of<IrrVerbProvider>(context, listen: true).irrVerbResEntity?.total}',
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
                        sort = sort == 'asc' ? 'desc' : 'asc';
                        // Provider.of<IrrVerbProvider>(context, listen: false)
                        //     .eitherFailureOrIrrVerbs(1, sort, null);
                      },
                      icon: const Icon(Icons.sort)),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.filter_alt_outlined)),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: PagedListView<int, IrrVerbEntity>(
              pagingController: _pagingController,
              shrinkWrap: true,
              // physics: const NeverScrollableScrollPhysics(),
              builderDelegate: PagedChildBuilderDelegate<IrrVerbEntity>(
                  itemBuilder: (context, item, index) => ListTile(
                      onTap: () => showIrrVerbDetail(context, item, true),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 0),
                      horizontalTitleGap: 4,
                      leading: Container(
                          height: 8,
                          width: 8,
                          decoration: BoxDecoration(
                              color: Colors.green.shade500,
                              shape: BoxShape.circle)),
                      title: Text(item.v1),
                      subtitle: Text(
                        '${item.v2} / ${item.v3}',
                      ),
                      trailing: IconButton(
                          onPressed: () =>
                              showIrrVerbDetail(context, item, true),
                          icon: const Icon(Icons.more_vert)))),
            ),
          ),
        ]),
      ),
    );
  }
}
