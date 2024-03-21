import 'package:ctue_app/features/word/business/entities/word_entity.dart';
import 'package:ctue_app/features/word/presentation/providers/word_provider.dart';
import 'package:ctue_app/features/vocabulary_set/presentation/providers/voca_set_provider.dart';
import 'package:flutter/material.dart';
import 'package:multiple_search_selection/multiple_search_selection.dart';
import 'package:provider/provider.dart';

class CreateVocabularySet extends StatefulWidget {
  CreateVocabularySet({super.key});

  @override
  State<CreateVocabularySet> createState() => _CreateVocabularySetState();
}

class _CreateVocabularySetState extends State<CreateVocabularySet> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();
  MultipleSearchController controller = MultipleSearchController();
  int numOfLines = 0;
  List<WordEntity> selectedWords = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Tạo bộ từ mới',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.chevron_left_rounded,
            size: 30,
          ),
        ),
        actions: [
          if (_titleController.text.isNotEmpty && selectedWords.isNotEmpty)
            TextButton(
              onPressed: () async {
                // Validate returns true if the form is valid, or false otherwise.
                if (_formKey.currentState!.validate()) {
                  // ScaffoldMessenger.of(context).showSnackBar(
                  //   const SnackBar(content: Text('Processing Data')),
                  // );
                  List<int> wordIds = selectedWords.map((e) => e.id).toList();

                  await Provider.of<VocaSetProvider>(context, listen: false)
                      .eitherFailureOrCreVocaSet(
                          _titleController.text, null, null, null, wordIds);

                  if (Provider.of<VocaSetProvider>(context, listen: false)
                          .vocaSetEntity !=
                      null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        duration: const Duration(seconds: 1),
                        content: Text(
                          Provider.of<VocaSetProvider>(context, listen: false)
                              .message!,
                          style: const TextStyle(color: Colors.white),
                        ),
                        backgroundColor:
                            Colors.green, // You can customize the color
                      ),
                    );
                  } else if (Provider.of<VocaSetProvider>(context,
                              listen: false)
                          .failure !=
                      null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        duration: const Duration(seconds: 1),
                        content: Text(
                          Provider.of<VocaSetProvider>(context, listen: false)
                              .message!,
                          style: const TextStyle(color: Colors.white),
                        ),
                        backgroundColor:
                            Colors.red, // You can customize the color
                      ),
                    );
                  }
                }
                Navigator.of(context).pop();
              },
              child: Provider.of<VocaSetProvider>(context, listen: true)
                      .isLoading
                  ? const SizedBox(
                      height: 30,
                      width: 30,
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.white,
                      ),
                    )
                  : const Text(
                      'LƯU',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
            ),
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Tên bô từ',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Colors.black87),
                ),
                const SizedBox(
                  height: 5,
                ),
                TextFormField(
                  controller: _titleController,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Colors.black87, fontWeight: FontWeight.normal),
                  decoration: InputDecoration(
                      hintText: 'Nhập tên bộ từ',
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 4),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(26),
                          borderSide: BorderSide(
                              color: Colors.grey.shade100, width: 2))),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {});
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  'Danh sách từ',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Colors.black87),
                ),
                const SizedBox(
                  height: 5,
                ),
                selectedWords.isNotEmpty
                    ? Container(
                        margin: const EdgeInsets.only(bottom: 15),
                        width: double.infinity,
                        decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(12)),
                        padding: const EdgeInsets.all(8),
                        child: Wrap(children: [
                          ...List.generate(selectedWords.length, (index) {
                            return Container(
                              margin:
                                  const EdgeInsets.only(right: 5, bottom: 5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.lightBlueAccent.shade100
                                    .withOpacity(0.6),
                                border:
                                    Border.all(color: Colors.lightBlueAccent),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 8,
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      selectedWords[index].content,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                              color: Colors.blue.shade800),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        Icons.close,
                                        size: 18,
                                        color: Colors.blue.shade800,
                                      ),
                                      padding: EdgeInsets.zero,
                                      onPressed: () {
                                        setState(() {
                                          selectedWords.removeAt(index);
                                        });
                                      },
                                    )
                                  ],
                                ),
                              ),
                            );
                          })
                        ]),
                      )
                    : const SizedBox.shrink(),
                TextField(
                  controller: _searchController,
                  style: Theme.of(context).textTheme.bodyMedium,
                  decoration: InputDecoration(
                    hintText: 'Nhập từ để tìm kiếm',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  onChanged: (value) async {
                    await Provider.of<WordProvider>(context, listen: false)
                        .eitherFailureOrLookUpDic(value);
                  },
                ),
                const SizedBox(
                  height: 5,
                ),
                Consumer<WordProvider>(builder: (context, provider, child) {
                  Iterable<WordEntity> filterdResults = provider.lookUpResults
                      .where((word) =>
                          !selectedWords.map((e) => e.id).contains(word.id));

                  if (filterdResults.isEmpty ||
                      _searchController.text.isEmpty) {
                    return const SizedBox.shrink();
                  }
                  return Container(
                    // height: 300,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                            color: Theme.of(context).colorScheme.primary),
                        borderRadius: BorderRadius.circular(6)),
                    child: ListView.separated(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return ListTile(
                            // horizontalTitleGap: 0,
                            titleAlignment: ListTileTitleAlignment.center,
                            // minVerticalPadding: 0,
                            // contentPadding: const EdgeInsets.symmetric(
                            //     horizontal: 8, vertical: 0),
                            title: Text(
                              filterdResults.elementAt(index).content,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.w600),
                            ),
                            onTap: () {
                              setState(() {
                                selectedWords
                                    .add(filterdResults.elementAt(index));
                              });
                            },
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const Divider();
                        },
                        itemCount: filterdResults.length),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
