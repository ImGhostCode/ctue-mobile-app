import 'package:ctue_app/features/notification/presentation/widgets/notification_icon.dart';
import 'package:flutter/material.dart';

class ManagementPage extends StatelessWidget {
  const ManagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        // centerTitle: true,
        title: Image.asset(
            'assets/images/ctue-high-resolution-logo-transparent2.png',
            width: 150),

        actions: const [
          NotificationIcon(),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: const ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll(Colors.indigoAccent)),
                  onPressed: () {
                    Navigator.pushNamed(context, '/admin-overview');
                  },
                  child: const Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.dashboard,
                          size: 70,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Thống kê tổng quan',
                          textAlign: TextAlign.center,
                        )
                      ]),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                primary: false,
                // padding: const EdgeInsets.all(16),
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                crossAxisCount: 2,
                children: <Widget>[
                  ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(
                            Colors.lightBlue.shade800)),
                    onPressed: () {
                      Navigator.pushNamed(context, '/acc-management');
                    },
                    child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.manage_accounts,
                            size: 70,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Quản lý tài khoản người dùng',
                            textAlign: TextAlign.center,
                          )
                        ]),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(
                            Colors.yellowAccent.shade700)),
                    onPressed: () {
                      Navigator.pushNamed(context, '/dict-management');
                    },
                    child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.menu_book,
                            size: 70,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Quản lý từ điển',
                            textAlign: TextAlign.center,
                          )
                        ]),
                  ),
                  ElevatedButton(
                    style: const ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.green)),
                    onPressed: () {
                      Navigator.pushNamed(context, '/contri-management');
                    },
                    child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.extension,
                            size: 70,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Quản lý đóng góp',
                            textAlign: TextAlign.center,
                          )
                        ]),
                  ),
                  ElevatedButton(
                    style: const ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.blueAccent)),
                    onPressed: () {
                      Navigator.pushNamed(context, '/sen-management');
                    },
                    child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.record_voice_over_outlined,
                            size: 70,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Quản lý câu tiếng Anh',
                            textAlign: TextAlign.center,
                          )
                        ]),
                  ),
                  ElevatedButton(
                    style: const ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.orange)),
                    onPressed: () {
                      Navigator.pushNamed(context, '/irr-verb-management');
                    },
                    child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.article,
                            size: 70,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Quản lý động từ bất quy tắc',
                            textAlign: TextAlign.center,
                          )
                        ]),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.teal.shade400)),
                    onPressed: () {
                      Navigator.pushNamed(context, '/voca-set-management');
                    },
                    child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.book,
                            size: 70,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Quản lý gói từ vựng',
                            textAlign: TextAlign.center,
                          )
                        ]),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
