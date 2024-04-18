import 'package:ctue_app/core/constants/constants.dart';
import 'package:ctue_app/core/errors/failure.dart';
import 'package:ctue_app/features/home/presentation/providers/home_provider.dart';
import 'package:ctue_app/features/profile/presentation/widgets/radial_bar_chart.dart';
import 'package:ctue_app/features/speech/business/entities/prounc_statistics_entity.dart';
import 'package:ctue_app/features/speech/presentation/providers/speech_provider.dart';
import 'package:ctue_app/features/speech/presentation/widgets/record_button.dart';
import 'package:flutter/material.dart';
import 'package:ctue_app/features/profile/presentation/widgets/colored_line.dart';

import 'dart:math';

import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

class PronuncStatisticBox extends StatelessWidget {
  const PronuncStatisticBox({super.key});
  final double size = 50;
  final Color color = Colors.green;

  // final List<PhonemeAssessment> _goodPhonemes = [
  //   PhonemeAssessment(phoneme: 'e', accuracy: 99),
  //   PhonemeAssessment(phoneme: 'i', accuracy: 94),
  //   PhonemeAssessment(phoneme: 'ɔː', accuracy: 90),
  // ];
  // final List<PhonemeAssessment> _needToImprovePhonemes = [
  //   PhonemeAssessment(phoneme: 'p', accuracy: 25),
  //   PhonemeAssessment(phoneme: 'w', accuracy: 43),
  //   PhonemeAssessment(phoneme: 's', accuracy: 50),
  // ];
  @override
  Widget build(BuildContext context) {
    Provider.of<SpeechProvider>(context, listen: false)
        .eitherFailureOrgetUserProStatistics();
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5), // Shadow color
            spreadRadius: 1, // Spread radius
            blurRadius: 5, // Blur radius
            // offset: Offset(1, 1), // Offset
          ),
        ],
      ),
      child: Consumer<SpeechProvider>(builder: (context, provider, child) {
        PronuncStatisticEntity? pronuncStatisticEntity =
            provider.pronuncStatisticEntity;

        bool isLoading = provider.isLoading;

        // Access the failure from the provider
        Failure? failure = provider.failure;

        if (failure != null) {
          // Handle failure, for example, show an error message
          return Text(failure.errorMessage);
        } else if (!isLoading && pronuncStatisticEntity == null) {
          // Handle the case where topics are empty
          return const Center(child: Text('Không có dữ liệu'));
        } else {
          int totalScore = pronuncStatisticEntity?.avg ?? 0;

          return Skeletonizer(
            enabled: isLoading,
            child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: size,
                              height: size,
                              child: Transform.rotate(
                                angle: HexagonClipper().degToRad(90),
                                child: ClipPath(
                                  clipper: HexagonClipper(),
                                  child: Container(
                                      color: isLoading
                                          ? Colors.grey.shade200
                                          : color,
                                      child: Transform.rotate(
                                        angle: HexagonClipper().degToRad(-90),
                                        child: const Icon(
                                          Icons.mic,
                                          size: 20,
                                          color: Colors.white,
                                        ),
                                      )),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Flexible(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Phát âm',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(),
                                  ),
                                  Text(
                                    'so với người bản xứ',
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                          flex: 2,
                          child: RadialBarChart(
                              fontSize: 24,
                              diameter: 90,
                              initialPercent: isLoading ? -1 : totalScore)),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'CÁC ÂM LÀM TỐT',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  pronuncStatisticEntity != null &&
                          pronuncStatisticEntity.lablesDoWell.isNotEmpty
                      ? ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount:
                              pronuncStatisticEntity.lablesDoWell.length > 3
                                  ? 3
                                  : pronuncStatisticEntity.lablesDoWell.length,
                          itemBuilder: (context, index) {
                            Color lineColor = isLoading
                                ? Colors.grey.shade200
                                : scoreToColor(pronuncStatisticEntity
                                    .lablesDoWell[index].avg);
                            return Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    textAlign: TextAlign.left,
                                    '/${pronuncStatisticEntity.lablesDoWell[index].label}/',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                            color: lineColor,
                                            fontFamily: 'DoulosSIL'),
                                  ),
                                ),
                                Expanded(
                                    flex: 8,
                                    child: ColoredLine(
                                        // length: 150,
                                        percentLeft: pronuncStatisticEntity
                                                .lablesDoWell[index].avg /
                                            100,
                                        percentRight: 1 -
                                            (pronuncStatisticEntity
                                                    .lablesDoWell[index].avg /
                                                100),
                                        colorLeft: lineColor,
                                        colorRight:
                                            lineColor.withOpacity(0.2))),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                      '${pronuncStatisticEntity.lablesDoWell[index].avg}%',
                                      textAlign: TextAlign.right,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(color: lineColor)),
                                )
                              ],
                            );
                          },
                        )
                      : const Expanded(
                          child: Center(child: Text('Chưa có dữ liệu'))),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    'CÁC ÂM CẦN CẢI THIỆN',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  pronuncStatisticEntity != null &&
                          pronuncStatisticEntity
                              .lablesNeedToBeImprove.isNotEmpty
                      ? ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: pronuncStatisticEntity
                                      .lablesNeedToBeImprove.length >
                                  3
                              ? 3
                              : pronuncStatisticEntity
                                  .lablesNeedToBeImprove.length,
                          itemBuilder: (context, index) {
                            Color lineColor = isLoading
                                ? Colors.grey.shade200
                                : scoreToColor(pronuncStatisticEntity
                                    .lablesNeedToBeImprove[index].avg);

                            return Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    textAlign: TextAlign.left,
                                    '/${pronuncStatisticEntity.lablesNeedToBeImprove[index].label}/',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                            color: lineColor,
                                            fontFamily: 'DoulosSIL'),
                                  ),
                                ),
                                Expanded(
                                    flex: 8,
                                    child: ColoredLine(
                                        // length: 150,
                                        percentLeft: pronuncStatisticEntity
                                                .lablesNeedToBeImprove[index]
                                                .avg /
                                            100,
                                        percentRight: 1 -
                                            (pronuncStatisticEntity
                                                    .lablesNeedToBeImprove[
                                                        index]
                                                    .avg /
                                                100),
                                        colorLeft: lineColor,
                                        colorRight:
                                            lineColor.withOpacity(0.2))),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                      '${pronuncStatisticEntity.lablesNeedToBeImprove[index].avg}%',
                                      textAlign: TextAlign.right,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(color: lineColor)),
                                )
                              ],
                            );
                          },
                        )
                      : const Expanded(
                          child: Center(child: Text('Chưa có dữ liệu'))),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                          style: const ButtonStyle(
                              padding: MaterialStatePropertyAll(
                                  EdgeInsets.symmetric(
                                      horizontal: 4, vertical: 8))),
                          onPressed: () {
                            Navigator.pushNamed(
                                context, RouteNames.proStatisticsDetail);
                            Provider.of<HomeProvider>(context, listen: false)
                                .saveRecentPage(RouteNames.proStatisticsDetail);
                          },
                          child: Text(
                            'Xem chi tiết',
                            textAlign: TextAlign.right,
                            style: Theme.of(context).textTheme.bodySmall,
                          )),
                      // const Icon(
                      //   Icons.arrow_right_rounded,
                      //   size: 30,
                      // )
                    ],
                  )
                ]),
          );
        }
      }),
    );
  }
}

class HexagonClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    double angle = 60.0; // Angle between two consecutive corners

    final double radius = size.width / 2;

    for (int i = 0; i < 6; i++) {
      double x = radius * cos(degToRad(angle * i));
      double y = radius * sin(degToRad(angle * i));
      if (i == 0) {
        path.moveTo(x + radius, y + radius);
      } else {
        path.lineTo(x + radius, y + radius);
      }
    }

    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }

  double degToRad(double degree) {
    return degree * (pi / 180.0);
  }
}

class PhonemeAssessment {
  final String phoneme;
  final int accuracy;

  PhonemeAssessment({required this.phoneme, required this.accuracy});
}
