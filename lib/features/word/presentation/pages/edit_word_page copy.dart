import 'package:ctue_app/features/contribute/presentation/widgets/word_form.dart';
import 'package:flutter/material.dart';

class EditWordPage extends StatelessWidget {
  const EditWordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          scrolledUnderElevation: 0,
          title: Text(
            'Chỉnh sửa từ',
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
      body: WordForm(
        titleBtnSubmit: "Lưu thay đổi",
        callback: (data) {},
        isLoading: false,
      ),
    );
  }
}
