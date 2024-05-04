import 'package:ctue_app/core/errors/failure.dart';
import 'package:ctue_app/features/statistics/business/entities/contri_stat_entity.dart';
import 'package:ctue_app/features/statistics/business/entities/irr_verb_stat_entity.dart';
import 'package:ctue_app/features/statistics/business/entities/sen_stat_entity.dart';
import 'package:ctue_app/features/statistics/business/entities/user_stat_entity.dart';
import 'package:ctue_app/features/statistics/business/entities/voca_set_stat_entity.dart';
import 'package:ctue_app/features/statistics/business/entities/word_stat_entity.dart';
import 'package:ctue_app/features/statistics/presentation/providers/statistics_provider.dart';
import 'package:ctue_app/features/statistics/presentation/widgets/bar_chart.dart';
import 'package:ctue_app/features/statistics/presentation/widgets/colum_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class OverviewPage extends StatefulWidget {
  const OverviewPage({super.key});

  @override
  State<OverviewPage> createState() => _OverviewPageState();
}

enum Calendar { month, year, custom }

class _OverviewPageState extends State<OverviewPage> {
  Calendar calendarView = Calendar.month;
  DateTime selectedMonth = DateTime.now();
  int selectedYear = DateTime.now().year;
  PickerDateRange selectedRange = PickerDateRange(
      DateTime.now(), DateTime.now().add(const Duration(days: 30)));
  DateTime startDate = DateTime(DateTime.now().year, DateTime.now().month, 1);
  DateTime endDate = DateTime(DateTime.now().year, DateTime.now().month + 1, 0);

  // Update state when view or selection changes
  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      if (args.value is DateTime) {
        if (calendarView == Calendar.month) {
          selectedMonth = args.value;
        }
        selectedYear = args.value.year;
      } else if (args.value is PickerDateRange) {
        selectedRange = args.value;
      }
      calendarView =
          args.value is PickerDateRange ? Calendar.custom : calendarView;
    });
  }

  Future<void> _fecthStatistic() async {
    Provider.of<StatisticsProvider>(context, listen: false)
        .eitherFailureOrUserStatistics(
            startDate.toString(), endDate.toString());
    Provider.of<StatisticsProvider>(context, listen: false)
        .eitherFailureOrContriStatistics(
            startDate.toString(), endDate.toString());
    Provider.of<StatisticsProvider>(context, listen: false)
        .eitherFailureOrWordStatistics(
            startDate.toString(), endDate.toString());
    Provider.of<StatisticsProvider>(context, listen: false)
        .eitherFailureOrSenStatistics(startDate.toString(), endDate.toString());
    Provider.of<StatisticsProvider>(context, listen: false)
        .eitherFailureOrIrrVerbStatistics(
            startDate.toString(), endDate.toString());
    Provider.of<StatisticsProvider>(context, listen: false)
        .eitherFailureOrVocaSetStatistics(
            startDate.toString(), endDate.toString());
  }

  @override
  void initState() {
    Future.delayed(Duration.zero, () => _fecthStatistic());
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade100,
        scrolledUnderElevation: 0,
        title: Text(
          'Tổng quan',
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
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
          child: Column(
            children: [
              SegmentedButton<Calendar>(
                style: const ButtonStyle(
                    padding: MaterialStatePropertyAll(
                        EdgeInsets.symmetric(horizontal: 8, vertical: 0)),
                    side: MaterialStatePropertyAll(
                        BorderSide(color: Colors.teal))),
                segments: <ButtonSegment<Calendar>>[
                  // ButtonSegment<Calendar>(
                  //     value: Calendar.day,
                  //     label: Text('Day'),
                  //     icon: Icon(Icons.calendar_view_day)),
                  // ButtonSegment<Calendar>(
                  //     value: Calendar.week,
                  //     label: Text('Week'),
                  //     icon: Icon(Icons.calendar_view_week)),
                  ButtonSegment<Calendar>(
                      enabled: !Provider.of<StatisticsProvider>(context,
                              listen: true)
                          .isLoading,
                      value: Calendar.month,
                      label: const Text('Theo tháng'),
                      icon: const Icon(
                        Icons.calendar_view_month,
                        color: Colors.teal,
                      )),
                  ButtonSegment<Calendar>(
                      enabled: !Provider.of<StatisticsProvider>(context,
                              listen: true)
                          .isLoading,
                      value: Calendar.year,
                      label: const Text('Theo năm'),
                      icon: const Icon(
                        Icons.calendar_today,
                        color: Colors.teal,
                      )),
                  ButtonSegment<Calendar>(
                      enabled: !Provider.of<StatisticsProvider>(context,
                              listen: true)
                          .isLoading,
                      value: Calendar.custom,
                      label: const Text('Tùy chỉnh'),
                      icon: const Icon(
                        Icons.tune,
                        color: Colors.teal,
                      )),
                ],
                selected: <Calendar>{calendarView},
                onSelectionChanged: (Set<Calendar> newSelection) {
                  setState(() {
                    calendarView = newSelection.first;

                    // Assign appropriately based on view
                    if (calendarView == Calendar.custom) {
                      startDate =
                          DateTime(selectedYear, selectedMonth.month, 1);
                      endDate =
                          DateTime(selectedYear, selectedMonth.month + 1, 0);
                    } else if (calendarView == Calendar.month) {
                      startDate = selectedMonth;
                      endDate = DateTime(
                          selectedMonth.year, selectedMonth.month + 1, 0);
                    } else {
                      startDate = DateTime(selectedYear, 1, 1);
                      endDate =
                          DateTime(selectedYear, 12, 31); // End of the year
                    }
                  });
                  _fecthStatistic();
                },
              ),
              const SizedBox(
                height: 8,
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Select date button
                      ElevatedButton(
                          style: const ButtonStyle(
                              padding: MaterialStatePropertyAll(
                                  EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 10))),
                          onPressed: Provider.of<StatisticsProvider>(context,
                                      listen: true)
                                  .isLoading
                              ? null
                              : () => _dialogPickerBuilder(context),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                calendarView == Calendar.custom
                                    ? 'Từ ${startDate.day}/${startDate.month}/${startDate.year} đến ${endDate.day}/${endDate.month}/${endDate.year}'
                                    : calendarView == Calendar.month
                                        ? 'Tháng ${startDate.month}/${startDate.year}'
                                        : 'Năm ${startDate.year}',
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              const Icon((Icons.calendar_month))
                            ],
                          )),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  _userStatistics(),
                  const SizedBox(
                    height: 20,
                  ),
                  _contributionStatistics(),
                  const SizedBox(
                    height: 20,
                  ),
                  _wordStatistics(),
                  const SizedBox(
                    height: 20,
                  ),
                  _sentenceStatistics(),
                  const SizedBox(
                    height: 20,
                  ),
                  _irrVerbStatistics(),
                  const SizedBox(
                    height: 20,
                  ),
                  _vocaSetStatistics(),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Consumer<StatisticsProvider> _vocaSetStatistics() {
    return Consumer<StatisticsProvider>(builder: (context, provider, child) {
      VocaSetStatisticsEntity? vocaSetStatisticsEntity =
          provider.vocaSetStatisticsEntity;

      bool isLoading = provider.isLoading;

      // Access the failure from the provider
      Failure? failure = provider.failure;

      if (failure != null) {
        return Text(failure.errorMessage);
      } else if (!isLoading && vocaSetStatisticsEntity == null) {
        return const Center(child: Text('Không có dữ liệu'));
      } else {
        return Skeletonizer(
            enabled: isLoading,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12), color: Colors.white),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.book,
                          size: 30,
                          color: Colors.teal,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text('Gói từ vựng ',
                            style: Theme.of(context).textTheme.bodyLarge!
                            // .copyWith(color: Colors.white),
                            ),
                      ],
                    ),
                    Text(
                      'Tổng cộng: ${vocaSetStatisticsEntity?.total}',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Gói từ công khai: ${vocaSetStatisticsEntity?.totalPublic}',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Gói từ do người dùng tạo: ${vocaSetStatisticsEntity?.totalPrivate}',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Theo chuyên ngành',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    isLoading
                        ? const SizedBox.shrink()
                        : SizedBox(
                            // width: MediaQuery.of(context).size.width - 100,
                            height: vocaSetStatisticsEntity!
                                    .bySpecialization.isEmpty
                                ? 300
                                : vocaSetStatisticsEntity
                                        .bySpecialization.length *
                                    60,
                            child: AspectRatio(
                              aspectRatio: 1.6,
                              child: BarChartWidget(
                                chartData: vocaSetStatisticsEntity.byTopic
                                    .map((e) =>
                                        BarChartData(e.topicName, e.count))
                                    .toList(),
                              ),
                            )),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Theo chủ đề',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    isLoading
                        ? const SizedBox.shrink()
                        : SizedBox(
                            // width: MediaQuery.of(context).size.width - 100,
                            height: vocaSetStatisticsEntity!.byTopic.isEmpty
                                ? 300
                                : vocaSetStatisticsEntity.byTopic.length * 60,
                            child: AspectRatio(
                              aspectRatio: 1.6,
                              child: BarChartWidget(
                                chartData: vocaSetStatisticsEntity.byTopic
                                    .map((e) =>
                                        BarChartData(e.topicName, e.count))
                                    .toList(),
                              ),
                            )),
                  ]),
            ));
      }
    });
  }

  Consumer<StatisticsProvider> _irrVerbStatistics() {
    return Consumer<StatisticsProvider>(builder: (context, provider, child) {
      IrrVerbStatisticsEntity? irrVerbStatisticsEntity =
          provider.irrVerbStatisticsEntity;

      bool isLoading = provider.isLoading;

      // Access the failure from the provider
      Failure? failure = provider.failure;

      if (failure != null) {
        return Text(failure.errorMessage);
      } else if (!isLoading && irrVerbStatisticsEntity == null) {
        return const Center(child: Text('Không có dữ liệu'));
      } else {
        return Skeletonizer(
            enabled: isLoading,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12), color: Colors.white),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.article,
                          size: 30,
                          color: Colors.orange,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text('Động từ bất quy tắc ',
                            style: Theme.of(context).textTheme.bodyLarge!
                            // .copyWith(color: Colors.white),
                            ),
                      ],
                    ),
                    Text(
                      'Tổng cộng: ${irrVerbStatisticsEntity?.total}',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    irrVerbStatisticsEntity?.total != null
                        ? Text(
                            'Hiện có: ${irrVerbStatisticsEntity!.total - irrVerbStatisticsEntity.deleted}',
                            style: Theme.of(context).textTheme.bodySmall,
                          )
                        : const SizedBox(),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Đã xóa: ${irrVerbStatisticsEntity?.deleted}',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ]),
            ));
      }
    });
  }

  Consumer<StatisticsProvider> _sentenceStatistics() {
    return Consumer<StatisticsProvider>(builder: (context, provider, child) {
      SenStatisticsEntity? senStatisticsEntity = provider.senStatisticsEntity;

      bool isLoading = provider.isLoading;

      // Access the failure from the provider
      Failure? failure = provider.failure;

      if (failure != null) {
        return Text(failure.errorMessage);
      } else if (!isLoading && senStatisticsEntity == null) {
        return const Center(child: Text('Không có dữ liệu'));
      } else {
        return Skeletonizer(
            enabled: isLoading,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12), color: Colors.white),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.record_voice_over_outlined,
                          size: 30,
                          color: Colors.blue,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text('Mẫu câu giao tiếp ',
                            style: Theme.of(context).textTheme.bodyLarge!
                            // .copyWith(color: Colors.white),
                            ),
                      ],
                    ),
                    Text(
                      'Tổng cộng: ${senStatisticsEntity?.total}',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Theo loại câu',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    isLoading
                        ? const SizedBox.shrink()
                        : SizedBox(
                            // width: MediaQuery.of(context).size.width - 100,
                            height: senStatisticsEntity!.byType.isEmpty
                                ? 300
                                : senStatisticsEntity.byType.length * 60,
                            child: AspectRatio(
                              aspectRatio: 1.6,
                              child: BarChartWidget(
                                chartData: senStatisticsEntity.byType
                                    .map((e) =>
                                        BarChartData(e.typeName, e.count))
                                    .toList(),
                              ),
                            )),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Theo chủ đề',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    isLoading
                        ? const SizedBox.shrink()
                        : SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: SizedBox(
                                // width: MediaQuery.of(context).size.width - 100,
                                height: senStatisticsEntity!.byTopic.isEmpty
                                    ? 300
                                    : senStatisticsEntity.byTopic.length * 60,
                                child: AspectRatio(
                                  aspectRatio: 1.6,
                                  child: BarChartWidget(
                                    chartData: senStatisticsEntity.byTopic
                                        .map((e) =>
                                            BarChartData(e.topicName, e.count))
                                        .toList(),
                                  ),
                                )),
                          ),
                  ]),
            ));
      }
    });
  }

  Consumer<StatisticsProvider> _wordStatistics() {
    return Consumer<StatisticsProvider>(builder: (context, provider, child) {
      WordStatisticsEntity? wordStatisticsEntity =
          provider.wordStatisticsEntity;

      bool isLoading = provider.isLoading;

      // Access the failure from the provider
      Failure? failure = provider.failure;

      if (failure != null) {
        return Text(failure.errorMessage);
      } else if (!isLoading && wordStatisticsEntity == null) {
        return const Center(child: Text('Không có dữ liệu'));
      } else {
        return Skeletonizer(
            enabled: isLoading,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12), color: Colors.white),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.menu_book,
                          size: 30,
                          color: Colors.yellow.shade700,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text('Từ vựng ',
                            style: Theme.of(context).textTheme.bodyLarge!
                            // .copyWith(color: Colors.white),
                            ),
                      ],
                    ),
                    Text(
                      'Tổng cộng: ${wordStatisticsEntity?.total}',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Theo chuyên ngành',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    isLoading
                        ? const SizedBox.shrink()
                        : SizedBox(
                            // width: MediaQuery.of(context).size.width - 100,
                            height: wordStatisticsEntity!
                                    .bySpecialization.isEmpty
                                ? 300
                                : wordStatisticsEntity.bySpecialization.length *
                                    60,
                            child: AspectRatio(
                              aspectRatio: 1.6,
                              child: BarChartWidget(
                                chartData: wordStatisticsEntity.bySpecialization
                                    .map((e) => BarChartData(
                                        e.specializationName, e.count))
                                    .toList(),
                              ),
                            )),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Theo cấp độ',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    isLoading
                        ? const SizedBox.shrink()
                        : SizedBox(
                            // width: MediaQuery.of(context).size.width - 100,
                            height: wordStatisticsEntity!.byLevel.isEmpty
                                ? 300
                                : wordStatisticsEntity.byLevel.length * 60,
                            child: AspectRatio(
                              aspectRatio: 1.6,
                              child: BarChartWidget(
                                chartData: wordStatisticsEntity.byLevel
                                    .map((e) =>
                                        BarChartData(e.levelName, e.count))
                                    .toList(),
                              ),
                            )),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Theo chủ đề',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    isLoading
                        ? const SizedBox.shrink()
                        : SizedBox(
                            // width: MediaQuery.of(context).size.width - 100,
                            height: wordStatisticsEntity!.byTopic.isEmpty
                                ? 300
                                : wordStatisticsEntity.byTopic.length * 60,
                            child: AspectRatio(
                              aspectRatio: 1.6,
                              child: BarChartWidget(
                                chartData: wordStatisticsEntity.byTopic
                                    .map((e) =>
                                        BarChartData(e.topicName, e.count))
                                    .toList(),
                              ),
                            )),
                  ]),
            ));
      }
    });
  }

  Consumer<StatisticsProvider> _contributionStatistics() {
    return Consumer<StatisticsProvider>(builder: (context, provider, child) {
      ContriStatisticsEntity? contriStatisticsEntity =
          provider.contriStatisticsEntity;

      bool isLoading = provider.isLoading;

      // Access the failure from the provider
      Failure? failure = provider.failure;

      if (failure != null) {
        return Text(failure.errorMessage);
      } else if (!isLoading && contriStatisticsEntity == null) {
        return const Center(child: Text('Không có dữ liệu'));
      } else {
        return Skeletonizer(
          enabled: isLoading,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12), color: Colors.white),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.extension,
                    size: 30,
                    color: Colors.green,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text('Đóng góp ',
                      style: Theme.of(context).textTheme.bodyLarge!
                      // .copyWith(color: Colors.white),
                      ),
                ],
              ),
              Text(
                'Tổng cộng: ${contriStatisticsEntity?.total}',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(
                height: 5,
              ),
              isLoading
                  ? const SizedBox.shrink()
                  : SizedBox(
                      child: AspectRatio(
                      aspectRatio: 1.6,
                      child: ColumnChartWidget(
                        chartData: [
                          ColumnChartData(
                              'Đã duyệt', contriStatisticsEntity!.approved, 1),
                          ColumnChartData(
                              'Đang chờ', contriStatisticsEntity.pending, 0),
                          ColumnChartData(
                              'Đã từ chối', contriStatisticsEntity.refused, -1)
                        ],
                      ),
                    )),
            ]),
          ),
        );
      }
    });
  }

  Consumer<StatisticsProvider> _userStatistics() {
    return Consumer<StatisticsProvider>(builder: (context, provider, child) {
      UserStatisticsEntity? userStatisticsEntity =
          provider.userStatisticsEntity;

      bool isLoading = provider.isLoading;

      // Access the failure from the provider
      Failure? failure = provider.failure;

      if (failure != null) {
        return Text(failure.errorMessage);
      } else if (!isLoading && userStatisticsEntity == null) {
        return const Center(child: Text('Không có dữ liệu'));
      } else {
        return Skeletonizer(
          enabled: isLoading,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12), color: Colors.white),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.group_outlined,
                    size: 30,
                    color: Colors.blue,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text('Người dùng ',
                      style: Theme.of(context).textTheme.bodyLarge!
                      // .copyWith(color: Colors.white),
                      ),
                ],
              ),
              Text(
                'Tổng cộng: ${userStatisticsEntity?.total}',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(
                height: 5,
              ),
              isLoading
                  ? const SizedBox.shrink()
                  : SizedBox(
                      // width: MediaQuery.of(context).size.width - 100,
                      child: AspectRatio(
                      aspectRatio: 1.6,
                      child: ColumnChartWidget(
                        chartData: [
                          ColumnChartData('Đang hoạt động',
                              userStatisticsEntity!.active, 1),
                          ColumnChartData(
                              'Đã khóa', userStatisticsEntity.banned, 0),
                          ColumnChartData(
                              'Đã xóa', userStatisticsEntity.deleted, -1)
                        ],
                      ),
                    )),
            ]),
          ),
        );
      }
    });
  }

  Future<void> _dialogPickerBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          shadowColor: Colors.white,
          title: const Text('Chọn thời gian'),
          content: SizedBox(
            height: MediaQuery.of(context).size.height * 0.5,
            width: MediaQuery.of(context).size.width - 100,
            child: SfDateRangePicker(
              view: getSelectionMode(calendarView),
              selectionMode: calendarView == Calendar.custom
                  ? DateRangePickerSelectionMode.range
                  : DateRangePickerSelectionMode.single,
              monthViewSettings: const DateRangePickerMonthViewSettings(
                  firstDayOfWeek: 1), // Monday as start of week
              initialDisplayDate: selectedMonth,
              initialSelectedDate: calendarView == Calendar.custom
                  ? selectedRange.startDate
                  : null,
              initialSelectedRange:
                  calendarView == Calendar.custom ? selectedRange : null,
              onSelectionChanged: _onSelectionChanged,
              allowViewNavigation:
                  calendarView == Calendar.custom ? true : false,
              // initialSelectedDates: [DateTime.now()],
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey.shade400,
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Trở về'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Đồng ý'),
              onPressed: () {
                setState(() {
                  // Assign appropriately based on view
                  if (calendarView == Calendar.custom) {
                    startDate = DateTime(selectedYear, selectedMonth.month, 1);
                    endDate =
                        DateTime(selectedYear, selectedMonth.month + 1, 0);
                  } else if (calendarView == Calendar.month) {
                    startDate = selectedMonth;
                    endDate = DateTime(
                        selectedMonth.year, selectedMonth.month + 1, 0);
                  } else {
                    startDate = DateTime(selectedYear, 1, 1);
                    endDate = DateTime(selectedYear, 12, 31); // End of the year
                  }
                });
                _fecthStatistic();
                print('Start Date: $startDate');
                print('End Date: $endDate');
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

DateRangePickerView getSelectionMode(Calendar selectedView) {
  switch (selectedView) {
    case Calendar.month:
      return DateRangePickerView.year;
    case Calendar.year:
      return DateRangePickerView.decade;
    case Calendar.custom:
      return DateRangePickerView.month;
    default:
      return DateRangePickerView.month;
  }
}
