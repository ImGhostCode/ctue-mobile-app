import 'package:ctue_app/features/manage/presentation/pages/sen_management_page.dart';
import 'package:ctue_app/features/sentence/presentation/providers/sentence_provider.dart';
import 'package:ctue_app/features/sentence/presentation/widgets/sentence_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditSentencePage extends StatelessWidget {
  const EditSentencePage({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as EditSentenceArguments;

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          scrolledUnderElevation: 0,
          title: Text(
            'Chỉnh sửa câu',
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
      body: SentenceForm(
        titleBtnSubmit: "Lưu thay đổi",
        initData: args.sentenceEntity,
        callback: (data) async {
          final sentenceData = data.elementAt(1);

          await Provider.of<SentenceProvider>(context, listen: false)
              .eitherFailureOrUpdateSentence(
            args.sentenceEntity.id,
            sentenceData.topicId,
            sentenceData.typeId,
            sentenceData.content,
            sentenceData.meaning,
            sentenceData.note,
          );
          // ignore: use_build_context_synchronously
          Navigator.of(context).pop();
        },
        isLoading:
            Provider.of<SentenceProvider>(context, listen: true).isLoading,
      ),
    );
  }
}
