import 'package:ctue_app/core/errors/failure.dart';
import 'package:ctue_app/features/home/presentation/pages/dictionary_page.dart';
import 'package:ctue_app/features/word/business/entities/word_entity.dart';
import 'package:ctue_app/features/word/presentation/providers/word_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DictionaryManagementPage extends StatefulWidget {
  const DictionaryManagementPage({super.key});

  @override
  State<DictionaryManagementPage> createState() =>
      _DictionaryManagementPageState();
}

class _DictionaryManagementPageState extends State<DictionaryManagementPage> {
  @override
  void initState() {
    Provider.of<WordProvider>(context, listen: false)
        .eitherFailureOrWords([], [], 1, 'asc', '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          scrolledUnderElevation: 0,
          title: Text(
            'Quản lý từ điển',
            style: Theme.of(context).textTheme.titleMedium!.copyWith(),
          ),
          centerTitle: true,
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/add-word');
                },
                child: Text(
                  'Thêm',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(color: Colors.teal),
                )),
            const SizedBox(
              width: 10,
            )
          ],
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.chevron_left_rounded,
              size: 30,
            ),
          )),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
                height: 45,
                child: SearchBar(
                  hintText: 'Nhập từ để tìm kiếm',
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
                  // controller: _searchController,
                  padding: const MaterialStatePropertyAll<EdgeInsets>(
                      EdgeInsets.symmetric(horizontal: 12.0, vertical: 2)),
                  // focusNode: _searchFocusNode,
                  onSubmitted: (String value) {
                    // Handle editing complete (e.g., when user presses Enter)
                    // setState(() {
                    //   isSearching = false;
                    // });
                  },
                  onTap: () {
                    // _searchController.openView();
                  },
                  onChanged: (_) {
                    // _searchController.openView();
                    // setState(() {
                    //   isSearching = true;
                    // });
                  },
                  leading: Icon(
                    Icons.search,
                    size: 28,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  // trailing: <Widget>[],
                )),
            const SizedBox(
              height: 10,
            ),
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
            //   height: 5,
            // ),
            const Divider(),
            Consumer<WordProvider>(builder: (context, wordProvider, _) {
              // List<int?> selectedTopics =
              //     Provider.of<TopicProvider>(context, listen: true)
              //         .getSelectedTopics();
              // Access the list of topics from the provider
              // List<SentenceEntity?> words =
              //     wordProvider.filteredSentences(selectedTopics);
              List<WordEntity>? words = wordProvider.listWordEntity;

              bool isLoading = wordProvider.isLoading;

              // Access the failure from the provider
              Failure? failure = wordProvider.failure;

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
                        'Không có dữ liệu')); // or show an empty state message
              } else {
                return ListView.builder(
                    scrollDirection: Axis.vertical,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
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
                        // trailing: IconButton(
                        //     icon: const Icon(Icons.more_vert),
                        //     onPressed: () => showActionDialog(context)),
                        onLongPress: () => showActionDialog(context),
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
                    itemCount: words.length);
              }
            }),
          ],
        ),
      )),
    );
  }

  Future<String?> showActionDialog(BuildContext context) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        // title: Text(
        //   'AlertDialog Title $index',
        // ),
        buttonPadding: EdgeInsets.zero,
        contentPadding: EdgeInsets.zero,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
        content: SizedBox(
            // height: 65,
            width: MediaQuery.of(context).size.width - 100,
            child: ListView(shrinkWrap: true, children: [
              // provider.userVocaSets[index].userId ==
              //         Provider.of<UserProvider>(context,
              //                 listen: false)
              //             .userEntity!
              //             .id
              //     ?
              TextButton(
                  style: const ButtonStyle(
                      padding: MaterialStatePropertyAll(
                          EdgeInsets.symmetric(horizontal: 16, vertical: 18)),
                      shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero)),
                      backgroundColor: MaterialStatePropertyAll(Colors.white)),
                  onPressed: () async {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/edit-word');
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.edit),
                      SizedBox(
                        width: 5,
                      ),
                      Text(textAlign: TextAlign.left, 'Chỉnh sửa'),
                    ],
                  ))
              // : const SizedBox.shrink()
              ,
              TextButton(
                  style: const ButtonStyle(
                      padding: MaterialStatePropertyAll(
                          EdgeInsets.symmetric(horizontal: 16, vertical: 18)),
                      shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero)),
                      backgroundColor: MaterialStatePropertyAll(Colors.white)),
                  onPressed: () => showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                            backgroundColor: Colors.white,
                            title: const Text(
                              'Cảnh báo',
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold),
                            ),
                            content: const Text(
                                'Bạn có chắc chắn muốn xóa từ này không?'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () => Navigator.pop(context, 'Xóa'),
                                child: const Text('Trở lại'),
                              ),
                              TextButton(
                                onPressed: () async {
                                  // await provider
                                  //     .eitherFailureOrRmVocaSet(
                                  //         provider
                                  //             .userVocaSets[index]
                                  //             .id,
                                  //         provider
                                  //                 .userVocaSets[
                                  //                     index]
                                  //                 .userId !=
                                  //             Provider.of<UserProvider>(
                                  //                     context,
                                  //                     listen: false)
                                  //                 .userEntity!
                                  //                 .id);
                                  // if (provider.statusCode == 200) {
                                  //   provider.userVocaSets
                                  //       .removeAt(index);
                                  // }
                                  // Navigator.pop(context, 'OK');
                                  // Navigator.pop(
                                  //   context,
                                  // );
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          )),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        textAlign: TextAlign.right,
                        'Xóa',
                        style: TextStyle(color: Colors.red),
                      ),
                    ],
                  ))
            ])),
      ),
    );
  }
}
