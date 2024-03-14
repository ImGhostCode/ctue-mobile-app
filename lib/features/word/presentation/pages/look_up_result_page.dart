import 'package:ctue_app/features/home/presentation/pages/dictionary_page.dart';
// ignore: unused_import
import 'package:ctue_app/features/sentence/presentation/widgets/listen_sentence_btn.dart';
import 'package:ctue_app/features/word/presentation/widgets/listen_word_btn.dart';
import 'package:flutter/material.dart';

class LookUpResultPage extends StatelessWidget {
  const LookUpResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Kết quả tìm kiếm',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.navigate_before,
              size: 32,
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.separated(
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border:
                        Border.all(color: Colors.grey.shade400, width: 1.5)),
                padding: const EdgeInsets.all(16),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Client',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      Text(
                        '/test/',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              fontWeight: FontWeight.normal,
                              fontFamily: 'DoulosSIL',
                            ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ListenWordButton(text: 'client'),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/word-detail',
                                  arguments: WordDetailAgrument(id: 1));
                            },
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.mic_rounded,
                                  color: Colors.white,
                                ),
                                Text('Phát âm')
                              ],
                            ),
                          )
                        ],
                      )
                    ]),
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(
                height: 20,
              );
            },
            itemCount: 10),
      ),
    );
  }
}
