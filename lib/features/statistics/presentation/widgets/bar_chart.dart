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
    // Step 1: Calculate the maximum value
    int maxY = widget.chartData!.isNotEmpty
        ? widget.chartData!
            .map((e) => e.y)
            .reduce((value, element) => value > element ? value : element)
        : 0;
    // Step 2: Calculate the interval
    int interval = (maxY <= 0 ? 5 : (maxY / 10).ceil());

    return SfCartesianChart(
        title: ChartTitle(text: widget.chartTitle ?? ''),
        primaryXAxis: const CategoryAxis(),
        primaryYAxis: NumericAxis(
            minimum: 0,
            maximum: maxY.toDouble() <= 0 ? 10 : (maxY.toDouble() + 10),
            interval: interval.toDouble() <= 0 ? 5 : interval.toDouble()),
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
