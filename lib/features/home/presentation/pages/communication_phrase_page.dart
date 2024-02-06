import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
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
          SizedBox(
            height: 35,
            // width: MediaQuery.of(context).size.width,
            child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return ActionChip(
                    // avatar: Icon(favorite ? Icons.favorite : Icons.favorite_border),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    shape: RoundedRectangleBorder(
                        side: const BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(20)),
                    label: Text(_topics[index].title),
                    backgroundColor: _topics[index].isSelected
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
                        _topics[index].isSelected = !_topics[index].isSelected;
                      });
                    },
                  );
                  // Text('a');
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    width: 5,
                  );
                },
                itemCount: _topics.length),
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
                  contentPadding: const EdgeInsets.only(
                      left: 0, top: 0, bottom: 0, right: 0),
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
            ),
          )
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
