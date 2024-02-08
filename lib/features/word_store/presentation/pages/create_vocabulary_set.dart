import 'package:flutter/material.dart';

class CreateVocabularySet extends StatefulWidget {
  CreateVocabularySet({super.key});

  @override
  State<CreateVocabularySet> createState() => _CreateVocabularySetState();
}

class _CreateVocabularySetState extends State<CreateVocabularySet> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _wordController = TextEditingController();
  int numOfLines = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Tạo bộ từ mới',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        // backgroundColor: Colors.transparent,
        backgroundColor: Colors.grey.shade50,
        // title: Text(
        //   args.titleAppBar,
        //   style: Theme.of(context).textTheme.titleMedium!.copyWith(),
        // ),
        // centerTitle: true,
        elevation: 2,
        shadowColor: Colors.grey.shade100,
        surfaceTintColor: Colors.white,
        actions: [
          if (_titleController.text.isNotEmpty)
            TextButton(
              onPressed: () {
                // Validate returns true if the form is valid, or false otherwise.
                if (_formKey.currentState!.validate()) {
                  // If the form is valid, display a snackbar. In the real world,
                  // you'd often call a server or save the information in a database.
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Processing Data')),
                  );
                }
              },
              child: const Text(
                'LƯU',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Tên bô từ',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Colors.black87),
                ),
                const SizedBox(
                  height: 5,
                ),
                TextFormField(
                  controller: _titleController,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Colors.black87, fontWeight: FontWeight.normal),
                  decoration: InputDecoration(
                      hintText: 'Nhập tên bộ từ',
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 4),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(26),
                          borderSide: BorderSide(
                              color: Colors.grey.shade100, width: 2))),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {});
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  'Danh sách từ',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Colors.black87),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  '- Bạn chỉ cần nhập các từ, hệ thống sẽ tự động lấy nghĩa, ví dụ, hình ảnh cho bạn.',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(
                  height: 2,
                ),
                Text(
                  '- Xuống dòng để phân biệt các từ.',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(
                  height: 2,
                ),
                Text(
                  '- Tối đa 100 từ',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  minLines: 6,
                  maxLines: 100,
                  controller: _wordController,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Colors.black87, fontWeight: FontWeight.normal),
                  decoration: InputDecoration(
                      hintText: 'Ví dụ:\nhello\nlove',
                      hintMaxLines: 3,
                      // counter: Text('$numOfLines'),
                      counterText: '$numOfLines',
                      counterStyle: Theme.of(context).textTheme.bodySmall,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                              color: Colors.grey.shade50, width: 2))),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      if (value.isNotEmpty) {
                        RegExp rex = RegExp(r'\w+');
                        numOfLines = rex.allMatches(value).length;
                      } else {
                        numOfLines = 0;
                      }
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
