import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ColumnChartWidget extends StatefulWidget {
  final List<ColumnChartData>? chartData;
  final String? chartTitle;

  const ColumnChartWidget({super.key, this.chartData, this.chartTitle});

  @override
  State<ColumnChartWidget> createState() => _ColumnChartWidgetState();
}

class _ColumnChartWidgetState extends State<ColumnChartWidget> {
  late TooltipBehavior _tooltip;

  @override
  void initState() {
    _tooltip = TooltipBehavior(
      enable: true,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
        title: ChartTitle(text: widget.chartTitle ?? ''),
        primaryXAxis: const CategoryAxis(),
        primaryYAxis: const NumericAxis(minimum: 0, maximum: 40, interval: 10),
        tooltipBehavior: _tooltip,
        series: <CartesianSeries<ColumnChartData, String>>[
          ColumnSeries<ColumnChartData, String>(
              dataSource: widget.chartData ?? [],
              xValueMapper: (ColumnChartData data, _) => data.x,
              yValueMapper: (ColumnChartData data, _) => data.y,
              name: 'Số lượng',
              enableTooltip: true,
              dataLabelMapper: (ColumnChartData data, _) => data.y.toString(),
              width: 0.5,
              dataLabelSettings: const DataLabelSettings(
                isVisible: true,

                // Positioning the data label
                // useSeriesColor: true,
              ),
              pointColorMapper: (ColumnChartData data, _) =>
                  getStatusColor(data.status),
              color: const Color.fromRGBO(8, 142, 255, 1),
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8), topRight: Radius.circular(8)))
        ]);
  }
}

Color getStatusColor(int status) {
  switch (status) {
    case -1:
      return Colors.red.shade400;
    case 0:
      return Colors.yellow.shade600;
    case 1:
      return Colors.green;

    default:
      return const Color.fromRGBO(8, 142, 255, 1);
  }
}

class ColumnChartData {
  ColumnChartData(this.x, this.y, this.status);

  final String x;
  final int y;
  final int status;
}
