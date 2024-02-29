import 'package:ctue_app/core/errors/failure.dart';
import 'package:ctue_app/features/extension/presentation/providers/favorite_provider.dart';
import 'package:ctue_app/features/home/presentation/pages/dictionary_page.dart';
import 'package:ctue_app/features/word/business/entities/word_entity.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoriteVocabulary extends StatefulWidget {
  FavoriteVocabulary({super.key});

  @override
  State<FavoriteVocabulary> createState() => _FavoriteVocabularyState();
}

class _FavoriteVocabularyState extends State<FavoriteVocabulary> {
  final TextEditingController _searchController = TextEditingController();

  final FocusNode _searchFocusNode = FocusNode();

  final List<Word> _words = [
    Word(
        id: 1,
        content: 'musical',
        meaning: 'thuộc về âm nhạc',
        picture:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSOinm7Gtt8zTW0WJoWLMLshRRUKY6Ml6w89g&usqp=CAU'),
    Word(
        id: 2,
        content: 'apple',
        meaning: 'quả táo',
        picture:
            'https://w7.pngwing.com/pngs/67/315/png-transparent-flutter-hd-logo-thumbnail.png'),
    Word(
        id: 3,
        content: 'orange',
        meaning: 'quả cam',
        picture:
            'https://storage.googleapis.com/cms-storage-bucket/780e0e64d323aad2cdd5.png'),
    Word(
        id: 4,
        content: 'orange',
        meaning: 'quả cam',
        picture:
            'https://quickblox.com/wp-content/uploads/2019/12/what-is-flutter.png'),
  ];

  final List<Word> _searchResults = [
    // Word(
    //     id: 1,
    //     content: 'orange',
    //     meaning: 'quả cam',
    //     picture:
    //         'https://quickblox.com/wp-content/uploads/2019/12/what-is-flutter.png'),
    // Word(
    //     id: 2,
    //     content: 'test',
    //     meaning: 'kiem tra',
    //     picture:
    //         'https://quickblox.com/wp-content/uploads/2019/12/what-is-flutter.png'),
    // Word(
    //     id: 3,
    //     content: 'make',
    //     meaning: 'lam',
    //     picture:
    //         'https://quickblox.com/wp-content/uploads/2019/12/what-is-flutter.png'),
  ];

  @override
  void initState() {
    super.initState();
    Provider.of<FavoriteProvider>(context, listen: false)
        .eitherFailureOrGetFavorites(1, 'asc', '');

    _searchFocusNode.addListener(() {
      if (!_searchFocusNode.hasFocus) {
        // setState(() {
        //   isSearching = false;
        // });
      }
    });
  }

  @override
  void dispose() {
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          forceMaterialTransparency: true,
          centerTitle: true,
          title: Text(
            'Từ vựng yêu thích của bạn',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          backgroundColor: Colors.transparent,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.chevron_left_rounded,
              size: 30,
            ),
          )),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Column(
          children: [
            SizedBox(
                height: 45,
                child: SearchBar(
                  controller: _searchController,
                  focusNode: _searchFocusNode,
                  hintText: 'Nhập từ để tra cứu',
                  overlayColor:
                      const MaterialStatePropertyAll(Colors.transparent),
                  hintStyle: const MaterialStatePropertyAll<TextStyle>(
                      TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                          fontWeight: FontWeight.normal)),
                  elevation: const MaterialStatePropertyAll(0),
                  shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                      side: const BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(12))),
                  backgroundColor:
                      const MaterialStatePropertyAll(Colors.transparent),
                  padding: const MaterialStatePropertyAll<EdgeInsets>(
                      EdgeInsets.symmetric(horizontal: 12.0, vertical: 2)),
                  onChanged: (_) {
                    // _searchController.openView();
                    setState(() {
                      // isSearching = true;
                    });
                  },
                  leading: Icon(
                    Icons.search,
                    size: 28,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  trailing: <Widget>[
                    Visibility(
                      visible: _searchController.text.isNotEmpty,
                      child: IconButton(
                        onPressed: () {
                          _searchController.clear();
                          _searchResults
                              .clear(); // Clear the search results list
                          setState(() {}); // Update the UI
                          _searchFocusNode.requestFocus();
                        },
                        icon: const Icon(Icons.close),
                      ),
                    )
                  ],
                )),
            const SizedBox(
              height: 10,
            ),
            if (_searchResults.isEmpty)
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(onPressed: () {}, icon: const Icon(Icons.sort)),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.filter_alt_outlined)),
                ],
              ),
            // const SizedBox(
            //   height: 2,
            // ),
            if (_searchResults.isEmpty)
              Consumer<FavoriteProvider>(
                  builder: (context, favoriteProvider, _) {
                // List<int?> selectedTopics =
                //     Provider.of<TopicProvider>(context, listen: true)
                //         .getSelectedTopics();
                // Access the list of topics from the provider
                // List<SentenceEntity?> words =
                //     wordProvider.filteredSentences(selectedTopics);

                List<WordEntity>? words = favoriteProvider.favoriteList;

                bool isLoading = favoriteProvider.isLoading;

                // Access the failure from the provider
                Failure? failure = favoriteProvider.failure;

                if (failure != null) {
                  // Handle failure, for example, show an error message
                  return Text(failure.errorMessage);
                } else if (isLoading) {
                  // Handle the case where topics are empty
                  return const Center(
                      child:
                          CircularProgressIndicator()); // or show an empty state message
                } else if (words!.isEmpty) {
                  // Handle the case where topics are empty
                  return const Center(
                      child: Text(
                          'Danh sách trống')); // or show an empty state message
                } else {
                  return Expanded(
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        // physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return ListTile(
                            shape: RoundedRectangleBorder(
                                // side: BorderSide(color: Colors.black)
                                borderRadius: BorderRadius.circular(12)),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 0),
                            leading: Container(
                              decoration: const BoxDecoration(
                                  // border: Border.all(),
                                  // borderRadius: BorderRadius.circular(15)
                                  ),
                              height: 40,
                              width: 40,
                              child: words[index].pictures.isNotEmpty
                                  ? Image.network(
                                      words[index].pictures[0],
                                      fit: BoxFit.cover,
                                    )
                                  : Container(),
                            ),
                            title: Text(words[index].content),
                            subtitle: Text(
                              words[index].meanings[0].meaning,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                      color: Colors.grey.shade500,
                                      fontWeight: FontWeight.w600),
                            ),
                            onTap: () {
                              Navigator.pushNamed(context, '/word-detail',
                                  arguments:
                                      WordDetailAgrument(id: words[index].id));
                            },
                          );
                        },
                        // separatorBuilder: (context, index) {
                        //   return const SizedBox(
                        //     height: 1,
                        //   );
                        // },
                        itemCount: words.length),
                  );
                }
              }),
            if (_searchResults.isNotEmpty)
              Expanded(
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    // physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return ListTile(
                        shape: RoundedRectangleBorder(
                            // side: BorderSide(color: Colors.black)
                            borderRadius: BorderRadius.circular(12)),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 0),
                        leading: const Icon(Icons.search),
                        title: Text(_words[index].content),
                        onTap: () {},
                      );
                    },
                    // separatorBuilder: (context, index) {
                    //   return const SizedBox(
                    //     height: 1,
                    //   );
                    // },
                    itemCount: _words.length),
              )
          ],
        ),
      ),
    );
  }
}
