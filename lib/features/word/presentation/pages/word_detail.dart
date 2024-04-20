import 'package:ctue_app/core/errors/failure.dart';
import 'package:ctue_app/core/services/audio_service.dart';
import 'package:ctue_app/features/extension/presentation/providers/favorite_provider.dart';
import 'package:ctue_app/features/home/presentation/pages/dictionary_page.dart';
import 'package:ctue_app/features/word/business/entities/word_entity.dart';
import 'package:ctue_app/features/word/presentation/providers/word_provider.dart';
import 'package:ctue_app/features/word/presentation/widgets/listen_word_btn.dart';
import 'package:ctue_app/features/speech/presentation/widgets/record_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

// import 'package:carousel_slider/carousel_slider.dart';

class WordDetail extends StatefulWidget {
  const WordDetail({Key? key}) : super(key: key);

  @override
  State<WordDetail> createState() => _WordDetailState();
}

class _WordDetailState extends State<WordDetail> {
  final audioPlayer = AudioService.player;

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as WordDetailAgrument;
    Provider.of<WordProvider>(context, listen: false)
        .eitherFailureOrWordDetail(args.id);
    Provider.of<FavoriteProvider>(context, listen: false)
        .eitherFailureOrIsFavorite(args.id);

    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.white,
            scrolledUnderElevation: 0,
            title: Text(
              'Chi tiết từ',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(),
            ),
            centerTitle: true,
            surfaceTintColor: Colors.white,
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.chevron_left_rounded,
                size: 30,
              ),
            )),
        body: Consumer<WordProvider>(
          builder: (context, wordProvider, child) {
            WordEntity? wordDetail = wordProvider.wordEntity;

            bool isLoading = wordProvider.isLoading;

            // Access the failure from the provider
            Failure? failure = wordProvider.failure;

            if (!isLoading && failure != null) {
              // Handle failure, for example, show an error message
              return Text(failure.errorMessage);
            } else if (!isLoading && wordDetail == null) {
              // Handle the case where topics are empty
              return const Center(child: Text('Không có dữ liệu'));
            } else {
              return Skeletonizer(
                enabled: isLoading,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(3),
                                            decoration: BoxDecoration(
                                                color: isLoading
                                                    ? Colors.grey.shade200
                                                    : Colors.black87,
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            child: Text(
                                                wordDetail?.levelEntity!.name ??
                                                    '',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall!
                                                    .copyWith(
                                                        color: Colors.white)),
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            wordDetail?.content ?? '',
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleLarge!
                                                .copyWith(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .primary),
                                          ),
                                        ],
                                      ),
                                      Consumer<FavoriteProvider>(
                                        builder: (context, provider, child) {
                                          return IconButton(
                                              onPressed: !provider.isLoading
                                                  ? () async {
                                                      await provider
                                                          .eitherFailureOrToggleFavorite(
                                                              wordDetail?.id ??
                                                                  0);
                                                      provider
                                                          .eitherFailureOrIsFavorite(
                                                              wordDetail?.id ??
                                                                  0);
                                                    }
                                                  : null,
                                              icon: provider.isFavorite
                                                  ? const Icon(
                                                      Icons.favorite,
                                                      color: Colors.red,
                                                    )
                                                  : const Icon(
                                                      Icons
                                                          .favorite_outline_rounded,
                                                    ));
                                        },
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        '/${wordDetail?.phonetic}/',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .copyWith(
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

                                  const SizedBox(
                                    height: 5,
                                  ),
                                  wordDetail?.pictures != null &&
                                          wordDetail!.pictures.isNotEmpty
                                      ? SizedBox(
                                          height: 180,
                                          child: ListView.separated(
                                              scrollDirection: Axis.horizontal,
                                              itemBuilder: (context, index) {
                                                return Container(
                                                    height: 180,
                                                    width: 200,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12),
                                                    ),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12),
                                                      child: Image.network(
                                                        wordDetail
                                                            .pictures[index],
                                                        fit: BoxFit.contain,
                                                        width: double.infinity,
                                                        height: double.infinity,
                                                      ),
                                                    ));
                                              },
                                              separatorBuilder:
                                                  (context, index) {
                                                return const SizedBox(
                                                  width: 5,
                                                );
                                              },
                                              itemCount:
                                                  wordDetail.pictures.length),
                                        )
                                      : Container(),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      text: 'Nghĩa của từ ',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                              color: Colors.black87,
                                              fontWeight: FontWeight.normal),
                                      children: <TextSpan>[
                                        TextSpan(
                                            text: wordDetail?.content,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold)),
                                        // TextSpan(text: ' world!'),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),

                                  ...List.generate(
                                      wordDetail?.meanings.length ?? 0,
                                      (index) => Row(
                                            children: [
                                              Text(
                                                wordDetail?.meanings[index]
                                                        .type!.name ??
                                                    '',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium!
                                                    .copyWith(
                                                        color: Colors.black87,
                                                        fontWeight:
                                                            FontWeight.bold),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                '- ${wordDetail?.meanings[index].meaning}',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium!
                                                    .copyWith(
                                                        color: Colors.black54,
                                                        fontWeight:
                                                            FontWeight.normal),
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
                                        .copyWith(
                                            color: Colors.black87,
                                            fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  ...List.generate(
                                      wordDetail?.examples.length ?? 0,
                                      (index) => Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Icon(
                                                Icons.format_quote,
                                                color: Colors.grey,
                                              ),
                                              const SizedBox(
                                                width: 15,
                                              ),
                                              Flexible(
                                                child: Text(
                                                    wordDetail
                                                            ?.examples[index] ??
                                                        '',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium!
                                                        .copyWith(
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            color: Colors
                                                                .black87)),
                                              )
                                            ],
                                          )),
                                  // const SizedBox(
                                  //   height: 10,
                                  // ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Thuộc chuyên ngành: ',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                                color: Colors.black87,
                                                fontWeight: FontWeight.bold),
                                      ),
                                      Flexible(
                                        child: Text(
                                          wordDetail?.specializationEntity!
                                                  .name ??
                                              '',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(
                                                  color: Colors.black87,
                                                  fontWeight:
                                                      FontWeight.normal),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Từ đồng nghĩa: ',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                                color: Colors.black87,
                                                fontWeight: FontWeight.bold),
                                      ),
                                      Flexible(
                                        child: Text(
                                          wordDetail?.synonyms.join(', ') ?? '',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(
                                                  color: Colors.black87,
                                                  fontWeight:
                                                      FontWeight.normal),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Từ trái nghĩa: ',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                                color: Colors.black87,
                                                fontWeight: FontWeight.bold),
                                      ),
                                      Flexible(
                                        child: Text(
                                          wordDetail?.antonyms.join(', ') ?? '',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(
                                                  color: Colors.black87,
                                                  fontWeight:
                                                      FontWeight.normal),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Ghi chú: ',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                                color: Colors.black87,
                                                fontWeight: FontWeight.bold),
                                      ),
                                      Flexible(
                                        child: Text(
                                          wordDetail?.note ?? '',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(
                                                  color: Colors.black87,
                                                  fontWeight:
                                                      FontWeight.normal),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    'Chủ đề: ',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                            color: Colors.black87,
                                            fontWeight: FontWeight.bold),
                                  ),
                                  Container(
                                    // height: 200,
                                    // width: MediaQuery.of(context).size.width - 32,
                                    padding: const EdgeInsets.all(8),
                                    child: Wrap(
                                      spacing:
                                          4, // Adjust the spacing between items as needed
                                      runSpacing: 5,
                                      children: List.generate(
                                        wordDetail?.topics!.length ?? 0,
                                        (index) => Chip(
                                          avatar: ClipOval(
                                            child: wordDetail?.topics != null &&
                                                    wordDetail!.topics![index]
                                                        .image.isNotEmpty
                                                ? Image.network(
                                                    wordDetail
                                                        .topics![index].image,
                                                    fit: BoxFit.cover,
                                                    width: 60.0,
                                                    height: 60.0,
                                                  )
                                                : Container(),
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8, vertical: 8),
                                          shape: RoundedRectangleBorder(
                                            side: BorderSide(
                                                color: isLoading
                                                    ? Colors.grey.shade100
                                                    : Colors.green,
                                                width: 2),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          label: Text(wordDetail?.topics != null
                                              ? wordDetail!.topics![index].name
                                              : ''),
                                          backgroundColor: Colors.white,
                                          labelStyle: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(
                                                fontWeight: FontWeight.normal,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primary,
                                              ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  // const SizedBox(),

                                  const SizedBox(
                                    height: 250,
                                  )
                                ]),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ListenWordButton(
                              isLoadingPage: isLoading,
                              text: wordDetail?.content ?? ''),
                          RecordButton(
                            isLoadingPage: isLoading,
                            text: wordDetail?.content ?? '',
                          ),
                          const SizedBox(
                            width: 30,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              );
            }
          },
        ));
  }
}

class Topic {
  final String title;
  final String picture;

  Topic({required this.title, required this.picture});
}
