import 'package:ctue_app/core/errors/failure.dart';
import 'package:ctue_app/features/profile/presentation/widgets/colored_line.dart';
import 'package:ctue_app/features/skeleton/widgets/custom_error_widget.dart';
import 'package:ctue_app/features/speech/business/entities/prounc_statistics_entity.dart';
import 'package:ctue_app/features/speech/presentation/providers/speech_provider.dart';
import 'package:ctue_app/features/speech/presentation/widgets/record_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

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

        List<DetailEntity>? labelDoWell =
            provider.pronuncStatisticEntity?.lablesDoWell;

        List<DetailEntity>? labelNeedImprove =
            provider.pronuncStatisticEntity?.lablesNeedToBeImprove;

        // detailEntity?.sort((a, b) => b.avg - a.avg);

        bool isLoading = provider.isLoading;

        // Access the failure from the provider
        Failure? failure = provider.failure;

        if (!isLoading && failure != null) {
          // Handle failure, for example, show an error message
          return CustomErrorWidget(
              title: failure.errorMessage,
              onTryAgain: () {
                provider.eitherFailureOrgetUserProStatistics();
              });
        } else if (!isLoading && detailEntity == null) {
          // Handle the case where topics are empty
          return const Center(child: Text('Không có dữ liệu'));
        } else {
          return Skeletonizer(
            enabled: isLoading,
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Các âm làm tốt',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      // separatorBuilder: (context, index) {
                      //   return const Divider();
                      // },
                      itemBuilder: (context, index) {
                        Color lineColor =
                            scoreToColor(labelDoWell?[index].avg ?? -1);
                        return ListTile(
                          leading: Text(
                            textAlign: TextAlign.left,
                            '/${labelDoWell?[index].label}/',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                    color: lineColor, fontFamily: 'DoulosSIL'),
                          ),
                          title: ColoredLine(
                              // length: 150,
                              height: 5,
                              percentLeft: labelDoWell != null
                                  ? (labelDoWell[index].avg / 100)
                                  : 0,
                              percentRight: labelDoWell != null
                                  ? (1 - (labelDoWell[index].avg / 100))
                                  : 0,
                              colorLeft:
                                  isLoading ? Colors.grey.shade200 : lineColor,
                              colorRight: isLoading
                                  ? Colors.grey.shade200
                                  : lineColor.withOpacity(0.2)),
                          subtitle: Text('${labelDoWell?[index].avg}%',
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
                      itemCount: labelDoWell?.length ?? 0,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Các âm cần cải thiện',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      // separatorBuilder: (context, index) {
                      //   return const Divider();
                      // },
                      itemBuilder: (context, index) {
                        Color lineColor =
                            scoreToColor(labelNeedImprove?[index].avg ?? -1);
                        return ListTile(
                          leading: Text(
                            textAlign: TextAlign.left,
                            '/${labelNeedImprove?[index].label}/',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                    color: lineColor, fontFamily: 'DoulosSIL'),
                          ),
                          title: ColoredLine(
                              // length: 150,
                              height: 5,
                              percentLeft: labelNeedImprove != null
                                  ? (labelNeedImprove[index].avg / 100)
                                  : 0,
                              percentRight: labelNeedImprove != null
                                  ? (1 - (labelNeedImprove[index].avg / 100))
                                  : 0,
                              colorLeft:
                                  isLoading ? Colors.grey.shade200 : lineColor,
                              colorRight: isLoading
                                  ? Colors.grey.shade200
                                  : lineColor.withOpacity(0.2)),
                          subtitle: Text('${labelNeedImprove?[index].avg}%',
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
                      itemCount: labelNeedImprove?.length ?? 0,
                    ),
                  ],
                ),
              ),
            ),
          );
        }
        // else {
        //   return const Center(child: Text('Chưa có dữ liệu'));
        // }
      }),
    );
  }
}
