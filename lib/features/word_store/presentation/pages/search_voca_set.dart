import 'package:ctue_app/core/constants/constants.dart';
import 'package:ctue_app/core/errors/failure.dart';
import 'package:ctue_app/features/word_store/business/entities/voca_set_entity.dart';
import 'package:ctue_app/features/word_store/presentation/pages/vocabulary_sets_page.dart';
import 'package:ctue_app/features/word_store/presentation/providers/voca_set_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchVocaSetPage extends StatelessWidget {
  SearchVocaSetPage({Key? key}) : super(key: key);

  final SearchController _searchController = SearchController();

  final List<VocabularySet> _searchResultss = [
    VocabularySet(
        id: 1,
        title: 'Đêm giao thừa',
        picture:
            'https://i.pinimg.com/736x/d1/a0/2a/d1a02a56406a2f5d4c1c6c9804527098.jpg',
        numOfWord: 30,
        downloads: 3840),
    VocabularySet(
        id: 1,
        title: 'Đêm giao thừa',
        picture:
            'https://i.pinimg.com/736x/d1/a0/2a/d1a02a56406a2f5d4c1c6c9804527098.jpg',
        numOfWord: 30,
        downloads: 3840),
    VocabularySet(
        id: 1,
        title: 'Đêm giao thừa',
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
    VocabularySet(
        id: 4,
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
    VocabularySet(
        id: 4,
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

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as SearchVocaSetArgument;
    if (args.title != null) {
      _searchController.text = args.title!;
      Provider.of<VocaSetProvider>(context, listen: false)
          .eitherFailureOrSearchVocaSets(args.title, null);
    }

    if (args.topicId != null) {
      Provider.of<VocaSetProvider>(context, listen: false)
          .eitherFailureOrSearchVocaSets(null, args.topicId);
    }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey.shade50,
          title: Text(
            args.titleAppBar,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(),
          ),
          // centerTitle: true,
          elevation: 2,
          shadowColor: Colors.grey,
          surfaceTintColor: Colors.white,
        ),
        body: Consumer<VocaSetProvider>(
          builder: (context, provider, child) {
            List<VocaSetEntity> searchResults = provider.searchResults;

            bool isLoading = provider.isLoading;

            Failure? failure = provider.failure;

            if (failure != null) {
              // Handle failure, for example, show an error message
              return Center(child: Text(failure.errorMessage));
            } else if (isLoading) {
              // Handle the case where topics are empty
              return const Center(child: CircularProgressIndicator());
            } else if (provider.searchResults.isEmpty) {
              // Handle the case where topics are empty
              return const Scaffold(
                  body: Center(child: Text('Không có dữ liệu')));
            } else {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Column(
                  children: [
                    args.title != null
                        ? Container(
                            padding: const EdgeInsets.only(bottom: 16),
                            color: Colors.white,
                            child: SearchBar(
                              hintText: 'Tìm kiếm',
                              controller: _searchController,
                              // padding: MaterialStatePropertyAll(
                              //     EdgeInsets.symmetric(vertical: 0, horizontal: 16)),
                              overlayColor: const MaterialStatePropertyAll(
                                  Colors.transparent),
                              hintStyle:
                                  const MaterialStatePropertyAll<TextStyle>(
                                      TextStyle(
                                          color: Colors.grey,
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal)),
                              elevation: const MaterialStatePropertyAll(0),
                              shape: MaterialStatePropertyAll(
                                  RoundedRectangleBorder(
                                      side:
                                          const BorderSide(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(12))),
                              backgroundColor:
                                  const MaterialStatePropertyAll(Colors.white),
                              // onSubmitted: ((value) {
                              //   Navigator.pushNamed(
                              //     context,
                              //     '/search-voca-set',
                              //     arguments: SearchVocaSetArgument(
                              //         titleAppBar: 'Tìm kiếm bộ từ', title: value),
                              //   );
                              // }),
                              leading: Icon(
                                Icons.search,
                                size: 28,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          )
                        : const SizedBox.shrink(),
                    Expanded(
                      child: ListView.separated(
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) {
                            return ListTile(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, '/vocabulary-set-detail',
                                      arguments: VocabularySetArguments(
                                          id: searchResults[index].id));
                                },
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 0),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    side: BorderSide(
                                        color: Colors.grey.shade300)),
                                leading: Container(
                                  height: 75,
                                  width: 75,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    // Add additional styling if needed
                                  ),
                                  child: searchResults[index].picture != null
                                      ? ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          child: Image.network(
                                            searchResults[index].picture!,
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      : Container(),
                                ),
                                title: Text(
                                  searchResults[index].title,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(color: Colors.black87),
                                ),
                                horizontalTitleGap: 8,
                                subtitle: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.list_rounded,
                                          size: 16,
                                          color: Colors.grey,
                                        ),
                                        Text(
                                          '${searchResults[index].words.length}',
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
                                          '${searchResults[index].downloads}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .copyWith(fontSize: 11),
                                        )
                                      ],
                                    ),
                                  ],
                                ));
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox(
                              height: 5,
                            );
                          },
                          itemCount: searchResults.length),
                    )
                  ],
                ),
              );
            }
          },
        ));
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
