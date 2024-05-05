import 'package:ctue_app/core/constants/constants.dart';
import 'package:ctue_app/core/errors/failure.dart';
import 'package:ctue_app/features/skeleton/widgets/custom_error_widget.dart';
import 'package:ctue_app/features/vocabulary_pack/business/entities/voca_set_entity.dart';
import 'package:ctue_app/features/vocabulary_pack/presentation/pages/vocabulary_set_store.dart';
import 'package:ctue_app/features/vocabulary_pack/presentation/providers/voca_set_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SearchVocaSetPage extends StatelessWidget {
  SearchVocaSetPage({Key? key}) : super(key: key);

  final SearchController _searchController = SearchController();

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
          backgroundColor: Colors.white,

          title: Text(
            args.titleAppBar,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(),
          ),
          // centerTitle: true,
          elevation: 0,
          shadowColor: Colors.white,
          surfaceTintColor: Colors.white,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.chevron_left_rounded,
              size: 30,
            ),
          ),
        ),
        body: Consumer<VocaSetProvider>(
          builder: (context, provider, child) {
            List<VocaSetEntity> searchResults = provider.searchResults;

            bool isLoading = provider.isLoading;

            Failure? failure = provider.failure;

            if (failure != null) {
              return CustomErrorWidget(
                  title: failure.errorMessage,
                  onTryAgain: () {
                    Provider.of<VocaSetProvider>(context, listen: false)
                        .eitherFailureOrSearchVocaSets(
                            args.title, args.topicId);
                  });
            }
            // else if (isLoading) {
            //   // Handle the case where topics are empty
            //   return const Center(child: CircularProgressIndicator());
            // }
            else if (!isLoading && provider.searchResults.isEmpty) {
              // Handle the case where topics are empty
              return const Scaffold(
                  body: Center(child: Text('Không có dữ liệu')));
            } else {
              return Skeletonizer(
                enabled: isLoading,
                child: Padding(
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
                                        side: const BorderSide(
                                            color: Colors.grey),
                                        borderRadius:
                                            BorderRadius.circular(12))),
                                backgroundColor: const MaterialStatePropertyAll(
                                    Colors.white),
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
                            shrinkWrap: true,
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
                                      horizontal: 8, vertical: 4),
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
                                              errorBuilder: (context, error,
                                                      stackTrace) =>
                                                  Image.asset(
                                                'assets/images/broken-image.png',
                                                color: Colors.grey.shade300,
                                                fit: BoxFit.cover,
                                              ),
                                              fit: BoxFit.cover,
                                              loadingBuilder: (context, child,
                                                  loadingProgress) {
                                                if (loadingProgress == null) {
                                                  return child;
                                                }
                                                return const Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                );
                                              },
                                            ))
                                        : Image.asset(
                                            'assets/images/no-image.jpg',
                                            // color: Colors.grey.shade300,
                                            fit: BoxFit.cover),
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
