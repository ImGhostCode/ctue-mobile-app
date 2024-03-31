import 'package:ctue_app/core/errors/failure.dart';
import 'package:ctue_app/features/home/presentation/pages/dictionary_page.dart';
import 'package:ctue_app/features/speech/business/entities/prounc_statistics_entity.dart';
import 'package:ctue_app/features/speech/presentation/providers/speech_provider.dart';
import 'package:ctue_app/features/word/presentation/widgets/listen_word_btn.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ImprovePronunciationPage extends StatelessWidget {
  const ImprovePronunciationPage({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<SpeechProvider>(context, listen: false)
        .eitherFailureOrgetUserProStatistics();
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            'Cải thiện phát âm',
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
        body: Consumer<SpeechProvider>(
          builder: (context, provider, child) {
            PronuncStatisticEntity? pronuncStatisticEntity =
                provider.pronuncStatisticEntity;

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
            } else if (pronuncStatisticEntity?.suggestWordsToImprove == null) {
              // Handle the case where topics are empty
              return const Center(child: Text('Không có dữ liệu'));
            } else if (pronuncStatisticEntity!.suggestWordsToImprove.isEmpty) {
              return const Center(child: Text('Chưa có dữ liệu'));
            } else {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView.separated(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                                color: Colors.grey.shade400, width: 1.5)),
                        padding: const EdgeInsets.all(16),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                pronuncStatisticEntity
                                    .suggestWordsToImprove[index].content,
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              Text(
                                '/${pronuncStatisticEntity.suggestWordsToImprove[index].phonetic}/',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                      fontWeight: FontWeight.normal,
                                      fontFamily: 'DoulosSIL',
                                    ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ListenWordButton(
                                      text: pronuncStatisticEntity
                                          .suggestWordsToImprove[index]
                                          .content),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.pushNamed(
                                          context, '/word-detail',
                                          arguments: WordDetailAgrument(
                                              id: pronuncStatisticEntity
                                                  .suggestWordsToImprove[index]
                                                  .id));
                                    },
                                    child: const Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.mic_rounded,
                                          color: Colors.white,
                                        ),
                                        Text('Phát âm')
                                      ],
                                    ),
                                  )
                                ],
                              )
                            ]),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: 20,
                      );
                    },
                    itemCount:
                        pronuncStatisticEntity.suggestWordsToImprove.length),
              );
            }
          },
        ));
  }
}
