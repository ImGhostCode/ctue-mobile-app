import 'dart:async';

import 'package:ctue_app/core/constants/constants.dart';
import 'package:ctue_app/features/auth/business/entities/account_entiry.dart';
import 'package:ctue_app/features/user/business/entities/user_entity.dart';
import 'package:ctue_app/features/user/presentation/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';

class AccountManagementPage extends StatefulWidget {
  const AccountManagementPage({super.key});

  @override
  State<AccountManagementPage> createState() => _AccountManagementPageState();
}

enum SampleItem { itemOne, itemTwo, itemThree }

class _AccountManagementPageState extends State<AccountManagementPage> {
  bool isBanned = false;
  SampleItem? selectedItem;
  // static const _pageSize = 20;
  Timer? _searchTimer;
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  bool isSearching = false;

  final PagingController<int, AccountEntity> _pagingController =
      PagingController(firstPageKey: 1);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    _searchFocusNode.addListener(() {
      if (!_searchFocusNode.hasFocus) {
        setState(() {
          isSearching = false;
        });
      }
    });
    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      await Provider.of<UserProvider>(context, listen: false)
          .eitherFailureOrGetAllUser(pageKey, _searchController.text, isBanned);
      final newItems =
          // ignore: use_build_context_synchronously
          Provider.of<UserProvider>(context, listen: false).userResEntity!.data;

      // ignore: use_build_context_synchronously
      final isLastPage = Provider.of<UserProvider>(context, listen: false)
              .userResEntity!
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
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.white,
            scrolledUnderElevation: 0,
            title: Text(
              'Quản lý tài khoản',
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
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                  height: 45,
                  child: SearchBar(
                    controller: _searchController,
                    hintText: 'Nhập tên người dùng',
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
                      setState(() {
                        isSearching = false;
                      });
                    },
                    onTap: () {
                      // _searchController.openView();
                    },
                    onChanged: (value) {
                      setState(() {
                        isSearching = true;
                      });
                      _searchTimer?.cancel();
                      _searchTimer =
                          Timer(const Duration(milliseconds: 300), () {
                        _pagingController.refresh();
                      });
                    },
                    leading: Icon(
                      Icons.search,
                      size: 28,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    trailing: <Widget>[
                      _searchController.text.isNotEmpty
                          ? IconButton(
                              onPressed: () {
                                _searchController.clear();
                                // _searchFocusNode
                                // FocusScope.of(context)
                                //     .requestFocus(_searchFocusNode);
                                _searchFocusNode.requestFocus();
                                // FocusScope.of(context).unfocus();
                                isSearching = false;
                                // _searchFocusNode.unfocus();
                                _pagingController.refresh();
                                setState(() {});
                              },
                              icon: const Icon(Icons.close))
                          : const SizedBox.shrink()
                    ],
                    // trailing: <Widget>[],
                  )),
              const SizedBox(
                height: 10,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(
                  'Tổng cộng: ${Provider.of<UserProvider>(context, listen: true).userResEntity?.total ?? 'Đang tải...'}',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Colors.blue),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      isBanned ? 'Đã khóa' : 'Đang hoạt động',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Colors.blue, fontWeight: FontWeight.bold),
                    ),
                    PopupMenuButton<bool>(
                      icon: const Icon(Icons.sort),
                      onSelected: (value) {
                        setState(() {
                          isBanned = value;
                        });
                        _pagingController.refresh();
                      },
                      color: Colors.white,
                      itemBuilder: (BuildContext context) =>
                          <PopupMenuEntry<bool>>[
                        const PopupMenuItem<bool>(
                          value: false,
                          child: Text('Đang hoạt động'),
                        ),
                        const PopupMenuItem<bool>(
                          value: true,
                          child: Text('Đã khóa'),
                        ),
                        // Add more items if needed
                      ],
                    ),
                  ],
                ),
              ]),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: PagedListView<int, AccountEntity>(
                  pagingController: _pagingController,
                  shrinkWrap: true,
                  // physics: const NeverScrollableScrollPhysics(),
                  builderDelegate: PagedChildBuilderDelegate<AccountEntity>(
                    itemBuilder: (context, item, index) => ListTile(
                        onTap: () => showUserDetail(context, item),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 8),
                        leading: ClipOval(
                          child: SizedBox(
                            height: 50,
                            width: 50,
                            child: item.user?.avt != null
                                ? Image.network(
                                    item.user!.avt!,
                                    errorBuilder:
                                        (context, error, stackTrace) =>
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
                        title: Text(item.user!.name),
                        subtitle: Text(item.email),
                        trailing: Container(
                          height: 10,
                          width: 10,
                          decoration: BoxDecoration(
                              color:
                                  item.isBanned ? Colors.yellow : Colors.green,
                              shape: BoxShape.circle),
                        )),
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  Future<String?> showUserDetail(BuildContext context, AccountEntity account) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        shadowColor: Colors.white,
        title: Text(
          'Thông tin tài khoản',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Id: ',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  Text('${account.user!.id}'),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tên người dùng: ',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  Flexible(child: Text(account.user!.name)),
                ],
              ),
              Row(
                children: [
                  Text(
                    'Email: ',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  Text(account.email),
                ],
              ),
              Row(
                children: [
                  Text(
                    'Ngày đăng ký: ',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  Text(
                      '${account.user!.createdAt.day}/${account.user!.createdAt.month}/${account.user!.createdAt.year}'),
                ],
              ),
              Row(
                children: [
                  Text(
                    'Trạng thái: ',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 5),
                    height: 10,
                    width: 10,
                    decoration: BoxDecoration(
                        color: account.isBanned ? Colors.yellow : Colors.green,
                        shape: BoxShape.circle),
                  ),
                  Text(account.isBanned ? 'Đã khóa' : 'Đang hoạt động'),
                ],
              ),
              TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, RouteNames.accountDetail,
                        arguments:
                            AccountDetailArguments(userId: account.userId));
                  },
                  child: const Text(
                    'Xem chi tiết',
                  ))
            ]),
        actionsAlignment: MainAxisAlignment.spaceBetween,
        actions: <Widget>[
          ElevatedButton(
              style: const ButtonStyle(
                  padding: MaterialStatePropertyAll(
                      EdgeInsets.symmetric(horizontal: 28, vertical: 16))),
              onPressed: () {
                Navigator.pop(context);
                _dialogBanUserBuilder(context, account);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(account.isBanned
                      ? Icons.lock_open_rounded
                      : Icons.lock_outline_rounded),
                  const SizedBox(
                    width: 3,
                  ),
                  Text(account.isBanned ? 'Mở khóa' : 'Khóa'),
                ],
              )),
          ElevatedButton(
              style: ButtonStyle(
                  padding: const MaterialStatePropertyAll(
                      EdgeInsets.symmetric(horizontal: 28, vertical: 16)),
                  backgroundColor:
                      MaterialStatePropertyAll(Colors.red.shade500)),
              onPressed: () {
                Navigator.pop(context);
                _dialogDeleteUserBuilder(context, account);
              },
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.delete,
                    size: 28,
                  ),
                  SizedBox(
                    width: 3,
                  ),
                  Text(
                    'Xóa',
                  ),
                ],
              )),
        ],
      ),
    );
  }

  Future<void> _dialogBanUserBuilder(
      BuildContext context, AccountEntity accountEntity) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        final TextEditingController reasonController = TextEditingController();
        return AlertDialog(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          shadowColor: Colors.white,
          title: Text(
            'Khóa/Mở khóa tài khoản',
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
              onPressed: Provider.of<UserProvider>(context, listen: true)
                      .isLoading
                  ? null
                  : () async {
                      await Provider.of<UserProvider>(context, listen: false)
                          .eitherFailureOrToggleBanUsr(
                              accountEntity.userId, reasonController.text);
                      Navigator.of(context).pop();

                      if (Provider.of<UserProvider>(context, listen: false)
                              .statusCode ==
                          200) {
                        // setState(() {
                        //   accountEntity.isBanned = !accountEntity.isBanned;
                        // });
                        _pagingController.refresh();
                      }
                    },
              child: const Text('Đồng ý'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _dialogDeleteUserBuilder(
      BuildContext context, AccountEntity accountEntity) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          shadowColor: Colors.white,
          title: Text(
            'Bạn có chắc chắn?',
            style: Theme.of(context).textTheme.titleMedium!.copyWith(),
          ),
          // content: const Text(
          //   'A dialog is a type of modal window that\n'
          //   'appears in front of app content to\n'
          //   'provide critical information, or prompt\n'
          //   'for a decision to be made.',
          // ),
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
              onPressed: Provider.of<UserProvider>(context, listen: true)
                      .isLoading
                  ? null
                  : () async {
                      await Provider.of<UserProvider>(context, listen: false)
                          .eitherFailureOrDelUser(accountEntity.userId);

                      Navigator.of(context).pop();
                      if (Provider.of<UserProvider>(context, listen: false)
                              .statusCode ==
                          200) {
                        setState(() {
                          _pagingController.itemList!.remove(accountEntity);
                        });
                      }
                    },
              child: const Text('Đồng ý'),
            ),
          ],
        );
      },
    );
  }
}

class ContriHistoryArguments {
  UserEntity? user;
  int? userId;
  // List<ContributionEntity> contributions = [];

  ContriHistoryArguments({this.user, this.userId});
}

class AccountDetailArguments {
  int userId;

  AccountDetailArguments({required this.userId});
}
