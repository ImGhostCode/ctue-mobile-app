import 'package:flutter/material.dart';

class IrregularVerbPage extends StatelessWidget {
  IrregularVerbPage({Key? key}) : super(key: key);

  final List<IrregularVerb> _irregularVerbs = [
    IrregularVerb(v1: 'do', v2: 'did', v3: 'done', meaning: 'làm'),
    IrregularVerb(
        v1: 'bring', v2: 'brought', v3: 'brought', meaning: 'mang đến'),
    IrregularVerb(v1: 'build', v2: 'built', v3: 'built', meaning: 'xây dựng'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(
            'Động từ bất quy tắc',
            style: Theme.of(context).textTheme.titleMedium!.copyWith(),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      // obscureText: true,

                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                  color:
                                      Theme.of(context).colorScheme.primary)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12)),
                          // labelText: 'Password',
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 4),
                          hintText: 'Nhập từ để tìm kiếm',
                          hintStyle: Theme.of(context).textTheme.bodyMedium),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  IconButton(
                      onPressed: () {}, icon: const Icon(Icons.swap_vert))
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Table(
                // border: TableBorder(borderRadius: BorderRadius.circular(15)),

                columnWidths: const <int, TableColumnWidth>{
                  0: FlexColumnWidth(),
                  1: FlexColumnWidth(),
                  3: FlexColumnWidth(),
                  4: FlexColumnWidth(),
                },
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                children: <TableRow>[
                  TableRow(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12)),
                      // color: Colors.blue.shade50,
                    ),
                    children: <Widget>[
                      TableCell(
                          child: Container(
                              alignment: Alignment.center,
                              height: 45,
                              child: Text(
                                'Nguyên mẫu',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                        color: Colors.green,
                                        fontWeight: FontWeight.w600),
                              ))),
                      TableCell(
                          child: Container(
                              alignment: Alignment.center,
                              height: 45,
                              child: Text(
                                'Quá khứ đơn',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                        color: Colors.green,
                                        fontWeight: FontWeight.w600),
                              ))),
                      TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child: Container(
                              alignment: Alignment.center,
                              height: 45,
                              child: Text(
                                'Quá khứ phân từ',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                        color: Colors.green,
                                        fontWeight: FontWeight.w600),
                              ))),
                      TableCell(
                          child: Container(
                              alignment: Alignment.center,
                              height: 45,
                              child: Text(
                                'Nghĩa',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                        color: Colors.green,
                                        fontWeight: FontWeight.w600),
                              ))),
                    ],
                  ),
                  for (IrregularVerb verb in _irregularVerbs)
                    TableRow(
                      decoration: BoxDecoration(
                        // borderRadius: const BorderRadius.only(
                        //     topLeft: Radius.circular(12),
                        //     topRight: Radius.circular(12)),
                        color: Colors.grey.shade50,
                      ),
                      children: <Widget>[
                        TableCell(
                            child: Container(
                                alignment: Alignment.center,
                                height: 32,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      verb.v1,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(color: Colors.black),
                                    ),
                                  ],
                                ))),
                        TableCell(
                            child: Container(
                                alignment: Alignment.center,
                                height: 32,
                                child: Text(
                                  verb.v2,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(color: Colors.black),
                                ))),
                        TableCell(
                            child: Container(
                                alignment: Alignment.center,
                                height: 32,
                                child: Text(
                                  verb.v3,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(color: Colors.black),
                                ))),
                        TableCell(
                            child: Container(
                                alignment: Alignment.center,
                                height: 32,
                                child: Text(
                                  verb.meaning,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(color: Colors.black),
                                ))),
                      ],
                    )
                ],
              )
            ]),
          ),
        ));
  }
}

class IrregularVerb {
  final String v1;
  final String v2;
  final String v3;
  final String meaning;

  IrregularVerb(
      {required this.v1,
      required this.v2,
      required this.v3,
      required this.meaning});
}
