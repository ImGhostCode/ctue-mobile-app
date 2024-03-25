import 'package:ctue_app/core/errors/failure.dart';
import 'package:ctue_app/features/manage/presentation/widgets/action_dialog.dart';
import 'package:ctue_app/features/sentence/business/entities/sentence_entity.dart';
import 'package:ctue_app/features/sentence/presentation/pages/communication_phrase_page.dart';
import 'package:ctue_app/features/sentence/presentation/providers/sentence_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SentenceManagementPage extends StatefulWidget {
  const SentenceManagementPage({super.key});

  @override
  State<SentenceManagementPage> createState() => _SentenceManagementPageState();
}

class _SentenceManagementPageState extends State<SentenceManagementPage> {
  @override
  void initState() {
    Provider.of<SentenceProvider>(context, listen: false)
        .eitherFailureOrSentences([], null, 1, 'asc');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          scrolledUnderElevation: 0,
          title: Text(
            'Quản lý câu',
            style: Theme.of(context).textTheme.titleMedium!.copyWith(),
          ),
          centerTitle: true,
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/add-sentence');
                },
                child: Text(
                  'Thêm câu',
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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(
                height: 45,
                child: SearchBar(
                  hintText: 'Nhập câu để tìm kiếm',
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
            Consumer<SentenceProvider>(builder: (context, sentenceProvider, _) {
              List<SentenceEntity> sentences =
                  sentenceProvider.listSentenceEntity;

              bool isLoading = sentenceProvider.isLoading;

              // Access the failure from the provider
              Failure? failure = sentenceProvider.failure;

              if (failure != null) {
                // Handle failure, for example, show an error message
                return Text(failure.errorMessage);
              } else if (isLoading) {
                // Handle the case where topics are empty
                return const Center(
                    child:
                        CircularProgressIndicator()); // or show an empty state message
              } else if (sentences.isEmpty) {
                // Handle the case where topics are empty
                return const Center(
                    child: Text(
                        'Không có dữ liệu')); // or show an empty state message
              } else {
                return ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return ListTile(
                      onLongPress: () =>
                          showActionDialog(context, false, () {}),
                      minVerticalPadding: 0,
                      leading: Text(
                        '${index + 1}',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      minLeadingWidth: 15,
                      contentPadding: const EdgeInsets.only(
                          left: 0, top: 0, bottom: 0, right: 0),
                      title: Text(sentences[index].content),
                      subtitle: Text(
                        sentences[index].mean,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      onTap: () {
                        Navigator.pushNamed(
                            context, '/communication-phrase-detail',
                            arguments:
                                ComPhraseArguments(id: sentences[index].id));
                      },
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const Divider();
                  },
                  itemCount: sentences.length,
                );
              }
            })
          ],
        ),
      )),
    );
  }
}
