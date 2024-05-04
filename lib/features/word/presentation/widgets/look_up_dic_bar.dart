// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:io';

import 'package:ctue_app/core/constants/constants.dart';
import 'package:ctue_app/features/home/presentation/pages/dictionary_page.dart';
import 'package:ctue_app/features/word/business/entities/object_entity.dart';
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
  // Timer? _searchTimer;

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WordProvider>(builder: (context, wordProvider, child) {
      return SizedBox(
        height: 50,
        child: SearchAnchor(
            searchController: searchController,
            isFullScreen: false,
            viewElevation: 8,
            dividerColor: Theme.of(context).colorScheme.primary,
            viewBackgroundColor: Colors.white,
            viewSurfaceTintColor: Colors.white,
            viewHintText: 'Tra từ điển',
            headerTextStyle: Theme.of(context).textTheme.bodyMedium,
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
                    icon: const Icon(
                      Icons.keyboard_voice,
                      size: 28,
                    ),
                    color: Theme.of(context).colorScheme.primary,
                    onPressed: () {
                      _dialogRecordBuilder(context);
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.image_outlined),
                    color: Theme.of(context).colorScheme.primary,
                    onPressed: () async {
                      await _handleLookUpByImage(context);
                    },
                  ),
                ],
              );
            },
            suggestionsBuilder:
                (BuildContext context, SearchController controller) async {
              if (controller.text.isNotEmpty) {
                // _searchTimer?.cancel();
                // _searchTimer =
                // Timer(const Duration(milliseconds: 300), () async {
                await wordProvider.eitherFailureOrLookUpDic(controller.text);
                // });
              }

              return List<ListTile>.generate(wordProvider.lookUpResults.length,
                  (int index) {
                return ListTile(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                  title: Text(wordProvider.lookUpResults[index].content,
                      style: Theme.of(context).textTheme.bodyMedium),
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

  Future<void> _handleLookUpByImage(BuildContext context) async {
    pickedImage =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);

    if (pickedImage != null) {
      await Provider.of<WordProvider>(context, listen: false)
          .eitherFailureOrLookUpByImage(pickedImage!);

      List<ObjectEntity> lookUpByImageResults =
          Provider.of<WordProvider>(context, listen: false)
              .lookUpByImageResults;

      _dialogLookUpByImgBuilder(context, lookUpByImageResults);
    }
  }

  Future<void> _dialogRecordTryAgainBuilder(BuildContext context) {
    return showDialog<void>(
        context: context,
        barrierDismissible: true,
        barrierColor: Colors.black.withOpacity(0.5),
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
        barrierDismissible: false,
        barrierColor: Colors.black.withOpacity(0.5),
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

  Future<void> _dialogRecordResultBuilder(BuildContext context) {
    return showDialog<void>(
        context: context,
        barrierDismissible: true,
        barrierColor: Colors.black.withOpacity(0.5),
        builder: (BuildContext context) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
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
                          onPressed: () {
                            Navigator.pop(context);

                            Navigator.pushNamed(context, '/word-detail',
                                arguments: WordDetailAgrument(
                                  content: _text.toLowerCase(),
                                ));
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
            _dialogRecordResultBuilder(context);
          }
        }
      }, onError: (val) {
        print('onError: $val');
        // Navigator.pop(context);
        _dialogRecordTryAgainBuilder(context);
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
      // Navigator.pop(context);
    }
  }

  Future<void> _dialogLookUpByImgBuilder(
      BuildContext context1, List<ObjectEntity> lookUpByImageResults) {
    return showDialog(
        context: context1,
        barrierColor: Colors.black.withOpacity(0.5),
        builder: (BuildContext context) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: MediaQuery.of(context).size.height * 0.2),
                lookUpByImageResults.isEmpty
                    ? Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12)),
                            height: MediaQuery.of(context).size.height * 0.3,
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: Image.file(
                              File(pickedImage!.path),
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          Container(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height * 0.2,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12)),
                            child: Text('Không tìm thấy kết quả...',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(color: Colors.grey)),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                                style: const ButtonStyle(
                                    backgroundColor:
                                        MaterialStatePropertyAll(Colors.white)),
                                onPressed: () {
                                  Navigator.pop(context1);
                                  _handleLookUpByImage(context1);
                                },
                                child: Text(
                                  'Thử lại',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                )),
                          ),
                        ],
                      )
                    : Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12)),
                            height: MediaQuery.of(context).size.height * 0.3,
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: Image.file(
                              File(pickedImage!.path),
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Tôi đã tìm thấy...',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(color: Colors.grey)),
                                const SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.2,
                                  child: ListView.separated(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      itemBuilder: (context, index) {
                                        return Material(
                                          child: ListTile(
                                            title: Text(
                                                lookUpByImageResults[index]
                                                    .name,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium),
                                            trailing: TextButton(
                                                onPressed: () {
                                                  Navigator.pushNamed(context,
                                                      RouteNames.wordDetail,
                                                      arguments: WordDetailAgrument(
                                                          content:
                                                              lookUpByImageResults[
                                                                      index]
                                                                  .name));
                                                },
                                                child: Text(
                                                  'Tra cứu',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium!
                                                      .copyWith(
                                                          color: Colors
                                                              .tealAccent
                                                              .shade700),
                                                )),
                                          ),
                                        );
                                      },
                                      separatorBuilder: (context, index) {
                                        return const SizedBox(
                                          height: 5,
                                        );
                                      },
                                      itemCount: lookUpByImageResults.length),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          );
        });
  }
}

class ResultLookUpByImgAgr {
  final List<ObjectEntity> listObjects;

  ResultLookUpByImgAgr({required this.listObjects});
}
