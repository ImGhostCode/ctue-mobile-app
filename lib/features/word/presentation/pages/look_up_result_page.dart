import 'package:ctue_app/core/errors/failure.dart';
import 'package:ctue_app/features/home/presentation/pages/dictionary_page.dart';
// ignore: unused_import
import 'package:ctue_app/features/sentence/presentation/widgets/listen_sentence_btn.dart';
import 'package:ctue_app/features/word/business/entities/word_entity.dart';
import 'package:ctue_app/features/word/presentation/providers/word_provider.dart';
import 'package:ctue_app/features/word/presentation/widgets/listen_word_btn.dart';
import 'package:ctue_app/features/word/presentation/widgets/look_up_dic_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LookUpResultPage extends StatelessWidget {
  LookUpResultPage({super.key});

  List<WordEntity> lookUpResults = [];

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as ResultLookUpByImgAgr;
    List<String> words = [];

    for (var object in args.listObjects) {
      words.addAll(object.name.split(' '));
    }

    Future.forEach(words, (element) async {
      await Provider.of<WordProvider>(context, listen: false)
          .eitherFailureOrLookUpDic(element);
      lookUpResults.addAll(
          // ignore: use_build_context_synchronously
          Provider.of<WordProvider>(context, listen: false).lookUpResults);
    });

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Kết quả tìm kiếm',
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
      body: Consumer<WordProvider>(builder: (context, wordProvider, child) {
        // WordEntity? wordDetail = wordProvider.wordEntity;

        bool isLoading = wordProvider.isLoading;

        // Access the failure from the provider
        Failure? failure = wordProvider.failure;

        if (failure != null) {
          // Handle failure, for example, show an error message
          return Text(failure.errorMessage);
        } else if (isLoading) {
          // Handle the case where topics are empty
          return const Center(
              child:
                  CircularProgressIndicator()); // or show an empty state message
        } else if (lookUpResults.isEmpty) {
          // Handle the case where topics are empty
          return const Center(child: Text('Không có kết quả nào'));
        } else {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView.separated(
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
                            lookUpResults[index].content,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          Text(
                            '/${lookUpResults[index].phonetic}/',
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      fontWeight: FontWeight.normal,
                                      fontFamily: 'DoulosSIL',
                                    ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ListenWordButton(
                                  text: lookUpResults[index].content),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, '/word-detail',
                                      arguments: WordDetailAgrument(
                                          id: lookUpResults[index].id));
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
                itemCount: lookUpResults.length),
          );
        }
      }),
    );
  }
}
