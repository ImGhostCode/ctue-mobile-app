import 'package:ctue_app/features/speech/presentation/widgets/record_button.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class RadialBarChart extends StatefulWidget {
  final int initialPercent;
  final double fontSize;
  final double diameter;
  final String radius; // Percentage of total chart radius
  final String innerRadius;
  final FontWeight fontWeight;
  final String? title;
  final Color? color;
  final bool showTooltip;
  const RadialBarChart(
      {super.key,
      required this.initialPercent,
      this.radius = '80%',
      this.title,
      this.innerRadius = '80%',
      this.color,
      this.fontWeight = FontWeight.w900,
      this.showTooltip = false,
      required this.diameter,
      required this.fontSize});

  @override
  State<RadialBarChart> createState() => _RadialBarChartState();
}

class _RadialBarChartState extends State<RadialBarChart> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: widget.diameter,
        width: widget.diameter,
        padding: EdgeInsets.zero,
        child: Stack(
          alignment: Alignment.center,
          children: [
            SfCircularChart(
                margin: EdgeInsets.zero,
                tooltipBehavior: TooltipBehavior(enable: widget.showTooltip),
                series: <CircularSeries>[
                  RadialBarSeries<_RadialData, String>(
                      radius: widget.radius, // Percentage of total chart radius
                      innerRadius: widget.innerRadius,
                      maximumValue: 100,
                      cornerStyle: CornerStyle.bothCurve,
                      dataSource: [
                        _RadialData('Used', widget.initialPercent),
                      ],
                      pointColorMapper: (_RadialData data, _) {
                        return widget.color ?? scoreToColor(data.y);
                      },
                      xValueMapper: (_RadialData data, _) => data.x,
                      yValueMapper: (_RadialData data, _) => data.y)
                ]),
            Text(
              '${widget.title ?? widget.initialPercent.toInt()}',
              style: TextStyle(
                  fontSize: widget.fontSize,
                  fontWeight: widget.fontWeight,
                  color: widget.color ?? scoreToColor(widget.initialPercent)),
            ),
          ],
        ));
  }
}

class _RadialData {
  final String x;
  final int y;

  _RadialData(this.x, this.y);
}
