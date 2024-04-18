import 'package:ctue_app/core/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class WelcomePage extends StatefulWidget {
  WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage>
    with TickerProviderStateMixin {
  late final TabController _tabController;
  int currTab = 0;

  void _printTabIndex() {
    setState(() {
      currTab = _tabController.index;
    });
  }

  @override
  void initState() {
    super.initState();
    _requestPermission();
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(_printTabIndex);
  }

  void _requestPermission() async {
    var status = await Permission.notification.status;
    var alarmStatus = await Permission.scheduleExactAlarm.status;

    if (status.isPermanentlyDenied) {
      return;
    }
    if (status.isDenied) {
      await Permission.notification.request();
    }

    if (alarmStatus.isPermanentlyDenied) {
      return;
    }
    if (alarmStatus.isDenied) {
      await Permission.scheduleExactAlarm.request();
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 4,
      child: Scaffold(
        backgroundColor: Colors.blue.shade700,
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: <Widget>[
                    Center(
                      child: SizedBox(
                        height: 400,
                        width: double.infinity,
                        child: Image.asset(
                          'assets/images/ctue-high-resolution-logo-transparent2.png',
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 300,
                          width: 300,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: Colors.white),
                          child: ClipOval(
                            child: SizedBox(
                              height: 300,
                              width: 300,
                              child: Image.asset(
                                'assets/images/learning-tools.png',
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 100,
                        ),
                        Text(
                          textAlign: TextAlign.center,
                          'Từ điển, mẫu câu giao tiếp, động từ bất quy tắc',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(color: Colors.white),
                        ),
                        Text(
                          textAlign: TextAlign.center,
                          'Tất cả các nguồn tài nguyên khác nhau phù hợp để bạn tham khảo. Cải thiện kỹ năng nghe và nói của bạn trong khi thưởng thức nội dung.',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(color: Colors.white),
                        ),
                      ],
                    ),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 300,
                          width: 300,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: Colors.white),
                          child: ClipOval(
                            child: SizedBox(
                              height: 300,
                              width: 300,
                              child: Image.asset(
                                'assets/images/data-graph.png',
                                fit: BoxFit.contain,
                                // scale: 0.4,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 100,
                        ),
                        Text(
                          textAlign: TextAlign.center,
                          'Học từ vựng',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(color: Colors.white),
                        ),
                        Text(
                          textAlign: TextAlign.center,
                          'Học ít - Nhớ nhiều từ mới bằng phương pháp khoa học - Spaced Repetition.',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(color: Colors.white),
                        ),
                      ],
                    ),
                    //https://www.clari.com/globalassets/blog/meta--what-is-word-error-rate-in-automatic-speech-recognition.jpg
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 300,
                          width: 300,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: Colors.white),
                          child: ClipOval(
                            child: SizedBox(
                              height: 300,
                              width: 300,
                              child: Image.asset(
                                'assets/images/pronunc-assessmennt.png',
                                fit: BoxFit.contain,
                                // scale: 0.4,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 100,
                        ),
                        Text(
                          textAlign: TextAlign.center,
                          'Đánh giá phát âm',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(color: Colors.white),
                        ),
                        Text(
                          textAlign: TextAlign.center,
                          'Giúp cải thiện kỹ năng Speaking của bạn. Nhanh chóng và chính xác.',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      height: 10,
                      width: 10,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: currTab == 0
                              ? Colors.teal
                              : Colors.grey.shade300)),
                  Container(
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      height: 10,
                      width: 10,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: currTab == 1
                              ? Colors.teal
                              : Colors.grey.shade300)),
                  Container(
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      height: 10,
                      width: 10,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: currTab == 2
                              ? Colors.teal
                              : Colors.grey.shade300)),
                  Container(
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      height: 10,
                      width: 10,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: currTab == 3
                              ? Colors.teal
                              : Colors.grey.shade300)),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    Navigator.of(context).pushNamed(RouteNames.login);
                  },
                  child: Text(
                    'Bắt đầu ngay',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

 // SizedBox(
            //   height: 400,
            //   width: double.infinity,
            //   child: Image.asset(
            //     'assets/images/ctue-high-resolution-logo-transparent2.png',
            //   ),
            // ),

  // const Spacer(),
            // SizedBox(
            //   width: double.infinity,
            //   child: ElevatedButton(
            //     onPressed: () async {
            //       Navigator.of(context).pushNamed('/login');
            //     },
            //     child: Text(
            //       'Bắt đầu ngay',
            //       style: Theme.of(context)
            //           .textTheme
            //           .bodyMedium!
            //           .copyWith(color: Colors.white),
            //     ),
            //   ),
            // ),