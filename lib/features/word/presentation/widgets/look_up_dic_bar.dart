import 'package:ctue_app/core/errors/failure.dart';
import 'package:ctue_app/features/home/presentation/pages/dictionary_page.dart';
import 'package:ctue_app/features/word/business/entities/object_entity.dart';
import 'package:ctue_app/features/word/presentation/providers/word_provider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class LookUpDicBar extends StatefulWidget {
  const LookUpDicBar({super.key});

  @override
  State<LookUpDicBar> createState() => _LookUpDicBarState();
}

class _LookUpDicBarState extends State<LookUpDicBar> {
  final SearchController searchController = SearchController();

  final ImagePicker picker = ImagePicker();

  XFile? pickedImage;

  @override
  Widget build(BuildContext context) {
    return Consumer<WordProvider>(builder: (context, wordProvider, child) {
      // bool isLoading = wordProvider.isLoading;
      // // Access the failure from the provider
      // Failure? failure = wordProvider.failure;

      return SizedBox(
        height: 45,
        child: SearchAnchor(
            searchController: searchController,
            isFullScreen: false,
            viewElevation: 8,
            dividerColor: Theme.of(context).colorScheme.primary,
            viewBackgroundColor: Colors.white,
            viewSurfaceTintColor: Colors.white,
            viewHintText: 'Tra từ điển',
            headerHintStyle: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(fontWeight: FontWeight.normal),
            viewShape: const ContinuousRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              side: BorderSide(color: Colors.grey),
            ),
            builder: (BuildContext context, SearchController controller) {
              return SearchBar(
                hintText: 'Nhập từ để tra cứu',
                controller: controller,
                overlayColor:
                    const MaterialStatePropertyAll(Colors.transparent),
                hintStyle: const MaterialStatePropertyAll<TextStyle>(TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                    fontWeight: FontWeight.normal)),
                elevation: const MaterialStatePropertyAll(0),
                shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                    side: const BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(12))),
                backgroundColor:
                    const MaterialStatePropertyAll(Colors.transparent),
                onTap: () {
                  controller.openView();
                },
                onChanged: (value) async {
                  if (!controller.isOpen) {
                    controller.openView();
                  }
                },
                leading: Icon(
                  Icons.search,
                  size: 28,
                  color: Theme.of(context).colorScheme.primary,
                ),
                trailing: <Widget>[
                  // IconButton(
                  //   icon: const Icon(Icons.keyboard_voice),
                  //   color: Theme.of(context).colorScheme.primary,
                  //   onPressed: () {
                  //     print('Use voice command');
                  //   },
                  // ),
                  IconButton(
                    icon: const Icon(Icons.image_outlined),
                    color: Theme.of(context).colorScheme.primary,
                    onPressed: () async {
                      final XFile? newImage =
                          await picker.pickImage(source: ImageSource.gallery);

                      if (newImage != null) {
                        // ignore: use_build_context_synchronously
                        await Provider.of<WordProvider>(context, listen: false)
                            .eitherFailureOrLookUpByImage(newImage);
                        // print(Provider.of<WordProvider>(context, listen: false)
                        //     .lookUpByImageResults);
                        // ignore: use_build_context_synchronously
                        Navigator.pushNamed(context, '/look-up-result',
                            arguments: ResultLookUpByImgAgr(
                                // ignore: use_build_context_synchronously
                                listObjects: Provider.of<WordProvider>(context,
                                        listen: false)
                                    .lookUpByImageResults));
                      }
                    },
                  ),
                ],
              );
            },
            suggestionsBuilder:
                (BuildContext context, SearchController controller) async {
              if (controller.text.isNotEmpty) {
                await wordProvider.eitherFailureOrLookUpDic(controller.text);
              }

              return List<ListTile>.generate(wordProvider.lookUpResults.length,
                  (int index) {
                return ListTile(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                  title: Text(wordProvider.lookUpResults[index].content),
                  onTap: () {
                    // setState(() {
                    //   controller.closeView(item);
                    // });
                    Navigator.pushNamed(context, '/word-detail',
                        arguments: WordDetailAgrument(
                            id: wordProvider.lookUpResults[index].id));
                  },
                  // trailing: IconButton(
                  //   icon: const Icon(Icons.history),
                  //   onPressed: () {},
                  // ),
                );
              });
            }),
      );
    });
  }
}

class ResultLookUpByImgAgr {
  final List<ObjectEntity> listObjects;

  ResultLookUpByImgAgr({required this.listObjects});
}
