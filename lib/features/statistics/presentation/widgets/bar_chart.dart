import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class BarChartWidget extends StatefulWidget {
  final List<BarChartData>? chartData;
  final String? chartTitle;

  const BarChartWidget({super.key, this.chartData, this.chartTitle});

  @override
  BarChartWidgetState createState() => BarChartWidgetState();
}

class BarChartWidgetState extends State<BarChartWidget> {
  // late List<BarChartData> data;
  late TooltipBehavior _tooltip;

  @override
  void initState() {
    // data = [
    //   BarChartData('CHN', 12),
    //   BarChartData('GER', 15),
    //   BarChartData('RUS', 30),
    //   BarChartData('BRZ', 6.4),
    //   BarChartData('IND', 14)
    // ];
    _tooltip = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
        title: ChartTitle(text: widget.chartTitle ?? ''),
        primaryXAxis: const CategoryAxis(),
        primaryYAxis: const NumericAxis(minimum: 0, maximum: 40, interval: 10),
        tooltipBehavior: _tooltip,
        series: <CartesianSeries<BarChartData, String>>[
          BarSeries<BarChartData, String>(
              dataSource: widget.chartData ?? [],
              xValueMapper: (BarChartData data, _) => data.x,
              yValueMapper: (BarChartData data, _) => data.y,
              name: 'Số lượng',
              width: 0.5,
              color: const Color.fromRGBO(8, 142, 255, 1))
        ]);
  }
}

class BarChartData {
  BarChartData(this.x, this.y);

  final String x;
  final int y;
}
