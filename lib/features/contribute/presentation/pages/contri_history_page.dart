import 'package:ctue_app/core/constants/constants.dart';
import 'package:ctue_app/features/contribute/business/entities/contribution_entity.dart';
import 'package:ctue_app/features/contribute/presentation/providers/contribution_provider.dart';
import 'package:ctue_app/features/manage/presentation/pages/acc_management_page.dart';
import 'package:ctue_app/features/manage/presentation/pages/contri_management_page.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';

class ContributionHistory extends StatefulWidget {
  const ContributionHistory({super.key});

  @override
  State<ContributionHistory> createState() => _ContributionHistoryState();
}

class _ContributionHistoryState extends State<ContributionHistory> {
  ContriHistoryArguments? args;
  final PagingController<int, ContributionEntity> _pagingController =
      PagingController(firstPageKey: 1);

  @override
  void didChangeDependencies() {
    args = ModalRoute.of(context)!.settings.arguments as ContriHistoryArguments;

    super.didChangeDependencies();
  }

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      if (args?.user != null) {
        await Provider.of<ContributionProvider>(context, listen: false)
            .eitherFailureOrGetAllConByUser(args!.user!.id, pageKey);
      } else {
        await Provider.of<ContributionProvider>(context, listen: false)
            .eitherFailureOrGetAllConByUser(args!.userId!, pageKey);
      }
      final newItems =
          // ignore: use_build_context_synchronously
          Provider.of<ContributionProvider>(context, listen: false)
              .contributionResEntity!
              .data;

      final isLastPage =
          // ignore: use_build_context_synchronously
          Provider.of<ContributionProvider>(context, listen: false)
                  .contributionResEntity!
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
    // if (args.user != null) {
    //   Provider.of<ContributionProvider>(context, listen: false)
    //       .eitherFailureOrGetAllConByUser(args.user!.id, 1);
    // } else {
    //   Provider.of<ContributionProvider>(context, listen: false)
    //       .eitherFailureOrGetAllConByUser(
    //           Provider.of<UserProvider>(context, listen: false).userEntity!.id,
    //           1);
    // }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Colors.white,
          scrolledUnderElevation: 0,
          title: Text(
            'Lịch sử đóng góp',
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
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          const SizedBox(
            height: 10,
          ),
          if (args!.user != null)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Đóng góp bởi: ',
                ),
                Text(
                  args!.user!.name,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.bold, color: Colors.blue),
                ),
              ],
            ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 6),
                    height: 10,
                    width: 10,
                    decoration: BoxDecoration(
                        color: getStatusColor(0),
                        // : Colors.green,
                        shape: BoxShape.circle),
                  ),
                  const Text('Chờ duyệt')
                ],
              ),
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 6),
                    height: 10,
                    width: 10,
                    decoration: BoxDecoration(
                        color: getStatusColor(1),
                        // : Colors.green,
                        shape: BoxShape.circle),
                  ),
                  const Text('Đã duyệt')
                ],
              ),
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 6),
                    height: 10,
                    width: 10,
                    decoration: BoxDecoration(
                        color: getStatusColor(-1),
                        // : Colors.green,
                        shape: BoxShape.circle),
                  ),
                  const Text('Đã từ chối')
                ],
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: PagedListView<int, ContributionEntity>(
              pagingController: _pagingController,
              shrinkWrap: true,
              // physics: const NeverScrollableScrollPhysics(),
              builderDelegate: PagedChildBuilderDelegate<ContributionEntity>(
                itemBuilder: (context, item, index) => ListTile(
                    onTap: () => item.type == ContributionType.word
                        ? showWordConDetail(context, item, item.user!,
                            item.content, item.feedback, false, null)
                        : showSentenceConDetail(context, item, item.user!,
                            item.content, item.feedback, false, null),
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                    // leading: ClipOval(
                    //   child: SizedBox(
                    //     height: 50,
                    //     width: 50,
                    //     child: item.user!.avt != null
                    //         ? Image.network(
                    //             item.user!.avt!,
                    //             fit: BoxFit.cover,
                    //           )
                    //         : Image.asset(
                    //             'assets/images/default-user3.png',
                    //             fit: BoxFit.cover,
                    //           ),
                    //   ),
                    // ),
                    title: Text(item.content['content']),
                    subtitle: Text(
                        '${item.createdAt.day}/${item.createdAt.month}/${item.createdAt.year}'),
                    trailing: Container(
                      height: 10,
                      width: 10,
                      decoration: BoxDecoration(
                          color: getStatusColor(item.status),
                          // : Colors.green,
                          shape: BoxShape.circle),
                    )),
              ),
            ),
          ),
          // ListView(
          //   shrinkWrap: true,
          //   physics: const NeverScrollableScrollPhysics(),
          //   children: [
          //     ...List.generate(
          //         10,
          //         (index) => ListTile(
          //               title: Text('test'),
          //               subtitle: Text('3/4/2024'),
          //               trailing: Container(
          //                 height: 10,
          //                 width: 10,
          //                 decoration: BoxDecoration(
          //                     color: getStatusColor(0),
          //                     // : Colors.green,
          //                     shape: BoxShape.circle),
          //               ),
          //             ))
          // ],
          // )
        ]),
      ),
    );
  }
}
