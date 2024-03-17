import 'package:ctue_app/core/constants/memory_level_constants.dart';
import 'package:ctue_app/features/profile/presentation/widgets/gradient_border_container.dart';
import 'package:ctue_app/features/word/business/entities/word_entity.dart';
import 'package:flutter/material.dart';

class WordDetailInVocaSet extends StatefulWidget {
  final bool showLevel;
  final bool showMore;
  final WordEntity? wordEntity;

  const WordDetailInVocaSet(
      {super.key,
      this.showLevel = false,
      this.showMore = false,
      this.wordEntity});

  @override
  State<WordDetailInVocaSet> createState() => _WordDetailInVocaSetState();
}

class _WordDetailInVocaSetState extends State<WordDetailInVocaSet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
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
                      GradientBorderContainer(
                          diameter: level_1.diameter,
                          borderWidth: level_1.borderWidth,
                          borderColor1: level_1.borderColor1,
                          borderColor2: level_1.borderColor2,
                          stop1: level_1.stop1,
                          stop2: level_1.stop2,
                          percent: level_1.percent,
                          fontSize: level_1.fontSize),
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
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.volume_up_rounded,
                          color: Colors.grey.shade600,
                        ))
                  ],
                ),
              ],
            ),

            const SizedBox(
              height: 5,
            ),
            widget.wordEntity!.pictures.isNotEmpty
                ? SizedBox(
                    height: 100,
                    child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Container(
                            height: 100,
                            width: 130,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                widget.wordEntity!.pictures[index],
                                fit: BoxFit.cover,
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
            // const SizedBox(
            //   height: 10,
            // ),
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
              ],
            ),
            const SizedBox(
              height: 5,
            ),
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
            // const SizedBox(
            //   height: 5,
            // ),
            // Row(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: [
            //     Text(
            //       'Ghi chú: ',
            //       style: Theme.of(context)
            //           .textTheme
            //           .bodyMedium!
            //           .copyWith(color: Colors.black87, fontWeight: FontWeight.bold),
            //     ),
            //     Flexible(
            //       child: Text(
            //         'không có',
            //         style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            //             color: Colors.black87, fontWeight: FontWeight.normal),
            //       ),
            //     ),
            //   ],
            // ),
            // const SizedBox(
            //   height: 5,
            // ),
            // Text(
            //   'Chủ đề: ',
            //   style: Theme.of(context)
            //       .textTheme
            //       .bodyMedium!
            //       .copyWith(color: Colors.black87, fontWeight: FontWeight.bold),
            // ),
            // Container(
            //   // height: 200,
            //   // width: MediaQuery.of(context).size.width - 32,
            //   padding: const EdgeInsets.all(8),
            //   child: Wrap(
            //     spacing: 4, // Adjust the spacing between items as needed
            //     runSpacing: 5,
            //     children: List.generate(
            //       _topics.length,
            //       (index) => Chip(
            //         avatar: ClipOval(
            //           child: Image.network(
            //             _topics[index].picture,
            //             fit: BoxFit.cover,
            //             width: 60.0,
            //             height: 60.0,
            //           ),
            //         ),
            //         padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            //         shape: RoundedRectangleBorder(
            //           side: BorderSide(
            //             color: Colors.tealAccent.shade200,
            //           ),
            //           borderRadius: BorderRadius.circular(20),
            //         ),
            //         label: Text(_topics[index].title),
            //         backgroundColor: Colors.white,
            //         labelStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
            //               fontWeight: FontWeight.normal,
            //               color: Theme.of(context).colorScheme.primary,
            //             ),
            //       ),
            //     ),
            //   ),
            // ),
            // const SizedBox(),
          ]),
    );
  }
}
