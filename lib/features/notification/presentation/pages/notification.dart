import 'package:ctue_app/features/notification/business/entities/notification_entity.dart';
import 'package:ctue_app/features/notification/presentation/providers/notification_provider.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final PagingController<int, NotificationEntity> _pagingController =
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
      await Provider.of<NotificationProvider>(context, listen: false)
          .eitherFailureOrGetAllNotiNoti(pageKey);
      final newItems =
          // ignore: use_build_context_synchronously
          Provider.of<NotificationProvider>(context, listen: false)
              .notiResEntity!
              .data;

      final isLastPage =
          // ignore: use_build_context_synchronously
          Provider.of<NotificationProvider>(context, listen: false)
                  .notiResEntity!
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
          centerTitle: true,
          title: Text(
            'Thông báo',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          backgroundColor: Colors.white,
          scrolledUnderElevation: 0,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.chevron_left_rounded,
              size: 30,
            ),
          )),
      body: PagedListView<int, NotificationEntity>.separated(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        pagingController: _pagingController,
        shrinkWrap: true,
        // physics: const NeverScrollableScrollPhysics(),
        separatorBuilder: (context, index) {
          return const Divider(
            height: 5,
          );
        },
        builderDelegate: PagedChildBuilderDelegate<NotificationEntity>(
            itemBuilder: (context, item, index) => Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      // border: Border.all(color: Colors.blue, width: 1.5),
                      borderRadius: BorderRadius.circular(12)),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            FittedBox(
                              child: CircleAvatar(

                                  // radius: 25.0, // Set the radius of the circle
                                  backgroundColor: Colors.blue
                                      .shade700, // Set the background color of the circle
                                  child: ClipOval(
                                    child: Image.asset(
                                      'assets/images/ctue-high-resolution-logo-transparent3.png',
                                      height: 50,
                                      width: 50,
                                      fit: BoxFit.contain,
                                    ),
                                  )),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'CTUE',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  '${item.createdAt.day}/${item.createdAt.month}/${item.createdAt.year}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(color: Colors.grey),
                                )
                              ],
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          item.title,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          item.body,
                        ),
                      ]),
                )),
      ),
    );
  }
}
