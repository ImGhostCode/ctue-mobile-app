import 'package:ctue_app/features/home/presentation/pages/dictionary_page.dart';
import 'package:ctue_app/features/word/business/entities/object_entity.dart';
import 'package:ctue_app/features/word/business/entities/word_entity.dart';
import 'package:ctue_app/features/word/presentation/providers/word_provider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class LookUpDicBar extends StatefulWidget {
  const LookUpDicBar({super.key});

  @override
  State<LookUpDicBar> createState() => _LookUpDicBarState();
}

class _LookUpDicBarState extends State<LookUpDicBar> {
  final SearchController searchController = SearchController();

  final ImagePicker picker = ImagePicker();

  XFile? pickedImage;
  stt.SpeechToText? _speech;
  bool _isListening = false;
  String _text = '';

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WordProvider>(builder: (context, wordProvider, child) {
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
                  IconButton(
                    icon: const Icon(Icons.keyboard_voice),
                    color: Theme.of(context).colorScheme.primary,
                    onPressed: () {
                      _dialogRecordBuilder(context);
                    },
                  ),
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

  Future<void> _dialogTryAgainBuilder(BuildContext context) {
    return showDialog<void>(
        context: context,
        barrierColor: Colors.black.withOpacity(0.8),
        builder: (BuildContext context) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: MediaQuery.of(context).size.height * 0.75),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: ElevatedButton(
                    style: const ButtonStyle(
                        shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(12)))),
                        padding: MaterialStatePropertyAll(
                            EdgeInsets.symmetric(vertical: 16, horizontal: 20)),
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.white)),
                    onPressed: () {
                      Navigator.pop(context);

                      _dialogRecordBuilder(context);
                    },
                    child: Text(
                      'Thử lại',
                      style: Theme.of(context).textTheme.bodyMedium,
                    )),
              )
            ],
          );
        });
  }

  Future<void> _dialogRecordBuilder(BuildContext context) {
    _listen();
    return showDialog<void>(
        context: context,
        barrierColor: Colors.black.withOpacity(0.8),
        builder: (BuildContext context) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: MediaQuery.of(context).size.height * 0.75),
              Text(
                'Đang ghi âm...',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Colors.white),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 75,
                width: 75,
                child: FloatingActionButton(
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                  onPressed: _listen,
                  tooltip: 'Listen',
                  heroTag: null,
                  mini: false,
                  child: Icon(
                    _isListening ? Icons.stop : Icons.mic,
                    color: Colors.white,
                    size: 40,
                  ), // Set mini to false to make the button bigger
                ),
              ),
            ],
          );
        });
  }

  Future<void> _dialogResultBuilder(BuildContext context) {
    return showDialog<void>(
        context: context,
        barrierColor: Colors.black.withOpacity(0.8),
        builder: (BuildContext context) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: MediaQuery.of(context).size.height * 0.65),
                // show result in text field
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Tôi đã nghe bạn nói...',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(color: Colors.grey)),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(_text, style: Theme.of(context).textTheme.bodyLarge),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                          style: const ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(Colors.white)),
                          onPressed: () {
                            Navigator.pop(context);

                            _dialogRecordBuilder(context);
                          },
                          child: Text(
                            'Thử lại',
                            style: Theme.of(context).textTheme.bodyMedium,
                          )),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: ElevatedButton(
                          onPressed: () async {
                            // Navigator.pushNamed(context, '/look-up-result',
                            //     arguments: ResultLookUpByImgAgr(
                            //         listObjects: <ObjectEntity>[]));

                            await Provider.of<WordProvider>(context,
                                    listen: false)
                                .eitherFailureOrLookUpDic(_text.toLowerCase());

                            List<WordEntity> list = Provider.of<WordProvider>(
                                    context,
                                    listen: false)
                                .lookUpResults;

                            Navigator.pop(context);

                            if (list.isNotEmpty &&
                                list.any((element) =>
                                    element.content.toLowerCase() ==
                                    _text.toLowerCase())) {
                              Navigator.pushNamed(context, '/word-detail',
                                  arguments: WordDetailAgrument(
                                    id: list
                                        .firstWhere((element) =>
                                            element.content.toLowerCase() ==
                                            _text.toLowerCase())
                                        .id,
                                  ));
                            } else {
                              Navigator.pushNamed(context, '/look-up-result',
                                  arguments: ResultLookUpByImgAgr(
                                    listObjects: <ObjectEntity>[],
                                  ));
                            }
                          },
                          child: Text(
                            'Tra từ điển',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(color: Colors.white),
                          )),
                    ),
                  ],
                )
              ],
            ),
          );
        });
  }

  void _listen() async {
    if (!_isListening) {
      _text = '';
      bool available = await _speech!.initialize(onStatus: (val) {
        print('onStatus: $val');
        if (val == 'done') {
          setState(() => _isListening = false);
          Navigator.pop(context);
          if (_text.isNotEmpty) {
            _dialogResultBuilder(context);
          }
        }
      }, onError: (val) {
        print('onError: $val');
        // Navigator.pop(context);
        _dialogTryAgainBuilder(context);
      });
      if (available) {
        setState(() => _isListening = true);
        _speech!.listen(
          onResult: (val) {
            print(val.recognizedWords);
            _text = val.recognizedWords.split(' ')[0];
          },
        );
      }
    } else {
      setState(() => _isListening = false);
      _speech!.stop();
      Navigator.pop(context);
    }
  }
}

class ResultLookUpByImgAgr {
  final List<ObjectEntity> listObjects;

  ResultLookUpByImgAgr({required this.listObjects});
}
