import 'package:flutter/material.dart';

Future<String?> showActionDialog(BuildContext context, bool isWord,
    VoidCallback deleteCallback, VoidCallback editCallback) {
  return showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      // title: Text(
      //   'AlertDialog Title $index',
      // ),
      buttonPadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
      content: SizedBox(
          // height: 65,
          width: MediaQuery.of(context).size.width - 100,
          child: ListView(shrinkWrap: true, children: [
            TextButton(
                style: const ButtonStyle(
                    padding: MaterialStatePropertyAll(
                        EdgeInsets.symmetric(horizontal: 16, vertical: 18)),
                    shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero)),
                    backgroundColor: MaterialStatePropertyAll(Colors.white)),
                onPressed: editCallback,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.edit),
                    SizedBox(
                      width: 5,
                    ),
                    Text(textAlign: TextAlign.left, 'Chỉnh sửa'),
                  ],
                ))
            // : const SizedBox.shrink()
            ,
            TextButton(
                style: const ButtonStyle(
                    padding: MaterialStatePropertyAll(
                        EdgeInsets.symmetric(horizontal: 16, vertical: 18)),
                    shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero)),
                    backgroundColor: MaterialStatePropertyAll(Colors.white)),
                onPressed: () {
                  Navigator.of(context).pop();

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
                            content: Text(
                                'Bạn có chắc chắn muốn xóa ${isWord ? "từ" : 'câu'} này không?'),
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
                                onPressed: deleteCallback,
                                child: const Text('Đồng ý'),
                              ),
                            ],
                          ));
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      textAlign: TextAlign.right,
                      'Xóa',
                      style: TextStyle(color: Colors.red),
                    ),
                  ],
                ))
          ])),
    ),
  );
}
