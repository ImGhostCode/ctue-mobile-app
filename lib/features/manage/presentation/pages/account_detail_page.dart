import 'package:ctue_app/core/constants/constants.dart';
import 'package:ctue_app/core/errors/failure.dart';
import 'package:ctue_app/features/auth/business/entities/account_entiry.dart';
import 'package:ctue_app/features/manage/presentation/pages/acc_management_page.dart';
import 'package:ctue_app/features/user/presentation/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

class AccountDetailPage extends StatefulWidget {
  const AccountDetailPage({
    super.key,
  });

  @override
  State<AccountDetailPage> createState() => _AccountDetailPageState();
}

class _AccountDetailPageState extends State<AccountDetailPage> {
  @override
  void didChangeDependencies() {
    final args =
        ModalRoute.of(context)!.settings.arguments as AccountDetailArguments;
    Provider.of<UserProvider>(context, listen: false)
        .eitherFailureOrGetAccountDetail(args.userId);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.white,
            scrolledUnderElevation: 0,
            title: Text(
              'Thông tin tài khoản',
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
            child: Consumer<UserProvider>(builder: (context, userProvider, _) {
          AccountEntity? account = userProvider.accountEntity;

          bool isLoading = userProvider.isLoading;

          Failure? failure = userProvider.failure;

          if (failure != null) {
            // Handle failure, for example, show an error message
            return Text(failure.errorMessage);
          } else if (!isLoading && account == null) {
            // Handle the case where topics are empty
            return const Center(child: Text('Không có dữ liệu'));
          } else {
            return Skeletonizer(
              enabled: isLoading,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: ClipOval(
                        child: SizedBox(
                          height: 100,
                          width: 100,
                          child: account?.user!.avt != null
                              ? Image.network(
                                  account!.user!.avt!,
                                  fit: BoxFit.cover,
                                )
                              : Image.asset(
                                  'assets/images/default-user3.png',
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Text(
                          'Id: ',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        Text('${account?.user!.id}'),
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
                        Text(account?.user!.name ?? ''),
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
                        Text(account?.email ?? ''),
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
                            '${account?.user!.createdAt.day}/${account?.user!.createdAt.month}/${account?.user!.createdAt.year}'),
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
                              color: isLoading
                                  ? isLoadingColor
                                  : (account != null && account.isBan
                                      ? Colors.yellow
                                      : Colors.green),
                              shape: BoxShape.circle),
                        ),
                        Text(account != null
                            ? account.isBan
                                ? 'Đã khóa'
                                : 'Đang hoạt động'
                            : 'Đang tải dữ liệu'),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/contribution-history',
                              arguments:
                                  ContriHistoryArguments(user: account?.user));
                        },
                        child: const Text(
                          'Lịch sử đóng góp',
                        )),
                    TextButton(
                        onPressed: () {
                          // Navigator.pushNamed(
                          //     context, '/contribution-history',
                          //     arguments: ContriHistoryArguments(
                          //         user: account?.user));
                        },
                        child: const Text(
                          'Lịch sử học tập',
                        ))
                  ],
                ),
              ),
            );
          }
        })));
  }
}
