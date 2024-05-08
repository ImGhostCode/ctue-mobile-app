import 'package:ctue_app/core/constants/constants.dart';
import 'package:ctue_app/features/contribute/business/entities/contribution_entity.dart';
import 'package:ctue_app/features/contribute/presentation/providers/contribution_provider.dart';
import 'package:ctue_app/features/manage/presentation/pages/acc_management_page.dart';
import 'package:ctue_app/features/user/business/entities/user_entity.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
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
  String selectedType = ContributionType.word;
  String selectedTypeVi = ContributionType.wordVi;
  String selectedStatus = contriStates.first;

  final PagingController<int, ContributionEntity> _pagingController =
      PagingController(firstPageKey: 1);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      await Provider.of<ContributionProvider>(context, listen: false)
          .eitherFailureOrGetAllCons(
              selectedType, getStatusNumber(selectedStatus), pageKey);
      final newItems =
          // ignore: use_build_context_synchronously
          Provider.of<ContributionProvider>(context, listen: false)
              .contributionResEntity!
              .data;

      final isLastPage =
          // ignore: use_build_context_synchronously
          Provider.of<ContributionProvider>(context, listen: false)
                  .contributionResEntity!
                  .totalPages! <=
              pageKey;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
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
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(children: [
          // Filter
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.max,
              children: [
                Center(
                  child: DropdownMenu<String>(
                    initialSelection: contriTypes.first,
                    onSelected: (String? value) {
                      switch (value) {
                        case ContributionType.wordVi:
                          selectedType = ContributionType.word;
                          selectedTypeVi = ContributionType.wordVi;
                          break;
                        case ContributionType.sentenceVi:
                          selectedType = ContributionType.sentence;
                          selectedTypeVi = ContributionType.sentenceVi;
                          break;
                        default:
                          selectedType = value!;
                      }
                      _pagingController.refresh();
                    },
                    textStyle: Theme.of(context).textTheme.bodyMedium,
                    menuStyle: MenuStyle(
                        alignment: Alignment.topCenter,
                        maximumSize: MaterialStatePropertyAll(Size.fromWidth(
                            MediaQuery.of(context).size.width * 0.9)),
                        side: const MaterialStatePropertyAll(
                            BorderSide(color: Colors.teal)),
                        fixedSize: MaterialStatePropertyAll(Size.fromWidth(
                            MediaQuery.of(context).size.width * 0.9)),
                        surfaceTintColor:
                            const MaterialStatePropertyAll(Colors.white),
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
                          trailingIcon: value == selectedTypeVi
                              ? const Icon(
                                  Icons.check,
                                  color: Colors.teal,
                                )
                              : null);
                    }).toList(),
                  ),
                ),
                Center(
                  child: DropdownMenu<String>(
                    initialSelection: selectedStatus,
                    onSelected: (String? value) {
                      // This is called when the user selects an item.
                      setState(() {
                        selectedStatus = value!;
                      });
                      _pagingController.refresh();
                    },
                    textStyle: Theme.of(context).textTheme.bodyMedium,
                    menuStyle: MenuStyle(
                        alignment: Alignment.topCenter,
                        maximumSize: MaterialStatePropertyAll(Size.fromWidth(
                            MediaQuery.of(context).size.width * 0.9)),
                        side: const MaterialStatePropertyAll(
                            BorderSide(color: Colors.teal)),
                        fixedSize: MaterialStatePropertyAll(Size.fromWidth(
                            MediaQuery.of(context).size.width * 0.9)),
                        surfaceTintColor:
                            const MaterialStatePropertyAll(Colors.white),
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
                ),
              ]),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Tổng cộng: ${Provider.of<ContributionProvider>(context, listen: true).contributionResEntity?.total ?? 'Đang tải...'}',
                textAlign: TextAlign.start,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Colors.blue),
              ),
            ],
          ),
          Expanded(
            child: PagedListView<int, ContributionEntity>(
              pagingController: _pagingController,
              shrinkWrap: true,
              // physics: const NeverScrollableScrollPhysics(),
              builderDelegate: PagedChildBuilderDelegate<ContributionEntity>(
                itemBuilder: (context, item, index) => ListTile(
                    onTap: () => item.type == ContributionType.word
                        ? showWordConDetail(
                            context,
                            item,
                            item.user!,
                            item.content,
                            item.feedback,
                            true,
                            () {
                              setState(() {});
                            },
                          )
                        : showSentenceConDetail(
                            context,
                            item,
                            item.user!,
                            item.content,
                            item.feedback,
                            true,
                            () {
                              setState(() {});
                            },
                          ),
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                    leading: ClipOval(
                      child: SizedBox(
                        height: 50,
                        width: 50,
                        child: item.user!.avt != null
                            ? Image.network(
                                item.user!.avt!,
                                errorBuilder: (context, error, stackTrace) =>
                                    Image.asset(
                                  'assets/images/broken-image.png',
                                  color: Colors.grey.shade300,
                                  fit: BoxFit.cover,
                                ),
                                fit: BoxFit.cover,
                                loadingBuilder:
                                    (context, child, loadingProgress) {
                                  if (loadingProgress == null) {
                                    return child;
                                  }
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                },
                              )
                            : Image.asset('assets/images/no-image.jpg',
                                // color: Colors.grey.shade300,
                                fit: BoxFit.cover),
                      ),
                    ),
                    title: Text(item.content['content']),
                    subtitle: Text(
                        '${item.createdAt.day}/${item.createdAt.month}/${item.createdAt.year}'),
                    trailing: Container(
                      height: 10,
                      width: 10,
                      decoration: BoxDecoration(
                          color: getStatusColor(item.status),
                          // : Colors.green,
                          shape: BoxShape.circle),
                    )),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

int getStatusNumber(String status) {
  switch (status) {
    case 'Chờ duyệt':
      return 0;
    case 'Đã duyệt':
      return 1;
    case 'Đã từ chối':
      return -1;
    default:
      return 2;
  }
}

Future<void> _dialogRefuseConBuilder(BuildContext context,
    ContributionEntity contribution, VoidCallback callback, bool isWord) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      final TextEditingController reasonController = TextEditingController();
      return AlertDialog(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        shadowColor: Colors.white,
        title: Text(
          'Từ chối đóng góp',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        content: SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          child: TextField(
            style: Theme.of(context).textTheme.bodyMedium,
            controller: reasonController,
            maxLines: 4,
            decoration: const InputDecoration(
                hintText: 'Lý do', border: OutlineInputBorder()),
          ),
        ),
        actions: <Widget>[
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey.shade400,
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text('Trở về'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            onPressed: Provider.of<ContributionProvider>(context, listen: true)
                    .isLoading
                ? null
                : () async {
                    await Provider.of<ContributionProvider>(context,
                            listen: false)
                        .eitherFailureOrVerifyCon(
                            contribution.id,
                            ContributionStatus.refused,
                            reasonController.text,
                            isWord);
                    // ignore: use_build_context_synchronously
                    Navigator.pop(context);

                    // ignore: use_build_context_synchronously
                    if (Provider.of<ContributionProvider>(context,
                                listen: false)
                            .statusCode ==
                        200) {
                      contribution.feedback = reasonController.text;
                      contribution.status = ContributionStatus.refused;
                      callback();

                      // ignore: use_build_context_synchronously
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          duration: const Duration(seconds: 1),
                          content: Text(
                            // ignore: use_build_context_synchronously
                            Provider.of<ContributionProvider>(context,
                                    listen: false)
                                .message!,
                            style: const TextStyle(color: Colors.white),
                          ),
                          backgroundColor:
                              Colors.green, // You can customize the color
                        ),
                      );
                      // ignore: use_build_context_synchronously
                    } else if (Provider.of<ContributionProvider>(context,
                                listen: false)
                            .failure !=
                        null) {
                      // ignore: use_build_context_synchronously
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          duration: const Duration(seconds: 1),
                          content: Text(
                            // ignore: use_build_context_synchronously
                            Provider.of<ContributionProvider>(context,
                                    listen: false)
                                .message!,
                            style: const TextStyle(color: Colors.white),
                          ),
                          backgroundColor:
                              Colors.red, // You can customize the color
                        ),
                      );
                    }
                  },
            child: Provider.of<ContributionProvider>(context, listen: true)
                    .isLoading
                ? const SizedBox(
                    height: 25,
                    width: 25,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  )
                : const Text('Đồng ý'),
          ),
        ],
      );
    },
  );
}

Future<String?> showWordConDetail(
    BuildContext context,
    ContributionEntity contribution,
    UserEntity user,
    Map<String, dynamic> contributionDetail,
    String? feedback,
    bool isAdmin,
    VoidCallback? callback) {
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
              if (isAdmin)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Người đóng góp: ',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    !isAdmin
                        ? Text(user.name)
                        : Flexible(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, RouteNames.accountDetail,
                                    arguments: AccountDetailArguments(
                                        userId: user.id));
                              },
                              child: Text(
                                user.name,
                                style: const TextStyle(
                                    decoration: TextDecoration.underline),
                              ),
                            ),
                          )
                  ],
                ),
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
              Row(
                children: [
                  Text(
                    'Cấp độ: ',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  Text('${contributionDetail['Level']['name']}',
                      style: Theme.of(context).textTheme.bodyMedium),
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
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      '- ${contributionDetail['meanings'][index]['Type']['name']}: ',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    Text('${contributionDetail['meanings'][index]['meaning']}'),
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
                  Text('${contributionDetail['Specialization']['name']}'),
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
                                    width: MediaQuery.of(context).size.width *
                                        0.25, // 25% of screen width
                                    height: 100,
                                    child: Image.network(
                                      contributionDetail['pictures'][index],
                                      errorBuilder:
                                          (context, error, stackTrace) =>
                                              Image.asset(
                                        'assets/images/broken-image.png',
                                        color: Colors.grey.shade300,
                                        fit: BoxFit.cover,
                                      ),
                                      // height: 100,
                                      fit: BoxFit.cover,
                                      loadingBuilder:
                                          (context, child, loadingProgress) {
                                        if (loadingProgress == null) {
                                          return child;
                                        }
                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      },
                                    ));
                              },
                              separatorBuilder: (context, index) {
                                return const SizedBox(
                                  width: 5,
                                );
                              },
                              itemCount: contributionDetail['pictures'].length),
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
                        const SizedBox(
                          height: 5,
                        ),
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
                  Text(
                      '${contributionDetail['Topic'].map((topic) => topic['name']).join(', ')}'),
                ],
              ),
              contributionDetail['synonyms'].isNotEmpty
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
              contributionDetail['antonyms'].isNotEmpty
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
              contributionDetail['note'].isNotEmpty
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
              Row(
                children: [
                  Text(
                    'Trạng thái: ',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Container(
                    height: 10,
                    width: 10,
                    decoration: BoxDecoration(
                        color: getStatusColor(contribution.status),
                        // : Colors.green,
                        shape: BoxShape.circle),
                  ),
                  const SizedBox(
                    width: 3,
                  ),
                  Text(getStatusString(contribution.status)),
                ],
              ),
              feedback!.isNotEmpty
                  ? RichText(
                      text: TextSpan(
                        text: 'Nhận xét: ',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.bold, color: Colors.blue),
                        children: <TextSpan>[
                          TextSpan(
                            text: feedback,
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(
                                    fontWeight: FontWeight.normal,
                                    color: Colors.blue),
                          ),
                        ],
                      ),
                    )
                  : const SizedBox.shrink(),
            ]),
      ),
      actionsAlignment: MainAxisAlignment.spaceBetween,
      actions: isAdmin && contribution.status == ContributionStatus.pending
          ? <Widget>[
              ElevatedButton(
                  style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.green),
                      padding: MaterialStatePropertyAll(
                          EdgeInsets.symmetric(horizontal: 16, vertical: 16))),
                  onPressed: Provider.of<ContributionProvider>(context,
                              listen: true)
                          .isLoading
                      ? null
                      : () async {
                          await Provider.of<ContributionProvider>(context,
                                  listen: false)
                              .eitherFailureOrVerifyCon(contribution.id,
                                  ContributionStatus.approved, null, true);

                          // ignore: use_build_context_synchronously
                          Navigator.pop(context);
                          // ignore: use_build_context_synchronously
                          if (Provider.of<ContributionProvider>(context,
                                      listen: false)
                                  .statusCode ==
                              200) {
                            contribution.status = ContributionStatus.approved;
                            callback!();
                            // ignore: use_build_context_synchronously
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                duration: const Duration(seconds: 1),
                                content: Text(
                                  // ignore: use_build_context_synchronously
                                  Provider.of<ContributionProvider>(context,
                                          listen: false)
                                      .message!,
                                  style: const TextStyle(color: Colors.white),
                                ),
                                backgroundColor:
                                    Colors.green, // You can customize the color
                              ),
                            );
                            // ignore: use_build_context_synchronously
                          } else if (Provider.of<ContributionProvider>(context,
                                      listen: false)
                                  .failure !=
                              null) {
                            // ignore: use_build_context_synchronously
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                duration: const Duration(seconds: 1),
                                content: Text(
                                  // ignore: use_build_context_synchronously
                                  Provider.of<ContributionProvider>(context,
                                          listen: false)
                                      .message!,
                                  style: const TextStyle(color: Colors.white),
                                ),
                                backgroundColor:
                                    Colors.red, // You can customize the color
                              ),
                            );
                          }
                        },
                  child:
                      Provider.of<ContributionProvider>(context, listen: true)
                              .isLoading
                          ? const SizedBox(
                              height: 25,
                              width: 25,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ))
                          : const Row(
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
                  onPressed: () {
                    Navigator.pop(context);
                    _dialogRefuseConBuilder(
                        context, contribution, callback!, true);
                  },
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
            ]
          : [],
    ),
  );
}

Future<String?> showSentenceConDetail(
    BuildContext context,
    ContributionEntity contribution,
    UserEntity user,
    Map<String, dynamic> contributionDetail,
    String? feedback,
    bool isAdmin,
    VoidCallback? callback) {
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
              if (isAdmin)
                Row(
                  children: [
                    Text(
                      'Người đóng góp: ',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    !isAdmin
                        ? Text(user.name)
                        : Flexible(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, RouteNames.accountDetail,
                                    arguments: AccountDetailArguments(
                                        userId: user.id));
                              },
                              child: Flexible(
                                child: Text(
                                  user.name,
                                  style: const TextStyle(
                                      decoration: TextDecoration.underline),
                                ),
                              ),
                            ),
                          )
                  ],
                ),
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
                  Text('${contributionDetail['Type']['name']}'),
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
                      text:
                          '${contributionDetail['Topic'].map((topic) => topic['name']).join(', ')}',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
              ),
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
              Row(
                children: [
                  Text(
                    'Trạng thái: ',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Container(
                    height: 10,
                    width: 10,
                    decoration: BoxDecoration(
                        color: getStatusColor(contribution.status),
                        // : Colors.green,
                        shape: BoxShape.circle),
                  ),
                  const SizedBox(
                    width: 3,
                  ),
                  Text(getStatusString(contribution.status)),
                ],
              ),
              feedback!.isNotEmpty
                  ? RichText(
                      text: TextSpan(
                        text: 'Nhận xét: ',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.bold, color: Colors.blue),
                        children: <TextSpan>[
                          TextSpan(
                            text: feedback,
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(
                                    fontWeight: FontWeight.normal,
                                    color: Colors.blue),
                          ),
                        ],
                      ),
                    )
                  : const SizedBox.shrink(),
            ]),
      ),
      actionsAlignment: MainAxisAlignment.spaceBetween,
      actions: isAdmin && contribution.status == ContributionStatus.pending
          ? <Widget>[
              ElevatedButton(
                  style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.green),
                      padding: MaterialStatePropertyAll(
                          EdgeInsets.symmetric(horizontal: 16, vertical: 16))),
                  onPressed: Provider.of<ContributionProvider>(context,
                              listen: true)
                          .isLoading
                      ? null
                      : () async {
                          await Provider.of<ContributionProvider>(context,
                                  listen: false)
                              .eitherFailureOrVerifyCon(contribution.id,
                                  ContributionStatus.approved, null, false);

                          // ignore: use_build_context_synchronously
                          Navigator.pop(context);
                          // ignore: use_build_context_synchronously
                          if (Provider.of<ContributionProvider>(context,
                                      listen: false)
                                  .statusCode ==
                              200) {
                            contribution.status = ContributionStatus.approved;
                            callback!();
                            // ignore: use_build_context_synchronously
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                duration: const Duration(seconds: 1),
                                content: Text(
                                  // ignore: use_build_context_synchronously
                                  Provider.of<ContributionProvider>(context,
                                          listen: false)
                                      .message!,
                                  style: const TextStyle(color: Colors.white),
                                ),
                                backgroundColor:
                                    Colors.green, // You can customize the color
                              ),
                            );
                            // ignore: use_build_context_synchronously
                          } else if (Provider.of<ContributionProvider>(context,
                                      listen: false)
                                  .failure !=
                              null) {
                            // ignore: use_build_context_synchronously
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                duration: const Duration(seconds: 1),
                                content: Text(
                                  // ignore: use_build_context_synchronously
                                  Provider.of<ContributionProvider>(context,
                                          listen: false)
                                      .message!,
                                  style: const TextStyle(color: Colors.white),
                                ),
                                backgroundColor:
                                    Colors.red, // You can customize the color
                              ),
                            );
                          }
                        },
                  child:
                      Provider.of<ContributionProvider>(context, listen: true)
                              .isLoading
                          ? const SizedBox(
                              height: 25,
                              width: 25,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ))
                          : const Row(
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
                  onPressed: () {
                    Navigator.pop(context);
                    _dialogRefuseConBuilder(
                        context, contribution, callback!, true);
                  },
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
            ]
          : [],
    ),
  );
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

Color getStatusColor(int status) {
  switch (status) {
    case ContributionStatus.refused:
      return Colors.red;
    case ContributionStatus.pending:
      return Colors.yellow;
    case ContributionStatus.approved:
      return Colors.green;
    default:
      return Colors.red;
  }
}

String getStatusString(int status) {
  switch (status) {
    case ContributionStatus.refused:
      return 'Đã từ chối';
    case ContributionStatus.pending:
      return 'Chờ duyệt';
    case ContributionStatus.approved:
      return 'Đã duyệt';
    default:
      return 'Chờ duyệt';
  }
}

class ContributeType {
  final String title;
  bool isSelected;

  ContributeType({required this.title, this.isSelected = false});
}
