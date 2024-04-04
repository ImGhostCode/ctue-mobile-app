import 'package:ctue_app/features/sentence/presentation/providers/sentence_provider.dart';
import 'package:ctue_app/features/sentence/presentation/widgets/sentence_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddSentencePage extends StatelessWidget {
  const AddSentencePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.white,
            scrolledUnderElevation: 0,
            title: Text(
              'Thêm mẫu câu giao tiếp',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(),
            ),
            centerTitle: true,
            // actions: [
            //   TextButton(
            //       onPressed: () {},
            //       child: Text(
            //         'Thêm',
            //         style: Theme.of(context)
            //             .textTheme
            //             .bodyLarge!
            //             .copyWith(color: Colors.teal),
            //       )),
            //   const SizedBox(
            //     width: 10,
            //   )
            // ],
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.chevron_left_rounded,
                size: 30,
              ),
            )),
        // body: WordForm(
        //   titleBtnSubmit: "Xác nhận",
        //   callback: (data) {},
        //   isLoading: false,
        // ),
        body: SentenceForm(
          titleBtnSubmit: 'Xác nhận',
          callback: (data) async {
            final sentenceData = data.elementAt(1);

            await Provider.of<SentenceProvider>(context, listen: false)
                .eitherFailureOrCreSentence(
              sentenceData.topicId,
              sentenceData.typeId,
              sentenceData.content,
              sentenceData.meaning,
              sentenceData.note,
            );
            Navigator.of(context).pop();
          },
          isLoading:
              Provider.of<SentenceProvider>(context, listen: true).isLoading,
        ));
  }
}
