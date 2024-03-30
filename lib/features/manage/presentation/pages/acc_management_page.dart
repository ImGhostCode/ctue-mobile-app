import 'package:ctue_app/core/errors/failure.dart';
import 'package:ctue_app/features/auth/business/entities/account_entiry.dart';
import 'package:ctue_app/features/user/presentation/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccountManagementPage extends StatefulWidget {
  const AccountManagementPage({super.key});

  @override
  State<AccountManagementPage> createState() => _AccountManagementPageState();
}

enum SampleItem { itemOne, itemTwo, itemThree }

class _AccountManagementPageState extends State<AccountManagementPage> {
  bool isActive = true;
  SampleItem? selectedItem;

  @override
  void initState() {
    Provider.of<UserProvider>(context, listen: false)
        .eitherFailureOrGetAllUser(1);
    super.initState();
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            SizedBox(
                height: 45,
                child: SearchBar(
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
            Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              // Text(
              //   'Trạng thái: ',
              //   style: Theme.of(context)
              //       .textTheme
              //       .bodySmall!
              //       .copyWith(color: Colors.blue),
              // ),
              Text(
                isActive ? 'Đang hoạt động' : 'Đã khóa',
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: Colors.blue, fontWeight: FontWeight.bold),
              ),
              PopupMenuButton<bool>(
                icon: const Icon(Icons.sort),
                onSelected: (value) {
                  setState(() {
                    isActive = value;
                  });
                },
                color: Colors.white,
                itemBuilder: (BuildContext context) => <PopupMenuEntry<bool>>[
                  const PopupMenuItem<bool>(
                    value: true,
                    child: Text('Đang hoạt động'),
                  ),
                  const PopupMenuItem<bool>(
                    value: false,
                    child: Text('Đã khóa'),
                  ),
                  // Add more items if needed
                ],
              ),
            ]),
            const SizedBox(
              height: 10,
            ),
            Consumer<UserProvider>(builder: (context, provider, child) {
              List<AccountEntity> listAccounts = provider.accounts
                  .where((element) => element.isBan == !isActive)
                  .toList();

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
              } else if (listAccounts.isEmpty) {
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
                              showUserDetail(context, listAccounts[index]),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 8),
                          leading: ClipOval(
                            child: SizedBox(
                              height: 50,
                              width: 50,
                              child: listAccounts[index].user!.avt != null
                                  ? Image.network(
                                      listAccounts[index].user!.avt!,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.asset(
                                      'assets/images/default-user3.png',
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          ),
                          title: Text(listAccounts[index].user!.name),
                          subtitle: Text(listAccounts[index].email),
                          trailing: Container(
                            height: 10,
                            width: 10,
                            decoration: BoxDecoration(
                                color: listAccounts[index].isBan
                                    ? Colors.yellow
                                    : Colors.green,
                                shape: BoxShape.circle),
                          ));
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox();
                    },
                    itemCount: listAccounts.length);
              }
            })
          ]),
        ),
      ),
    );
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
                children: [
                  Text(
                    'Tên người dùng: ',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  Text(account.user!.name),
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
                        color: account.isBan ? Colors.yellow : Colors.green,
                        shape: BoxShape.circle),
                  ),
                  Text(account.isBan ? 'Đã khóa' : 'Đang hoạt động'),
                ],
              ),
            ]),
        actionsAlignment: MainAxisAlignment.spaceBetween,
        actions: <Widget>[
          ElevatedButton(
              style: const ButtonStyle(
                  padding: MaterialStatePropertyAll(
                      EdgeInsets.symmetric(horizontal: 28, vertical: 16))),
              onPressed: () {},
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.lock_outline),
                  SizedBox(
                    width: 3,
                  ),
                  Text('Khóa'),
                ],
              )),
          ElevatedButton(
              style: ButtonStyle(
                  padding: const MaterialStatePropertyAll(
                      EdgeInsets.symmetric(horizontal: 28, vertical: 16)),
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
                    'Xóa',
                  ),
                ],
              ))
          // TextButton(
          //   onPressed: () => Navigator.pop(context, 'Cancel'),
          //   child: const Text('Cancel'),
          // ),
          // TextButton(
          //   onPressed: () => Navigator.pop(context, 'OK'),
          //   child: const Text('OK'),
          // ),
        ],
      ),
    );
  }
}
