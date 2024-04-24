import 'package:ctue_app/core/constants/memory_level_constants.dart';
import 'package:ctue_app/features/learn/business/entities/user_learned_word_entity.dart';
import 'package:ctue_app/features/learn/presentation/pages/learned_result.dart';
import 'package:ctue_app/features/learn/presentation/providers/learn_provider.dart';
import 'package:ctue_app/features/manage/presentation/pages/account_detail_page.dart';
import 'package:ctue_app/features/profile/presentation/widgets/radial_bar_chart.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';

class LearningHistoryPage extends StatefulWidget {
  const LearningHistoryPage({super.key});

  @override
  State<LearningHistoryPage> createState() => _LearningHistoryPageState();
}

class _LearningHistoryPageState extends State<LearningHistoryPage> {
  LearningHistoryArguments? args;
  final PagingController<int, UserLearnedWordEntity> _pagingController =
      PagingController(firstPageKey: 1);
  int? selectedLevel;
  String sort = 'desc';

  @override
  void didChangeDependencies() {
    args =
        ModalRoute.of(context)!.settings.arguments as LearningHistoryArguments;

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
      // if (args?.user != null) {
      await Provider.of<LearnProvider>(context, listen: false)
          .eitherFailureOrGetLearningHistory(
              args!.user!.id, pageKey, selectedLevel, sort);
      final newItems =
          // ignore: use_build_context_synchronously
          Provider.of<LearnProvider>(context, listen: false)
              .learnResEntity!
              .data;

      final isLastPage =
          // ignore: use_build_context_synchronously
          Provider.of<LearnProvider>(context, listen: false)
                  .learnResEntity!
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
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Colors.white,
          scrolledUnderElevation: 0,
          title: Text(
            'Lịch sử học tập',
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
          if (args!.user != null)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Người học: ',
                ),
                Text(
                  args!.user!.name,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.bold, color: Colors.blue),
                ),
              ],
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                  onPressed: () {
                    setState(() {
                      sort = sort == 'desc' ? 'asc' : 'desc';
                    });
                    _pagingController.refresh();
                  },
                  icon: const Icon(Icons.sort)),
              IconButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return StatefulBuilder(
                          builder: (context, setState) {
                            return Container(
                              decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20))),
                              padding: const EdgeInsets.all(16),
                              // height: 200,
                              width: double.infinity,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Chọn cấp độ',
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                  const SizedBox(height: 10),
                                  Wrap(
                                    children: [
                                      ActionChip(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                25.0), // Set the border radius here
                                          ),
                                          side: BorderSide(
                                              color: selectedLevel == null
                                                  ? Colors.green.shade500
                                                  : Colors.grey.shade100,
                                              width: 2),
                                          // backgroundColor: topic.isSelected
                                          //     ? Colors.green.shade500
                                          //     : Colors.white,
                                          label: Text(
                                            'Tất cả cấp độ',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .copyWith(
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color: Colors.black),
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              selectedLevel = null;
                                            });
                                            _pagingController.refresh();
                                          }),
                                      const SizedBox(width: 10),
                                      ActionChip(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                25.0), // Set the border radius here
                                          ),
                                          side: BorderSide(
                                              color: selectedLevel == 1
                                                  ? Colors.green.shade500
                                                  : Colors.grey.shade100,
                                              width: 2),
                                          // backgroundColor: topic.isSelected
                                          //     ? Colors.green.shade500
                                          //     : Colors.white,
                                          label: Text(
                                            'Cấp độ 1',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .copyWith(
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color: Colors.black),
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              selectedLevel = 1;
                                            });
                                            _pagingController.refresh();
                                          }),
                                      const SizedBox(width: 10),
                                      ActionChip(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                25.0), // Set the border radius here
                                          ),
                                          side: BorderSide(
                                              color: selectedLevel == 2
                                                  ? Colors.green.shade500
                                                  : Colors.grey.shade100,
                                              width: 2),
                                          // backgroundColor: topic.isSelected
                                          //     ? Colors.green.shade500
                                          //     : Colors.white,
                                          label: Text(
                                            'Cấp độ 2',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .copyWith(
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color: Colors.black),
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              selectedLevel = 2;
                                            });
                                            _pagingController.refresh();
                                          }),
                                      const SizedBox(width: 10),
                                      ActionChip(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                25.0), // Set the border radius here
                                          ),
                                          side: BorderSide(
                                              color: selectedLevel == 3
                                                  ? Colors.green.shade500
                                                  : Colors.grey.shade100,
                                              width: 2),
                                          // backgroundColor: topic.isSelected
                                          //     ? Colors.green.shade500
                                          //     : Colors.white,
                                          label: Text(
                                            'Cấp độ 3',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .copyWith(
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color: Colors.black),
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              selectedLevel = 3;
                                            });
                                            _pagingController.refresh();
                                          }),
                                      const SizedBox(width: 10),
                                      ActionChip(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                25.0), // Set the border radius here
                                          ),
                                          side: BorderSide(
                                              color: selectedLevel == 4
                                                  ? Colors.green.shade500
                                                  : Colors.grey.shade100,
                                              width: 2),
                                          // backgroundColor: topic.isSelected
                                          //     ? Colors.green.shade500
                                          //     : Colors.white,
                                          label: Text(
                                            'Cấp độ 4',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .copyWith(
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color: Colors.black),
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              selectedLevel = 4;
                                            });
                                            _pagingController.refresh();
                                          }),
                                      const SizedBox(width: 10),
                                      ActionChip(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                25.0), // Set the border radius here
                                          ),
                                          side: BorderSide(
                                              color: selectedLevel == 5
                                                  ? Colors.green.shade500
                                                  : Colors.grey.shade100,
                                              width: 2),
                                          // backgroundColor: topic.isSelected
                                          //     ? Colors.green.shade500
                                          //     : Colors.white,
                                          label: Text(
                                            'Cấp độ 5',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .copyWith(
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color: Colors.black),
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              selectedLevel = 5;
                                            });
                                            _pagingController.refresh();
                                          }),
                                      const SizedBox(width: 10),
                                      ActionChip(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                25.0), // Set the border radius here
                                          ),
                                          side: BorderSide(
                                              color: selectedLevel == 6
                                                  ? Colors.green.shade500
                                                  : Colors.grey.shade100,
                                              width: 2),
                                          // backgroundColor: topic.isSelected
                                          //     ? Colors.green.shade500
                                          //     : Colors.white,
                                          label: Text(
                                            'Nhớ sâu',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .copyWith(
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color: Colors.black),
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              selectedLevel = 6;
                                            });
                                          }),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                  icon: const Icon(Icons.filter_alt_outlined)),
            ],
          ),
          const Divider(),
          Expanded(
            child: PagedListView<int, UserLearnedWordEntity>(
              pagingController: _pagingController,
              shrinkWrap: true,
              // physics: const NeverScrollableScrollPhysics(),
              builderDelegate: PagedChildBuilderDelegate<UserLearnedWordEntity>(
                  itemBuilder: (context, item, index) {
                final MemoryLevel level = getMemoryLevel(item.memoryLevel);

                return ListTile(
                  title: Text(item.word!.content),
                  subtitle: Text(item.createdAt!.toString().substring(0, 19)),
                  leading: RadialBarChart(
                      fontWeight: FontWeight.normal,
                      radius: '100%',
                      innerRadius: '70%',
                      title: level.title,
                      color: level.color,
                      initialPercent: level.percent,
                      diameter: level.diameter,
                      fontSize: level.fontSize),
                );
              }),
            ),
          ),
        ]),
      ),
    );
  }
}
