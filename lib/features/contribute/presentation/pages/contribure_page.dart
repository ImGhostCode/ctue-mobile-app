import 'package:ctue_app/features/contribute/presentation/widgets/voca_con_form.dart';
import 'package:flutter/material.dart';

class ContributePage extends StatelessWidget {
  const ContributePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        initialIndex: 0,
        length: 2,
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(8.0),
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
                            style: Theme.of(context).textTheme.displaySmall,
                          ),
                          Text(
                            'CTUE rất mong được sự đóng góp của bạn. Bạn có thể thêm từ mới, sửa lỗi sai',
                            style: Theme.of(context).textTheme.bodyMedium,
                          )
                        ],
                      ),
                    ),
                    Expanded(
                        flex: 1,
                        child: Image.asset(
                          'assets/images/icons/contribution.png',
                          height: 150,
                          width: 150,
                        ))
                  ],
                ),
                const TabBar(
                  indicatorSize: TabBarIndicatorSize.tab,
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
                      Center(
                        child: VocaConForm(),
                      ),
                      Center(
                        child: Text("It's rainy here"),
                      ),
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
