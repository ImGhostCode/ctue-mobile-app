import 'dart:typed_data';

import 'package:audioplayers/audioplayers.dart';
import 'package:ctue_app/core/errors/failure.dart';
import 'package:ctue_app/core/services/audio_service.dart';
import 'package:ctue_app/features/irregular_verb/business/entities/irr_verb_entity.dart';
import 'package:ctue_app/features/irregular_verb/presentation/pages/irregular_verb_page.dart';
import 'package:ctue_app/features/irregular_verb/presentation/providers/irr_verb_provider.dart';
import 'package:ctue_app/features/speech/business/entities/voice_entity.dart';
import 'package:ctue_app/features/speech/presentation/providers/speech_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

final audioPlayer = AudioService.player;

class IrreVerbManagementPage extends StatefulWidget {
  const IrreVerbManagementPage({super.key});

  @override
  State<IrreVerbManagementPage> createState() => _IrreVerbManagementPageState();
}

class _IrreVerbManagementPageState extends State<IrreVerbManagementPage> {
  String sort = 'asc';

  @override
  void initState() {
    Provider.of<IrrVerbProvider>(context, listen: false)
        .eitherFailureOrIrrVerbs(1, 'asc', null);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.white,
            scrolledUnderElevation: 0,
            title: Text(
              maxLines: 2,
              textAlign: TextAlign.center,
              'Quản lý động từ \n bất quy tắc',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(),
            ),
            centerTitle: true,
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/add-irregular-verb');
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
            padding: const EdgeInsets.all(12.0),
            child: Column(children: [
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
                  IconButton(
                      onPressed: () {
                        sort = sort == 'asc' ? 'desc' : 'asc';
                        Provider.of<IrrVerbProvider>(context, listen: false)
                            .eitherFailureOrIrrVerbs(1, sort, null);
                      },
                      icon: const Icon(Icons.sort)),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.filter_alt_outlined)),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Consumer<IrrVerbProvider>(builder: (context, irrVerbProvider, _) {
                // Access the list of topics from the provider
                List<IrrVerbEntity>? irrVerbs = irrVerbProvider.listIrrVerbs;

                bool isLoading = irrVerbProvider.isLoading;

                // Access the failure from the provider
                Failure? failure = irrVerbProvider.failure;

                if (failure != null) {
                  // Handle failure, for example, show an error message
                  return Text(failure.errorMessage);
                } else if (isLoading) {
                  // Handle the case where topics are empty
                  return const Center(
                      child:
                          CircularProgressIndicator()); // or show an empty state message
                } else if (irrVerbs == null || irrVerbs.isEmpty) {
                  // Handle the case where topics are empty
                  return const Center(child: Text('Không có dữ liệu'));
                } else {
                  return ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Consumer<SpeechProvider>(
                            builder: (context, provider, child) {
                          bool isLoading = provider.isLoading;

                          return ListTile(
                              onTap: () => showIrrVerbDetail(
                                  context, irrVerbs[index], true),
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 0),
                              horizontalTitleGap: 4,
                              leading: Container(
                                  height: 8,
                                  width: 8,
                                  decoration: BoxDecoration(
                                      color: Colors.green.shade500,
                                      shape: BoxShape.circle)),
                              title: Text(irrVerbs[index].v1),
                              subtitle: Text(
                                '${irrVerbs[index].v2} / ${irrVerbs[index].v3}',
                              ),
                              trailing: IconButton(
                                  onPressed: () => showIrrVerbDetail(
                                      context, irrVerbs[index], true),
                                  icon: const Icon(Icons.more_vert)));
                        });
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox();
                      },
                      itemCount: irrVerbs.length);
                }
              })
            ]),
          ),
        ));
  }
}
