import 'package:ctue_app/features/vocabulary_pack/business/entities/voca_statistics_entity.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class StatisticChart extends StatefulWidget {
  final int? totalWords;
  final VocaSetStatisticsEntity dataStatistics;
  const StatisticChart(
      {super.key, this.totalWords, required this.dataStatistics});

  @override
  State<StatisticChart> createState() => _StatisticChartState();
}

class _StatisticChartState extends State<StatisticChart> {
  late List<_ChartData> data;
  // late TooltipBehavior _tooltip;

  @override
  void initState() {
    data = [
      _ChartData(
          '1',
          widget.dataStatistics.detailVocaSetStatisEntity.level_1.length,
          Colors.orange),
      _ChartData(
          '2',
          widget.dataStatistics.detailVocaSetStatisEntity.level_2.length,
          Colors.yellow.shade700),
      _ChartData(
          '3',
          widget.dataStatistics.detailVocaSetStatisEntity.level_3.length,
          Colors.green.shade400),
      _ChartData(
          '4',
          widget.dataStatistics.detailVocaSetStatisEntity.level_4.length,
          Colors.green.shade800),
      _ChartData(
          '5',
          widget.dataStatistics.detailVocaSetStatisEntity.level_5.length,
          Colors.blue.shade500),
      _ChartData(
          'Nhớ sâu',
          widget.dataStatistics.detailVocaSetStatisEntity.level_6.length,
          Colors.blue.shade900)
    ];
    // _tooltip = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 32,
      height: 320,
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 3.0,
            ),
          ],
          borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            'Đã học',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          RichText(
            text: TextSpan(
              text: '${widget.dataStatistics.numberOfWords}',
              style: Theme.of(context).textTheme.titleLarge,
              children: <TextSpan>[
                if (widget.totalWords != null)
                  TextSpan(
                    text: '/',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                if (widget.totalWords != null)
                  TextSpan(
                    text: '${widget.totalWords}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
              ],
            ),
          ),
          Text(
            'Cấp độ nhớ',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/statistic-learned-words',
                    arguments: StatisLearnedWordArgument(
                        dataStatistics: widget.dataStatistics));
              },
              child: SfCartesianChart(
                  primaryXAxis: const CategoryAxis(),
                  primaryYAxis: const NumericAxis(
                    isVisible: false,
                  ),
                  enableAxisAnimation: true,

                  // tooltipBehavior: _tooltip,
                  series: <CartesianSeries<_ChartData, String>>[
                    ColumnSeries<_ChartData, String>(
                        dataSource: data,
                        xValueMapper: (_ChartData data, _) => data.x,
                        yValueMapper: (_ChartData data, _) => data.y,
                        pointColorMapper: (_ChartData data, _) => data.color,
                        name: 'Gold',
                        color: const Color.fromRGBO(8, 142, 255, 1),
                        dataLabelMapper: (_ChartData data, _) =>
                            '${data.y!} từ',
                        width: 0.5,
                        dataLabelSettings: const DataLabelSettings(
                          isVisible: true,

                          // Positioning the data label
                          // useSeriesColor: true,
                        ),
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8)))
                  ]),
            ),
          )
        ]),
      ),
    );
  }
}

class _ChartData {
  _ChartData(this.x, this.y, this.color);
  final String x;
  final int? y;
  final Color? color;
}

class StatisLearnedWordArgument {
  final VocaSetStatisticsEntity dataStatistics;
  StatisLearnedWordArgument({required this.dataStatistics});
}
