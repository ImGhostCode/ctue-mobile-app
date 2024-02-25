import 'package:ctue_app/core/errors/failure.dart';
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
  final List<Topic> _topics = [
    Topic(title: 'Tất cả', isSelected: true),
    Topic(title: 'Ăn uống', isSelected: false),
    Topic(title: 'Du lịch', isSelected: false),
    Topic(title: 'Du lịch', isSelected: false),
    Topic(title: 'Du lịch', isSelected: false),
    Topic(title: 'Du lịch', isSelected: false),
  ];

  final List<Phrase> _phrases = [
    Phrase(
        id: 1,
        title: 'Why do you want to learn English?',
        meaning: 'Tại sao bạn lại muốn học tiếng Anh?'),
    Phrase(
        id: 2,
        title: 'How long have you been learning English?',
        meaning: 'Bạn đã học tiếng Anh được bao lâu rồi?'),
    Phrase(
        id: 3,
        title: 'How long have you been learning English?',
        meaning: 'Bạn đã học tiếng Anh được bao lâu rồi?'),
  ];

  Future<List<TopicEntity>> fetchTopics() async {
    // Simulate an API call or fetch data from a database
    //   Provider.of<TopicProvider>(context, listen: false)
    //       .eitherFailureOrTopics(null, false);
    //  return Provider.of<TopicProvider>(context, listen: false).listTopicEntity ?? [];

    await Future.delayed(Duration(seconds: 2)); // Simulating a delay

    return [
      // Topic(title: 'Tất cả', isSelected: true),
      // Topic(title: 'Ăn uống', isSelected: false),
      // Topic(title: 'Du lịch', isSelected: false),
      // Add other topics as needed
    ];
  }

  Future<List<Phrase>> fetchPhrases() async {
    // Simulate an API call or fetch data from a database
    await Future.delayed(Duration(seconds: 2)); // Simulating a delay

    return [
      Phrase(
          id: 1,
          title: 'Why do you want to learn English?',
          meaning: 'Tại sao bạn lại muốn học tiếng Anh?'),
      Phrase(
          id: 2,
          title: 'How long have you been learning English?',
          meaning: 'Bạn đã học tiếng Anh được bao lâu rồi?'),
      // Add other phrases as needed
    ];
  }

  @override
  void initState() {
    super.initState();

    // Fetch topics when the widget initializes
    Provider.of<TopicProvider>(context, listen: false)
        .eitherFailureOrTopics(null, false);
  }

  @override
  Widget build(BuildContext context) {
    // List<TopicEntity> listTopics =
    //     Provider.of<TopicProvider>(context).listTopicEntity!;
    // Failure? failure = Provider.of<TopicProvider>(context).failure;
    // late Widget widget;

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
              // Access the list of topics from the provider
              List<TopicEntity>? topics = topicProvider.listTopicEntity;

              // Access the failure from the provider
              Failure? failure = topicProvider.failure;

              if (failure != null) {
                // Handle failure, for example, show an error message
                return Text('$failure');
              } else if (topics == null || topics.isEmpty) {
                // Handle the case where topics are empty
                return CircularProgressIndicator(); // or show an empty state message
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
                                color: _topics[index].isSelected
                                    ? Theme.of(context)
                                        .colorScheme
                                        .primary
                                        .withOpacity(0.8)
                                    : Colors.grey.shade700),
                        onPressed: () {
                          setState(() {
                            topics[index].isSelected =
                                !topics[index].isSelected;
                          });
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
          const SizedBox(
            height: 5,
          ),
          Expanded(
              child: ListView.separated(
            itemBuilder: (context, index) {
              return ListTile(
                minVerticalPadding: 0,
                leading: Text(
                  '${index + 1}',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                minLeadingWidth: 15,
                contentPadding:
                    const EdgeInsets.only(left: 0, top: 0, bottom: 0, right: 0),
                title: Text(_phrases[index].title),
                subtitle: Text(
                  _phrases[index].meaning,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                onTap: () {
                  Navigator.pushNamed(context, '/communication-phrase-detail',
                      arguments: ComPhraseArguments(id: _phrases[index].id));
                },
              );
            },
            separatorBuilder: (context, index) {
              return const Divider();
            },
            itemCount: _phrases.length,
          ))
        ]),
      ),
    );
  }
}

class Topic {
  final String title;
  bool isSelected;

  Topic({required this.title, required this.isSelected});
}

class Phrase {
  final int id;
  final String title;
  final String meaning;

  Phrase({required this.id, required this.title, required this.meaning});
}

class ComPhraseArguments {
  final int id;

  ComPhraseArguments({required this.id});
}
