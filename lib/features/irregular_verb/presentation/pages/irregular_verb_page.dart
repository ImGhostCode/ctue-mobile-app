import 'dart:async';
import 'dart:typed_data';

import 'package:audioplayers/audioplayers.dart';
import 'package:ctue_app/core/services/audio_service.dart';
import 'package:ctue_app/features/irregular_verb/business/entities/irr_verb_entity.dart';
import 'package:ctue_app/features/irregular_verb/presentation/providers/irr_verb_provider.dart';
import 'package:ctue_app/features/speech/business/entities/voice_entity.dart';
import 'package:ctue_app/features/speech/presentation/providers/speech_provider.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';

final audioPlayer = AudioService.player;

class IrregularVerbPage extends StatefulWidget {
  const IrregularVerbPage({Key? key}) : super(key: key);

  @override
  State<IrregularVerbPage> createState() => _IrregularVerbPageState();
}

class _IrregularVerbPageState extends State<IrregularVerbPage> {
  String sort = 'asc';

  Timer? _searchTimer;
  String _searchText = '';

  final PagingController<int, IrrVerbEntity> _pagingController =
      PagingController(firstPageKey: 1);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      await Provider.of<IrrVerbProvider>(context, listen: false)
          .eitherFailureOrIrrVerbs(pageKey, 'asc', _searchText);
      final newItems =
          // ignore: use_build_context_synchronously
          Provider.of<IrrVerbProvider>(context, listen: false)
              .irrVerbResEntity!
              .data;

      // ignore: use_build_context_synchronously
      final isLastPage = Provider.of<IrrVerbProvider>(context, listen: false)
              .irrVerbResEntity!
              .totalPages! <=
          pageKey;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  // @override
  // void initState() {
  //   Provider.of<IrrVerbProvider>(context, listen: false)
  //       .eitherFailureOrIrrVerbs(1, 'asc', null);
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          scrolledUnderElevation: 0,
          title: Text(
            'Động từ bất quy tắc',
            style: Theme.of(context).textTheme.titleMedium!.copyWith(),
          ),
          centerTitle: true,
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
        padding: const EdgeInsets.all(12.0),
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
                    _searchText = _;
                    _searchTimer?.cancel();
                    _searchTimer = Timer(const Duration(milliseconds: 300), () {
                      _pagingController.refresh();
                    });
                  },
                  leading: Icon(
                    Icons.search,
                    size: 28,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                )),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                    onPressed: () {
                      // sort = sort == 'asc' ? 'desc' : 'asc';
                      // Provider.of<IrrVerbProvider>(context, listen: false)
                      //     .eitherFailureOrIrrVerbs(1, sort, null);
                      _pagingController.itemList =
                          _pagingController.itemList!.reversed.toList();
                    },
                    icon: const Icon(Icons.sort)),
                // IconButton(
                //     onPressed: () {},
                //     icon: const Icon(Icons.filter_alt_outlined)),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: PagedListView<int, IrrVerbEntity>(
                pagingController: _pagingController,
                shrinkWrap: true,
                // physics: const NeverScrollableScrollPhysics(),
                builderDelegate: PagedChildBuilderDelegate<IrrVerbEntity>(
                    itemBuilder: (context, item, index) =>
                        Consumer<SpeechProvider>(
                            builder: (context, provider, child) {
                          bool isLoading = provider.isLoading;

                          return ListTile(
                              onTap: () => showIrrVerbDetail(
                                  context, item, false, () {}, () {}),
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 0),
                              horizontalTitleGap: 4,
                              // leading: Container(
                              //     height: 8,
                              //     width: 8,
                              //     decoration: BoxDecoration(
                              //         color: Colors.green.shade500,
                              //         shape: BoxShape.circle)),
                              title: Text(item.v1),
                              subtitle: Text(
                                '${item.v2} / ${item.v3}',
                              ),
                              trailing: IconButton(
                                icon: Icon(
                                  Icons.volume_up_rounded,
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  size: 24,
                                ),
                                onPressed: isLoading
                                    ? null
                                    : () async {
                                        VoiceEntity voice =
                                            await provider.getSelectedVoice();
                                        await provider.eitherFailureOrTts(
                                            "${item.v1.replaceAll('/', '\n')}\n${item.v2.replaceAll('/', '\n')}\n${item.v3.replaceAll('/', '\n')}",
                                            voice,
                                            1.0);
                                        try {
                                          await audioPlayer.play(BytesSource(
                                              Uint8List.fromList(
                                                  provider.audioBytes)));
                                        } catch (e) {
                                          print("Error playing audio: $e");
                                        }
                                      },
                              ));
                        })),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<String?> showIrrVerbDetail(BuildContext context, IrrVerbEntity irrVerb,
    bool isAdmin, VoidCallback editCallback, VoidCallback deleteCallback) {
  return showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      shadowColor: Colors.white,
      // title: Text(
      //   'Chi tiết',
      //   style: Theme.of(context).textTheme.titleMedium,
      // ),
      content: SizedBox(
        width: MediaQuery.of(context).size.width - 100,
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      height: 8,
                      width: 8,
                      decoration: BoxDecoration(
                          color: Colors.green.shade500,
                          shape: BoxShape.circle)),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    irrVerb.v1,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Consumer<SpeechProvider>(
                    builder: (context, provider, child) {
                      bool isLoading = provider.isLoading;

                      return IconButton(
                        icon: Icon(
                          Icons.volume_up_rounded,
                          color: Theme.of(context).colorScheme.secondary,
                          size: 24,
                        ),
                        onPressed: isLoading
                            ? null
                            : () async {
                                VoiceEntity voice =
                                    await provider.getSelectedVoice();
                                await provider.eitherFailureOrTts(
                                    "${irrVerb.v1.replaceAll('/', '\n')}\n${irrVerb.v2.replaceAll('/', '\n')}\n${irrVerb.v3.replaceAll('/', '\n')}",
                                    voice,
                                    1.0);
                                try {
                                  await audioPlayer.play(BytesSource(
                                      Uint8List.fromList(provider.audioBytes)));
                                } catch (e) {
                                  print("Error playing audio: $e");
                                }
                              },
                      );
                    },
                  ),
                ],
              ),
              Text(
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontStyle: FontStyle.italic),
                '${irrVerb.v2} / ${irrVerb.v3}',
              ),
              Text(irrVerb.meaning),
              const SizedBox(
                height: 50,
              ),
            ]),
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: isAdmin
          ? <Widget>[
              ElevatedButton(
                  style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.blue),
                      padding: MaterialStatePropertyAll(
                          EdgeInsets.symmetric(horizontal: 16, vertical: 16))),
                  onPressed: editCallback,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.edit),
                      SizedBox(
                        width: 3,
                      ),
                      Text('Chỉnh sửa'),
                    ],
                  )),
              ElevatedButton(
                  style: ButtonStyle(
                      padding: const MaterialStatePropertyAll(
                          EdgeInsets.symmetric(horizontal: 16, vertical: 16)),
                      backgroundColor:
                          MaterialStatePropertyAll(Colors.red.shade500)),
                  onPressed: () async {
                    Navigator.pop(context);
                    showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                              backgroundColor: Colors.white,
                              surfaceTintColor: Colors.white,
                              shadowColor: Colors.white,
                              title: Text(
                                'Cảnh báo',
                                style: TextStyle(
                                    color: Colors.red.shade400,
                                    fontWeight: FontWeight.bold),
                              ),
                              content: const Text(
                                  'Bạn có chắc chắn muốn xóa động từ này không?'),
                              actionsAlignment: MainAxisAlignment.spaceBetween,
                              actions: <Widget>[
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.grey.shade400,
                                    textStyle:
                                        Theme.of(context).textTheme.labelLarge,
                                  ),
                                  child: const Text('Trở về'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    textStyle:
                                        Theme.of(context).textTheme.labelLarge,
                                  ),
                                  onPressed: Provider.of<IrrVerbProvider>(
                                              context,
                                              listen: true)
                                          .isLoading
                                      ? null
                                      : deleteCallback,
                                  child: const Text('Đồng ý'),
                                ),
                              ],
                            ));
                  },
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.delete,
                        size: 28,
                      ),
                      SizedBox(
                        width: 3,
                      ),
                      Text(
                        'Xóa',
                      ),
                    ],
                  ))
            ]
          : [],
    ),
  );
}
