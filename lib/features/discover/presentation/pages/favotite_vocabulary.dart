import 'package:ctue_app/features/home/presentation/pages/dictionary_page.dart';
import 'package:flutter/material.dart';

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
                          fontWeight: FontWeight.w600)),
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
                ],
              ),
            // const SizedBox(
            //   height: 2,
            // ),
            if (_searchResults.isEmpty)
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
                        leading: Container(
                          decoration: const BoxDecoration(
                              // border: Border.all(),
                              // borderRadius: BorderRadius.circular(15)
                              ),
                          height: 40,
                          width: 40,
                          child: Image.network(
                            _words[index].picture,
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: Text(_words[index].content),
                        subtitle: Text(
                          _words[index].meaning,
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
                                  WordDetailAgrument(id: _words[index].id));
                        },
                      );
                    },
                    // separatorBuilder: (context, index) {
                    //   return const SizedBox(
                    //     height: 1,
                    //   );
                    // },
                    itemCount: _words.length),
              ),
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
