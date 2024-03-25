import 'package:flutter/material.dart';

class EditIrregularVerbPage extends StatefulWidget {
  const EditIrregularVerbPage({super.key});

  @override
  State<EditIrregularVerbPage> createState() => _EditIrregularVerbPageState();
}

class _EditIrregularVerbPageState extends State<EditIrregularVerbPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _v1Controller = TextEditingController();
  final TextEditingController _v2Controller = TextEditingController();
  final TextEditingController _v3Controller = TextEditingController();
  final TextEditingController _meaningController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.white,
            scrolledUnderElevation: 0,
            title: Text(
              'Sửa động từ bất quy tắc',
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
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Nguyên mẫu (V1)',
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    controller: _v1Controller,
                    maxLines: 1,
                    style: Theme.of(context).textTheme.bodyMedium,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.grey.shade400),
                      ),
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng điền vào chỗ trống';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Quá khứ đơn (V2)',
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    controller: _v2Controller,
                    maxLines: 1,
                    style: Theme.of(context).textTheme.bodyMedium,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.grey.shade400),
                      ),
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng điền vào chỗ trống';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Quá khứ phân từ (V3)',
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    controller: _v3Controller,
                    maxLines: 1,
                    style: Theme.of(context).textTheme.bodyMedium,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.grey.shade400),
                      ),
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng điền vào chỗ trống';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Nghĩa của từ',
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    controller: _meaningController,
                    maxLines: 1,
                    style: Theme.of(context).textTheme.bodyMedium,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.grey.shade400),
                      ),
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng điền vào chỗ trống';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            // Process data.
                          }
                        },
                        child: const Text('Lưu thay đổi'),
                      ),
                    ],
                  ),
                ],
              ),
            )));
  }
}
