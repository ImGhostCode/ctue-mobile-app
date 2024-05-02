import 'package:ctue_app/core/constants/memory_level_constants.dart';
import 'package:ctue_app/features/learn/presentation/pages/learned_result.dart';

import 'package:ctue_app/features/profile/presentation/widgets/radial_bar_chart.dart';
import 'package:ctue_app/features/word/business/entities/word_entity.dart';
import 'package:ctue_app/features/word/presentation/widgets/listen_word_btn.dart';
import 'package:flutter/material.dart';

class WordDetailInVocaSet extends StatefulWidget {
  final bool showLevel;
  final bool showMore;
  final WordEntity? wordEntity;
  final int? memoryLevel;

  const WordDetailInVocaSet(
      {super.key,
      this.showLevel = false,
      this.showMore = false,
      this.memoryLevel,
      this.wordEntity});

  @override
  State<WordDetailInVocaSet> createState() => _WordDetailInVocaSetState();
}

class _WordDetailInVocaSetState extends State<WordDetailInVocaSet> {
  @override
  Widget build(BuildContext context) {
    final MemoryLevel level = getMemoryLevel(widget.memoryLevel ?? 1);
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    if (widget.showLevel)
                      RadialBarChart(
                          fontWeight: FontWeight.normal,
                          radius: '100%',
                          innerRadius: '70%',
                          title: level.title,
                          color: level.color,
                          initialPercent: level.percent,
                          diameter: level.diameter,
                          fontSize: level.fontSize),
                    if (widget.showLevel)
                      const SizedBox(
                        width: 5,
                      ),
                    Text(
                      widget.wordEntity!.content,
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Theme.of(context).colorScheme.primary),
                    ),
                  ],
                ),
                if (widget.showMore)
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.more_vert_rounded))
              ],
            ),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(2.5),
                  decoration: BoxDecoration(
                      color: Colors.black87,
                      borderRadius: BorderRadius.circular(5)),
                  child: Text(widget.wordEntity!.levelEntity!.name,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(color: Colors.white)),
                ),
                const SizedBox(
                  width: 5,
                ),
                Row(
                  children: [
                    Text(
                      '/${widget.wordEntity!.phonetic!}/',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.normal,
                          fontFamily: 'DoulosSIL'),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    ListenWordButton(
                      text: widget.wordEntity!.content,
                      showBackgound: false,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            widget.wordEntity!.pictures.isNotEmpty
                ? SizedBox(
                    height: MediaQuery.of(context).size.width * 0.3,
                    child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Container(
                            height: MediaQuery.of(context).size.width * 0.3,
                            width: MediaQuery.of(context).size.width * 0.4,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                widget.wordEntity!.pictures[index],
                                errorBuilder: (context, error, stackTrace) =>
                                    Image.asset(
                                  'assets/images/broken-image.png',
                                  color: Colors.grey.shade300,
                                  fit: BoxFit.cover,
                                ),
                                fit: BoxFit.contain,
                                width: double.infinity,
                                height: double.infinity,
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            width: 5,
                          );
                        },
                        itemCount: widget.wordEntity!.pictures.length),
                  )
                : const SizedBox.shrink(),
            const SizedBox(
              height: 5,
            ),
            RichText(
              text: TextSpan(
                text: 'Nghĩa của từ ',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Colors.black87, fontWeight: FontWeight.normal),
                children: <TextSpan>[
                  TextSpan(
                      text: widget.wordEntity!.content,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  // TextSpan(text: ' world!'),
                ],
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            ...List.generate(
                widget.wordEntity!.meanings.length,
                (index) => Row(
                      children: [
                        Text(
                          widget.wordEntity!.meanings[index].type!.name,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          '- ${widget.wordEntity!.meanings[index].meaning}',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.normal),
                        ),
                      ],
                    )),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Câu ví dụ:',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: Colors.black87, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 5,
            ),
            ...List.generate(
                widget.wordEntity!.examples.length,
                (index) => Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.format_quote,
                          color: Colors.grey,
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Flexible(
                          child: Text(widget.wordEntity!.examples[index],
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black87)),
                        )
                      ],
                    )),
            const SizedBox(
              height: 5,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Thuộc chuyên ngành: ',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Colors.black87, fontWeight: FontWeight.bold),
                ),
                Flexible(
                  child: Text(
                    widget.wordEntity!.specializationEntity!.name,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Colors.black87, fontWeight: FontWeight.normal),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            if (widget.wordEntity!.synonyms.isNotEmpty)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Từ đồng nghĩa: ',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Colors.black87, fontWeight: FontWeight.bold),
                  ),
                  Flexible(
                    child: Text(
                      widget.wordEntity!.synonyms.join(','),
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Colors.black87, fontWeight: FontWeight.normal),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                ],
              ),
            if (widget.wordEntity!.antonyms.isNotEmpty)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Từ trái nghĩa: ',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Colors.black87, fontWeight: FontWeight.bold),
                  ),
                  Flexible(
                    child: Text(
                      widget.wordEntity!.antonyms.join(','),
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Colors.black87, fontWeight: FontWeight.normal),
                    ),
                  ),
                ],
              ),
          ]),
    );
  }
}
