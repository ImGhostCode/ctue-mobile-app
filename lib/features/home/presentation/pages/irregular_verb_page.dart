import 'package:ctue_app/core/errors/failure.dart';
import 'package:ctue_app/features/irregular_verb/business/entities/irr_verb_entity.dart';
import 'package:ctue_app/features/irregular_verb/presentation/providers/irr_verb_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IrregularVerbPage extends StatelessWidget {
  IrregularVerbPage({Key? key}) : super(key: key);

  String sort = 'asc';

  @override
  Widget build(BuildContext context) {
    Provider.of<IrrVerbProvider>(context, listen: false)
        .eitherFailureOrIrrVerbs(1, 'asc', null);

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
                      onChanged: ((value) {
                        Provider.of<IrrVerbProvider>(context, listen: false)
                            .eitherFailureOrIrrVerbs(1, sort, value);
                      }),
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
                      onPressed: () {
                        sort = sort == 'asc' ? 'desc' : 'asc';
                        Provider.of<IrrVerbProvider>(context, listen: false)
                            .eitherFailureOrIrrVerbs(1, sort, null);
                      },
                      icon: const Icon(Icons.swap_vert))
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
                  return Table(
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
                              verticalAlignment:
                                  TableCellVerticalAlignment.middle,
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
                      for (IrrVerbEntity verb in irrVerbs)
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                  );
                }
              })
            ]),
          ),
        ));
  }
}
