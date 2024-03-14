import 'package:ctue_app/core/errors/failure.dart';
import 'package:ctue_app/features/sentence/business/entities/sentence_entity.dart';
import 'package:ctue_app/features/sentence/presentation/providers/sentence_provider.dart';
import 'package:ctue_app/features/topic/business/entities/topic_entity.dart';
import 'package:ctue_app/features/topic/presentation/providers/topic_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ComPhrasePage extends StatefulWidget {
  ComPhrasePage({Key? key}) : super(key: key);

  @override
  State<ComPhrasePage> createState() => _ComPhrasePageState();
}

class _ComPhrasePageState extends State<ComPhrasePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<TopicProvider>(context, listen: false).eitherFailureOrTopics(
        null,
        false,
        TopicEntity(id: 0, name: 'Tất cả', isWord: false, isSelected: true));
    Provider.of<SentenceProvider>(context, listen: false)
        .eitherFailureOrSentences([], null, 1, 'asc');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'Mẫu câu giao tiếp',
          style: Theme.of(context).textTheme.titleMedium!.copyWith(),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
        child: Column(children: [
          const Divider(),
          Consumer<TopicProvider>(
            builder: (context, topicProvider, _) {
              List<TopicEntity>? topics = topicProvider.listTopicEntity;
              bool isLoading = topicProvider.isLoading;
              Failure? failure = topicProvider.failure;

              // print(topicProvider.getSelectedTopics());

              if (failure != null) {
                return Text(failure.errorMessage);
              } else if (topics.isEmpty) {
                return const Center(child: Text('null'));
              } else if (isLoading) {
                return const CircularProgressIndicator(); // or show an empty state message
              } else {
                return SizedBox(
                  height: 35,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return ActionChip(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 8),
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        label: Text(topics[index].name),
                        // You may need to adjust the properties based on your TopicEntity

                        backgroundColor: topics[index].isSelected
                            ? Colors.tealAccent.shade200.withOpacity(0.6)
                            : Colors.grey.shade200,

                        labelStyle: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(
                                color: topics[index].isSelected
                                    ? Theme.of(context)
                                        .colorScheme
                                        .primary
                                        .withOpacity(0.8)
                                    : Colors.grey.shade700),
                        onPressed: () {
                          Provider.of<TopicProvider>(context, listen: false)
                              .handleSelectTopicComPhrase(index);
                        },
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        width: 5,
                      );
                    },
                    itemCount: topics.length,
                  ),
                );
              }
            },
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.sort)),
              IconButton(
                  onPressed: () {}, icon: const Icon(Icons.filter_alt_outlined))
            ],
          ),
          Consumer<SentenceProvider>(builder: (context, sentenceProvider, _) {
            List<int?> selectedTopics =
                Provider.of<TopicProvider>(context, listen: true)
                    .getSelectedTopics();
            // Access the list of topics from the provider
            List<SentenceEntity?> sentences =
                sentenceProvider.filteredSentences(selectedTopics);

            bool isLoading = sentenceProvider.isLoading;

            // Access the failure from the provider
            Failure? failure = sentenceProvider.failure;

            if (failure != null) {
              // Handle failure, for example, show an error message
              return Text(failure.errorMessage);
            } else if (isLoading) {
              // Handle the case where topics are empty
              return const Center(
                  child:
                      CircularProgressIndicator()); // or show an empty state message
            } else if (sentences.isEmpty) {
              // Handle the case where topics are empty
              return const Center(
                  child: Text(
                      'Không có dữ liệu')); // or show an empty state message
            } else {
              return Expanded(
                  child: ListView.separated(
                itemBuilder: (context, index) {
                  return ListTile(
                    minVerticalPadding: 0,
                    leading: Text(
                      '${index + 1}',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    minLeadingWidth: 15,
                    contentPadding: const EdgeInsets.only(
                        left: 0, top: 0, bottom: 0, right: 0),
                    title: Text(sentences[index]!.content),
                    subtitle: Text(
                      sentences[index]!.mean,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    onTap: () {
                      Navigator.pushNamed(
                          context, '/communication-phrase-detail',
                          arguments:
                              ComPhraseArguments(id: sentences[index]!.id));
                    },
                  );
                },
                separatorBuilder: (context, index) {
                  return const Divider();
                },
                itemCount: sentences.length,
              ));
            }
          })
        ]),
      ),
    );
  }
}

class ComPhraseArguments {
  final int id;

  ComPhraseArguments({required this.id});
}