import 'package:ctue_app/core/constants/constants.dart';
import 'package:ctue_app/features/word_store/presentation/pages/word_store_page.dart';
import 'package:flutter/material.dart';

class VocabularySets extends StatelessWidget {
  VocabularySets({super.key});

  final TextEditingController _searchController = TextEditingController();

  final List<VocabularySet> _downloadedVocaSets = [
    VocabularySet(
        id: 1,
        title: 'Đêm giao thừa thừa thừa  thừa thừa thừa  thừa thừa thừa',
        picture:
            'https://i.pinimg.com/736x/d1/a0/2a/d1a02a56406a2f5d4c1c6c9804527098.jpg',
        numOfWord: 30,
        downloads: 3840),
  ];

  final List<VocabularySet> _specializationVocaSets = [
    VocabularySet(
        id: 1,
        title: 'Đêm giao thừa thừa thừa  thừa thừa thừa  thừa thừa thừa',
        picture:
            'https://i.pinimg.com/736x/d1/a0/2a/d1a02a56406a2f5d4c1c6c9804527098.jpg',
        numOfWord: 30,
        downloads: 3840),
    VocabularySet(
        id: 2,
        title: 'Đêm giao thừa thừa thừa  thừa thừa thừa  thừa thừa thừa',
        picture:
            'https://i.pinimg.com/736x/d1/a0/2a/d1a02a56406a2f5d4c1c6c9804527098.jpg',
        numOfWord: 30,
        downloads: 3840),
    VocabularySet(
        id: 3,
        title: 'Đêm giao thừa thừa thừa  thừa thừa thừa  thừa thừa thừa',
        picture:
            'https://i.pinimg.com/736x/d1/a0/2a/d1a02a56406a2f5d4c1c6c9804527098.jpg',
        numOfWord: 30,
        downloads: 3840),
    VocabularySet(
        id: 4,
        title: 'Đêm giao thừa thừa thừa  thừa thừa thừa  thừa thừa thừa',
        picture:
            'https://i.pinimg.com/736x/d1/a0/2a/d1a02a56406a2f5d4c1c6c9804527098.jpg',
        numOfWord: 30,
        downloads: 3840),
  ];

  final List<Topic> _topics = [
    Topic(
        id: 1,
        title: 'IELTS',
        picture: 'https://logowik.com/content/uploads/images/flutter5786.jpg'),
    Topic(
        id: 2,
        title: 'TOEIC',
        picture: 'https://logowik.com/content/uploads/images/flutter5786.jpg'),
    Topic(
        id: 3,
        title: 'Oxford',
        picture: 'https://logowik.com/content/uploads/images/flutter5786.jpg'),
    Topic(
        id: 4,
        title: 'Du lịch',
        picture: 'https://logowik.com/content/uploads/images/flutter5786.jpg'),
    Topic(
        id: 5,
        title: 'Du lịch',
        picture: 'https://logowik.com/content/uploads/images/flutter5786.jpg'),
    Topic(
        id: 6,
        title: 'Du lịch',
        picture: 'https://logowik.com/content/uploads/images/flutter5786.jpg'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Các bộ từ vựng',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          SearchBar(
            hintText: 'Tìm kiếm',
            // padding: MaterialStatePropertyAll(
            //     EdgeInsets.symmetric(vertical: 0, horizontal: 16)),
            overlayColor: const MaterialStatePropertyAll(Colors.transparent),
            hintStyle: const MaterialStatePropertyAll<TextStyle>(TextStyle(
                color: Colors.grey,
                fontSize: 14,
                fontWeight: FontWeight.normal)),
            elevation: const MaterialStatePropertyAll(0),
            shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                side: const BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.circular(12))),
            backgroundColor: const MaterialStatePropertyAll(Colors.transparent),
            onSubmitted: ((value) {
              if (value.isNotEmpty) {
                Navigator.pushNamed(
                  context,
                  '/search-voca-set',
                  arguments: SearchVocaSetArgument(
                      titleAppBar: 'Tìm kiếm bộ từ', title: value),
                );
              }
            }),
            leading: Icon(
              Icons.search,
              size: 28,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Bộ từ đã tải',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      height: 185,
                      child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, '/vocabulary-set-detail',
                                    arguments: VocabularySetArguments(
                                        id: _downloadedVocaSets[index].id));
                              },
                              child: Container(
                                // height: 50,
                                padding: EdgeInsets.all(8),
                                width: 130,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                        color: Colors.grey.shade400)),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 100,
                                      width: double.infinity,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: Image.network(
                                          _downloadedVocaSets[index].picture,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Flexible(
                                      // flex: 2,
                                      child: Text(
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        _downloadedVocaSets[index].title,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(color: Colors.black87),
                                      ),
                                    ),
                                    // const Spacer(),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.list_rounded,
                                              size: 16,
                                              color: Colors.grey,
                                            ),
                                            Text(
                                              '${_downloadedVocaSets[index].numOfWord}',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall!
                                                  .copyWith(fontSize: 11),
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.download_rounded,
                                              size: 16,
                                              color: Colors.grey,
                                            ),
                                            Text(
                                              '${_downloadedVocaSets[index].downloads}',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall!
                                                  .copyWith(fontSize: 11),
                                            )
                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox(
                              width: 5,
                            );
                          },
                          itemCount: _downloadedVocaSets.length),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Chuyên ngành',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      height: 185,
                      child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, '/vocabulary-set-detail',
                                    arguments: VocabularySetArguments(
                                        id: _specializationVocaSets[index].id));
                              },
                              child: Container(
                                // height: 50,
                                padding: EdgeInsets.all(8),
                                width: 130,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                        color: Colors.grey.shade400)),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 100,
                                      width: double.infinity,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: Image.network(
                                          _specializationVocaSets[index]
                                              .picture,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Flexible(
                                      // flex: 2,
                                      child: Text(
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        _specializationVocaSets[index].title,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(color: Colors.black87),
                                      ),
                                    ),
                                    // const Spacer(),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.list_rounded,
                                              size: 16,
                                              color: Colors.grey,
                                            ),
                                            Text(
                                              '${_specializationVocaSets[index].numOfWord}',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall,
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.download_rounded,
                                              size: 16,
                                              color: Colors.grey,
                                            ),
                                            Text(
                                              '${_specializationVocaSets[index].downloads}',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall,
                                            )
                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox(
                              width: 5,
                            );
                          },
                          itemCount: _specializationVocaSets.length),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Chuyên ngành',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      height: 185,
                      child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, '/vocabulary-set-detail',
                                    arguments: VocabularySetArguments(
                                        id: _specializationVocaSets[index].id));
                              },
                              child: Container(
                                // height: 50,
                                padding: EdgeInsets.all(8),
                                width: 130,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                        color: Colors.grey.shade400)),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 100,
                                      width: double.infinity,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: Image.network(
                                          _specializationVocaSets[index]
                                              .picture,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Flexible(
                                      // flex: 2,
                                      child: Text(
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        _specializationVocaSets[index].title,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(color: Colors.black87),
                                      ),
                                    ),
                                    // const Spacer(),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.list_rounded,
                                              size: 16,
                                              color: Colors.grey,
                                            ),
                                            Text(
                                              '${_specializationVocaSets[index].numOfWord}',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall,
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.download_rounded,
                                              size: 16,
                                              color: Colors.grey,
                                            ),
                                            Text(
                                              '${_specializationVocaSets[index].downloads}',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall,
                                            )
                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox(
                              width: 5,
                            );
                          },
                          itemCount: _specializationVocaSets.length),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      'Từ vựng theo phân loại',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      // height: 200,
                      // width: MediaQuery.of(context).size.width - 32,
                      padding: const EdgeInsets.all(8),
                      child: Wrap(
                        spacing:
                            6, // Adjust the spacing between items as needed
                        runSpacing: 6,
                        children: List.generate(
                          _topics.length,
                          (index) => ActionChip(
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                '/search-voca-set',
                                arguments: SearchVocaSetArgument(
                                    titleAppBar: _topics[index].title,
                                    topicId: _topics[index].id),
                              );
                            },
                            padding: const EdgeInsets.symmetric(
                                horizontal: 4, vertical: 3),
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color: Colors.tealAccent.shade200,
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            label: Text('#${_topics[index].title}'),
                            backgroundColor: Colors.white,
                            labelStyle: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black87,
                                ),
                          ),
                        ),
                      ),
                    ),
                  ]),
            ),
          )
        ]),
      ),
    );
  }
}

class VocabularySet {
  final int id;
  final String title;
  final String picture;
  final int numOfWord;
  final int downloads;

  VocabularySet(
      {required this.id,
      required this.title,
      required this.picture,
      required this.numOfWord,
      required this.downloads});
}

class Topic {
  final int id;
  final String title;
  final String picture;

  Topic({required this.id, required this.title, required this.picture});
}

class SearchVocaSetArgument {
  final String titleAppBar;
  final String? title;
  final int? topicId;

  SearchVocaSetArgument({required this.titleAppBar, this.title, this.topicId});
}
