import 'package:ctue_app/features/contribute/presentation/providers/contribution_provider.dart';
import 'package:ctue_app/features/contribute/presentation/widgets/sen_con_form.dart';
import 'package:ctue_app/features/contribute/presentation/widgets/word_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ContributePage extends StatelessWidget {
  const ContributePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        initialIndex: 0,
        length: 2,
        child: Scaffold(
          appBar: AppBar(
              backgroundColor: Colors.white,
              scrolledUnderElevation: 0,
              toolbarHeight: 50,
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
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          Text(
                            'Đóng góp cùng CTUE',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          Text(
                            'CTUE rất mong được sự đóng góp của bạn. Bạn có thể thêm từ mới, sửa lỗi sai',
                            style: Theme.of(context).textTheme.bodySmall,
                          )
                        ],
                      ),
                    ),
                    Expanded(
                        flex: 1,
                        child: Image.asset(
                          'assets/images/icons/contribution.png',
                          height: 100,
                          width: 100,
                        ))
                  ],
                ),
                const TabBar(
                  indicatorSize: TabBarIndicatorSize.tab,
                  // isScrollable: false,
                  tabs: <Widget>[
                    Tab(
                      text: 'Đóng góp từ',
                    ),
                    Tab(
                      text: "Đóng góp câu",
                    ),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: <Widget>[
                      WordForm(
                        titleBtnSubmit: 'Gửi đóng góp',
                        isLoading: Provider.of<ContributionProvider>(context,
                                listen: true)
                            .isLoading,
                        callback: (data) async {
                          await Provider.of<ContributionProvider>(context,
                                  listen: false)
                              .eitherFailureOrCreWordCon(
                                  data.elementAt(0), data.elementAt(1));

                          if (Provider.of<ContributionProvider>(context,
                                      listen: false)
                                  .contributionEntity !=
                              null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                duration: const Duration(seconds: 1),
                                content: Text(
                                  Provider.of<ContributionProvider>(context,
                                          listen: false)
                                      .message!,
                                  style: const TextStyle(color: Colors.white),
                                ),
                                backgroundColor:
                                    Colors.green, // You can customize the color
                              ),
                            );
                          } else if (Provider.of<ContributionProvider>(context,
                                      listen: false)
                                  .failure !=
                              null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                duration: const Duration(seconds: 1),
                                content: Text(
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
                          Navigator.of(context).pop();
                        },
                      ),
                      SenConForm(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
