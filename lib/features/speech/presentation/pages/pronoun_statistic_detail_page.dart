import 'package:ctue_app/core/errors/failure.dart';
import 'package:ctue_app/features/profile/presentation/widgets/colored_line.dart';
import 'package:ctue_app/features/speech/business/entities/prounc_statistics_entity.dart';
import 'package:ctue_app/features/speech/presentation/providers/speech_provider.dart';
import 'package:ctue_app/features/speech/presentation/widgets/record_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProStatisticDetailPage extends StatelessWidget {
  const ProStatisticDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<SpeechProvider>(context, listen: false)
        .eitherFailureOrgetUserProStatistics();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Chi tiết phát âm',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.navigate_before,
              size: 32,
            )),
      ),
      body: Consumer<SpeechProvider>(builder: (context, provider, child) {
        List<DetailEntity>? detailEntity =
            provider.pronuncStatisticEntity?.detail;

        detailEntity?.sort((a, b) => b.avg - a.avg);

        bool isLoading = provider.isLoading;

        // Access the failure from the provider
        Failure? failure = provider.failure;

        if (failure != null) {
          // Handle failure, for example, show an error message
          return Text(failure.errorMessage);
        } else if (isLoading) {
          // Handle the case where topics are empty
          return const Center(
              child:
                  CircularProgressIndicator()); // or show an empty state message
        } else if (detailEntity == null) {
          // Handle the case where topics are empty
          return const Center(child: Text('Không có dữ liệu'));
        } else {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
              child: Column(
                children: [
                  // Row(
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Text(
                  //       'Đánh giá',
                  //       style: Theme.of(context).textTheme.titleLarge,
                  //     ),
                  //     GradientBorderContainer(
                  //       diameter: 80.0,
                  //       borderWidth: 0.1, // 10% of diameter
                  //       borderColor1: Colors.lightGreenAccent.shade700,
                  //       borderColor2: Colors.lightGreenAccent.shade100,
                  //       stop1: 0.6,
                  //       stop2: 0.4,
                  //       percent: 60,
                  //       fontSize: 30,
                  //     ),
                  //   ],
                  // ),
                  // const SizedBox(
                  //   height: 30,
                  // ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    // separatorBuilder: (context, index) {
                    //   return const Divider();
                    // },
                    itemBuilder: (context, index) {
                      Color lineColor = scoreToColor(detailEntity[index].avg);
                      return ListTile(
                        leading: Text(
                          textAlign: TextAlign.left,
                          '/${detailEntity[index].label}/',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                  color: lineColor, fontFamily: 'DoulosSIL'),
                        ),
                        title: ColoredLine(
                            // length: 150,
                            height: 9,
                            percentLeft: detailEntity[index].avg / 100,
                            percentRight: 1 - (detailEntity[index].avg / 100),
                            colorLeft: lineColor,
                            colorRight: lineColor.withOpacity(0.2)),
                        subtitle: Text('${detailEntity[index].avg}%',
                            textAlign: TextAlign.right,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(color: lineColor)),
                        minVerticalPadding: 0,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 4, vertical: 0),
                      );
                    },
                    itemCount: detailEntity.length,
                  ),
                ],
              ),
            ),
          );
        }
      }),
    );
  }
}
