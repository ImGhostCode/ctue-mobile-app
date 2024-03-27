import 'package:ctue_app/core/constants/constants.dart';
import 'package:ctue_app/core/errors/failure.dart';
import 'package:ctue_app/features/vocabulary_set/business/entities/voca_set_entity.dart';
import 'package:ctue_app/features/vocabulary_set/presentation/providers/voca_set_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VocaSetManagementPage extends StatefulWidget {
  const VocaSetManagementPage({super.key});

  @override
  State<VocaSetManagementPage> createState() => _VocaSetManagementPageState();
}

class _VocaSetManagementPageState extends State<VocaSetManagementPage> {
  @override
  void initState() {
    Provider.of<VocaSetProvider>(context, listen: false)
        .eitherFailureOrGetVocaSetsByAdmin(null, null, '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          scrolledUnderElevation: 0,
          title: Text(
            'Quản lý bộ từ vựng',
            style: Theme.of(context).textTheme.titleMedium!.copyWith(),
          ),
          centerTitle: true,
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/create-vocabulary-set',
                      arguments: CreateVocaSetArgument(isAdmin: true));
                },
                child: Text(
                  'Thêm',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(color: Colors.teal),
                )),
            const SizedBox(
              width: 10,
            )
          ],
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
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
                height: 45,
                child: SearchBar(
                  hintText: 'Nhập câu để tìm kiếm',
                  overlayColor:
                      const MaterialStatePropertyAll(Colors.transparent),
                  hintStyle: const MaterialStatePropertyAll<TextStyle>(
                      TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                          fontWeight: FontWeight.normal)),
                  elevation: const MaterialStatePropertyAll(0),
                  shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                      side: const BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(12))),
                  backgroundColor:
                      const MaterialStatePropertyAll(Colors.transparent),
                  // controller: _searchController,
                  padding: const MaterialStatePropertyAll<EdgeInsets>(
                      EdgeInsets.symmetric(horizontal: 12.0, vertical: 2)),
                  // focusNode: _searchFocusNode,
                  onSubmitted: (String value) {
                    // Handle editing complete (e.g., when user presses Enter)
                    // setState(() {
                    //   isSearching = false;
                    // });
                  },
                  onTap: () {
                    // _searchController.openView();
                  },
                  onChanged: (_) {
                    // _searchController.openView();
                    // setState(() {
                    //   isSearching = true;
                    // });
                  },
                  leading: Icon(
                    Icons.search,
                    size: 28,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  // trailing: <Widget>[],
                )),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(onPressed: () {}, icon: const Icon(Icons.sort)),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.filter_alt_outlined)),
              ],
            ),
            // const SizedBox(
            //   height: 5,
            // ),
            // const Divider(),
            Consumer<VocaSetProvider>(builder: (context, provider, child) {
              List<VocaSetEntity> listVocaSets = provider.listVocaSets;

              bool isLoading = provider.isLoading;

              // Access the failure from the provider
              Failure? failure = provider.failure;

              if (failure != null) {
                // Handle failure, for example, show an error message
                return Text(failure.errorMessage);
              } else if (isLoading) {
                // Handle the case where topics are empty
                return const Center(
                    child:
                        CircularProgressIndicator()); // or show an empty state message
              } else if (listVocaSets.isEmpty) {
                // Handle the case where topics are empty
                return const Center(child: Text('Không có dữ liệu'));
              } else {
                return ListView.separated(
                  shrinkWrap: true,
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      height: 5,
                    );
                  },
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: listVocaSets.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                        onTap: () {
                          Navigator.pushNamed(context, '/vocabulary-set-detail',
                              arguments: VocabularySetArguments(
                                  id: listVocaSets[index].id));
                        },
                        onLongPress: () => showActionDialog(context),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 10),
                        shape: RoundedRectangleBorder(
                            side: BorderSide(
                                color: listVocaSets[index].isPublic
                                    ? Colors.green
                                    : Colors.yellow.shade700,
                                width: 1.5),
                            borderRadius: BorderRadius.circular(12)),
                        tileColor: Colors.white,
                        leading: listVocaSets[index].picture == null
                            ? Container(
                                height: 55,
                                width: 55,
                                decoration: BoxDecoration(
                                  // color: const Color(0xff7c94b6),

                                  color: Colors.blue.shade50,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Icon(
                                  Icons.folder,
                                  color: Colors.blue,
                                  size: 30,
                                ),
                              )
                            : Container(
                                height: 55,
                                width: 55,
                                decoration: BoxDecoration(
                                  // color: const Color(0xff7c94b6),
                                  // border: Border.all(color: Colors.blue, width: 2),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        listVocaSets[index].picture!),
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                        title: Text(listVocaSets[index].title),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              height: 8,
                              width: 8,
                              decoration: BoxDecoration(
                                  color: listVocaSets[index].isPublic
                                      ? Colors.green
                                      : Colors.yellow.shade700,
                                  shape: BoxShape.circle),
                            ),
                            IconButton(
                                onPressed: () => showActionDialog(context),
                                icon: const Icon(Icons.more_vert))
                          ],
                        ));
                  },
                );
              }
            })
          ],
        ),
      )),
    );
  }

  Future<String?> showActionDialog(BuildContext context) {
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
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/edit-voca-set');
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.edit,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    const Text(
                      textAlign: TextAlign.left,
                      'Chỉnh sửa',
                    ),
                  ],
                )),
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
                        // title: const Text('Cảnh báo'),
                        content: const Text(
                            'Bạn có chắc chắn muốn xóa bộ từ này không?'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'Xóa'),
                            child: const Text('Trở lại'),
                          ),
                          TextButton(
                            onPressed: () async {},
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    ),
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
                        style: TextStyle(color: Colors.red),
                        'Xóa'),
                  ],
                ))
          ]),
        ),
        // actions: <Widget>[
        //   TextButton(
        //     onPressed: () =>
        //         Navigator.pop(context, 'Cancel'),
        //     child: const Text('Cancel'),
        //   ),
        //   TextButton(
        //     onPressed: () => Navigator.pop(context, 'OK'),
        //     child: const Text('OK'),
        //   ),
        // ],
      ),
    );
  }
}

class CreateVocaSetArgument {
  final bool isAdmin;
  CreateVocaSetArgument({required this.isAdmin});
}
