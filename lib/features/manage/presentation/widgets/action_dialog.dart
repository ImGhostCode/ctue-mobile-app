import 'package:flutter/material.dart';

Future<String?> showActionDialog(
    BuildContext context, bool isWord, VoidCallback deleteCallback) {
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
                onPressed: () async {
                  Navigator.pop(context);
                  Navigator.pushNamed(
                      context, '/edit-${isWord ? 'word' : 'sentence'}');
                },
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
                onPressed: () => showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                          backgroundColor: Colors.white,
                          title: const Text(
                            'Cảnh báo',
                            style: TextStyle(
                                color: Colors.red, fontWeight: FontWeight.bold),
                          ),
                          content: Text(
                              'Bạn có chắc chắn muốn xóa ${isWord ? "từ" : 'câu'} này không?'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'back'),
                              child: const Text('Trở lại'),
                            ),
                            TextButton(
                              onPressed: deleteCallback,
                              child: const Text('OK'),
                            ),
                          ],
                        )),
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
