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

        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/notification');
              },
              icon: const Icon(
                Icons.notifications,
                color: Colors.white,
                size: 28,
              ))
        ],
      ),
      body: GridView.count(
        primary: false,
        padding: const EdgeInsets.all(16),
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
        crossAxisCount: 2,
        children: <Widget>[
          ElevatedButton(
            style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.teal)),
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
            style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.green)),
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
                backgroundColor: MaterialStatePropertyAll(Colors.yellowAccent)),
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
                backgroundColor: MaterialStatePropertyAll(Colors.blue)),
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
            style: ButtonStyle(
                backgroundColor:
                    MaterialStatePropertyAll(Colors.yellow.shade800)),
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
                    'Quản lý động từ bất quy tắt',
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
                    'Quản lý bộ từ vựng',
                    textAlign: TextAlign.center,
                  )
                ]),
          ),
        ],
      ),
    );
  }
}
