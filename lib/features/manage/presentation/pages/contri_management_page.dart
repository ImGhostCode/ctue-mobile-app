import 'package:ctue_app/core/constants/constants.dart';
import 'package:ctue_app/core/errors/failure.dart';
import 'package:ctue_app/features/contribute/business/entities/contribution_entity.dart';
import 'package:ctue_app/features/contribute/presentation/providers/contribution_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ContributionManagementPage extends StatefulWidget {
  const ContributionManagementPage({super.key});

  @override
  State<ContributionManagementPage> createState() =>
      _ContributionManagementPageState();
}

const List<String> contriTypes = <String>['Từ', 'Câu'];
const List<String> contriStates = <String>[
  'Chờ duyệt',
  'Đã duyệt',
  'Đã từ chối',
];

class _ContributionManagementPageState
    extends State<ContributionManagementPage> {
  String selectedType = contriTypes.first;
  String selectedStatus = contriStates.first;

  @override
  void initState() {
    Provider.of<ContributionProvider>(context, listen: false)
        .eitherFailureOrGetAllCons(
            ContributionType.word, ContributionStatus.pending);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          scrolledUnderElevation: 0,
          title: Text(
            'Quản lý đóng góp',
            style: Theme.of(context).textTheme.titleMedium!.copyWith(),
          ),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.chevron_left_rounded,
              size: 30,
            ),
          )),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(children: [
            // Filter
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.max,
                children: [
                  DropdownMenu<String>(
                    initialSelection: selectedType,
                    onSelected: (String? value) {
                      // This is called when the user selects an item.
                      setState(() {
                        selectedType = value!;
                        print(value == 'Từ');
                        Provider.of<ContributionProvider>(context,
                                listen: false)
                            .eitherFailureOrGetAllCons(
                                value == 'Từ'
                                    ? ContributionType.word
                                    : ContributionType.sentence,
                                ContributionStatus.pending);
                      });
                    },
                    textStyle: Theme.of(context).textTheme.bodyMedium,
                    menuStyle: MenuStyle(
                        // alignment: Alignment.bottomLeft,
                        side: const MaterialStatePropertyAll(
                            BorderSide(color: Colors.teal)),
                        fixedSize: MaterialStatePropertyAll(
                            Size.fromWidth(MediaQuery.of(context).size.width)),
                        backgroundColor:
                            const MaterialStatePropertyAll(Colors.white)),
                    inputDecorationTheme: InputDecorationTheme(
                      // fillColor: Colors.white, // Adjust to white background
                      focusColor: Colors.green,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 0),

                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide: const BorderSide(
                            color: Colors.teal,
                            width: 1.5,
                          )),
                    ),
                    dropdownMenuEntries: contriTypes
                        .map<DropdownMenuEntry<String>>((String value) {
                      return DropdownMenuEntry<String>(
                          value: value,
                          label: value,
                          trailingIcon: value == selectedType
                              ? const Icon(
                                  Icons.check,
                                  color: Colors.teal,
                                )
                              : null);
                    }).toList(),
                  ),
                  DropdownMenu<String>(
                    initialSelection: selectedStatus,
                    onSelected: (String? value) {
                      // This is called when the user selects an item.
                      setState(() {
                        selectedStatus = value!;
                        // Provider.of<ContributionProvider>(context, listen: false)
                        //     .eitherFailureOrGetAllCons(
                        //         value, ContributionStatus.pending);
                      });
                    },
                    textStyle: Theme.of(context).textTheme.bodyMedium,
                    menuStyle: MenuStyle(
                        side: const MaterialStatePropertyAll(
                            BorderSide(color: Colors.teal)),
                        fixedSize: MaterialStatePropertyAll(
                            Size.fromWidth(MediaQuery.of(context).size.width)),
                        backgroundColor:
                            const MaterialStatePropertyAll(Colors.white)),
                    inputDecorationTheme: InputDecorationTheme(
                      // fillColor: Colors.white, // Adjust to white background
                      focusColor: Colors.green,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 0),

                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide: const BorderSide(
                            color: Colors.teal,
                            width: 1.5,
                          )),
                    ),
                    dropdownMenuEntries: contriStates
                        .map<DropdownMenuEntry<String>>((String value) {
                      return DropdownMenuEntry<String>(
                          value: value,
                          label: value,
                          leadingIcon: Container(
                            height: 10,
                            width: 10,
                            decoration: BoxDecoration(
                                color: getStatusColor2(value),
                                // : Colors.green,
                                shape: BoxShape.circle),
                          ),
                          trailingIcon: value == selectedStatus
                              ? const Icon(
                                  Icons.check,
                                  color: Colors.teal,
                                )
                              : null);
                    }).toList(),
                  ),
                ]),
            const SizedBox(
              height: 10,
            ),
            Consumer<ContributionProvider>(builder: (context, provider, child) {
              List<ContributionEntity> listCons = provider.listCons;

              bool isLoading = provider.isLoading;

              Failure? failure = provider.failure;

              if (failure != null) {
                // Handle failure, for example, show an error message
                return Text(failure.errorMessage);
              } else if (isLoading) {
                // Handle the case where topics are empty
                return const Center(
                    child:
                        CircularProgressIndicator()); // or show an empty state message
              } else if (listCons.isEmpty) {
                // Handle the case where topics are empty
                return const Center(
                    child: Text(
                        'Không có dữ liệu')); // or show an empty state message
              } else {
                return ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return ListTile(
                          onTap: () =>
                              listCons[index].type == ContributionType.word
                                  ? showWordConDetail(
                                      context, listCons[index].content)
                                  : showSentenceConDetail(
                                      context, listCons[index].content),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 0),
                          leading: ClipOval(
                            child: SizedBox(
                              height: 50,
                              width: 50,
                              child: listCons[index].user!.avt != null
                                  ? Image.network(
                                      listCons[index].user!.avt!,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.asset(
                                      'assets/images/default-user3.png',
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          ),
                          title: Text(listCons[index].content['content']),
                          subtitle: Text(
                              '${listCons[index].createdAt.day}/${listCons[index].createdAt.month}/${listCons[index].createdAt.year}'),
                          trailing: Container(
                            height: 10,
                            width: 10,
                            decoration: BoxDecoration(
                                color: getStatusColor(listCons[index].status),
                                // : Colors.green,
                                shape: BoxShape.circle),
                          ));
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox();
                    },
                    itemCount: listCons.length);
              }
            })
          ]),
        ),
      ),
    );
  }

  Color getStatusColor(int status) {
    switch (status) {
      case ContributionStatus.refused:
        return Colors.red;
      case 0:
        return Colors.yellow;
      case 1:
        return Colors.green;
      default:
        return Colors.red;
    }
  }

  Color getStatusColor2(String status) {
    switch (status) {
      case 'Đã từ chối':
        return Colors.red;
      case 'Chờ duyệt':
        return Colors.yellow;
      case 'Đã duyệt':
        return Colors.green;
      default:
        return Colors.red;
    }
  }

  Future<String?> showWordConDetail(
      BuildContext context, Map<String, dynamic> contributionDetail) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        shadowColor: Colors.white,
        title: Text(
          'Chi tiết đóng góp',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        content: SizedBox(
          width: MediaQuery.of(context).size.width - 100,
          child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Từ: ',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    Text('${contributionDetail['content']}'),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'Phiên âm: ',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '/${contributionDetail['phonetic']}/',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 17,
                          fontFamily: 'DoulosSIL'),
                    ),
                  ],
                ),
                Text(
                  'Nghĩa của từ: ',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                ...List.generate(
                  contributionDetail['meanings'].length,
                  (index) => Row(
                    children: [
                      Text(
                        '- ${contributionDetail['meanings'][index]['typeId']}: ',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(
                          '${contributionDetail['meanings'][index]['meaning']}'),
                    ],
                  ),
                ).toList(),
                Row(
                  children: [
                    Text(
                      'Chuyên ngành: ',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    Text('${contributionDetail['specializationId']}'),
                  ],
                ),
                contributionDetail['pictures'].isNotEmpty
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Ảnh minh họa: ',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          SizedBox(
                            height: 100,
                            child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return SizedBox(
                                    height: 100,
                                    width: 100,
                                    child: Image.network(
                                      contributionDetail['pictures'][index],
                                      // height: 100,
                                      fit: BoxFit.fill,
                                    ),
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return const SizedBox(
                                    width: 5,
                                  );
                                },
                                itemCount:
                                    contributionDetail['pictures'].length),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      )
                    : const SizedBox.shrink(),
                contributionDetail['examples'] != null
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Câu ví dụ: ',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          ...List.generate(
                                  contributionDetail['examples'] != null
                                      ? contributionDetail['examples']?.length
                                      : 0,
                                  (index) => Text(
                                      '- ${contributionDetail['examples'][index]}'))
                              .toList(),
                        ],
                      )
                    : const SizedBox.shrink(),
                Row(
                  children: [
                    Text(
                      'Chủ đề: ',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    Text('${contributionDetail['topicId'].join(', ')}'),
                  ],
                ),
                contributionDetail['synonyms'] != null
                    ? Row(
                        children: [
                          Text(
                            'Từ đồng nghĩa: ',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          Text('${contributionDetail['synonyms'].join(', ')}'),
                        ],
                      )
                    : const SizedBox.shrink(),
                contributionDetail['antonyms'] != null
                    ? Row(
                        children: [
                          Text(
                            'Từ trái nghĩa: ',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          Text('${contributionDetail['antonyms'].join(', ')}'),
                        ],
                      )
                    : const SizedBox.shrink(),
                contributionDetail['note'] != ''
                    ? Row(
                        children: [
                          Text(
                            'Ghi chú: ',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          Text('${contributionDetail['note']}'),
                        ],
                      )
                    : const SizedBox.shrink(),
              ]),
        ),
        actionsAlignment: MainAxisAlignment.spaceBetween,
        actions: <Widget>[
          ElevatedButton(
              style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.green),
                  padding: MaterialStatePropertyAll(
                      EdgeInsets.symmetric(horizontal: 16, vertical: 16))),
              onPressed: () {},
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.check),
                  SizedBox(
                    width: 3,
                  ),
                  Text('Chấp nhận'),
                ],
              )),
          ElevatedButton(
              style: ButtonStyle(
                  padding: const MaterialStatePropertyAll(
                      EdgeInsets.symmetric(horizontal: 16, vertical: 16)),
                  backgroundColor:
                      MaterialStatePropertyAll(Colors.red.shade500)),
              onPressed: () {},
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.close,
                    size: 28,
                  ),
                  SizedBox(
                    width: 3,
                  ),
                  Text(
                    'Từ chối',
                  ),
                ],
              ))
        ],
      ),
    );
  }

  Future<String?> showSentenceConDetail(
      BuildContext context, Map<String, dynamic> contributionDetail) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        shadowColor: Colors.white,
        title: Text(
          'Chi tiết đóng góp',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        content: SizedBox(
          width: MediaQuery.of(context).size.width - 100,
          child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    text: 'Câu: ',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(fontWeight: FontWeight.bold),
                    children: <TextSpan>[
                      TextSpan(
                        text: '${contributionDetail['content']}',
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ),
                RichText(
                  text: TextSpan(
                    text: 'Nghĩa của câu: ',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(fontWeight: FontWeight.bold),
                    children: <TextSpan>[
                      TextSpan(
                        text: '${contributionDetail['meaning']}',
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Text(
                      'Loại câu: ',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    Text('${contributionDetail['typeId']}'),
                  ],
                ),
                RichText(
                  text: TextSpan(
                    text: 'Chủ đề: ',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(fontWeight: FontWeight.bold),
                    children: <TextSpan>[
                      TextSpan(
                        text: '${contributionDetail['topicId'].join(', ')}',
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ),
                contributionDetail['note'] != null
                    ? Row(
                        children: [
                          Text(
                            'Ghi chú: ',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          Text('${contributionDetail['note']}'),
                        ],
                      )
                    : const SizedBox.shrink(),
              ]),
        ),
        actionsAlignment: MainAxisAlignment.spaceBetween,
        actions: <Widget>[
          ElevatedButton(
              style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.green),
                  padding: MaterialStatePropertyAll(
                      EdgeInsets.symmetric(horizontal: 16, vertical: 16))),
              onPressed: () {},
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.check),
                  SizedBox(
                    width: 3,
                  ),
                  Text('Chấp nhận'),
                ],
              )),
          ElevatedButton(
              style: ButtonStyle(
                  padding: const MaterialStatePropertyAll(
                      EdgeInsets.symmetric(horizontal: 16, vertical: 16)),
                  backgroundColor:
                      MaterialStatePropertyAll(Colors.red.shade500)),
              onPressed: () {},
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.close,
                    size: 28,
                  ),
                  SizedBox(
                    width: 3,
                  ),
                  Text(
                    'Từ chối',
                  ),
                ],
              ))
        ],
      ),
    );
  }
}

class ContributeType {
  final String title;
  bool isSelected;

  ContributeType({required this.title, this.isSelected = false});
}
