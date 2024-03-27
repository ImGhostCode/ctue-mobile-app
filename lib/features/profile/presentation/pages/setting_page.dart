import 'package:app_settings/app_settings.dart';
import 'package:ctue_app/core/services/secure_storage_service.dart';
import 'package:ctue_app/features/speech/presentation/pages/voice_setting_page.dart';
import 'package:ctue_app/features/skeleton/providers/selected_page_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';

class SettingPage extends StatefulWidget {
  SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  bool isRemind = true;
  TimeOfDay remindTime = TimeOfDay(hour: 21, minute: 00);

  @override
  Widget build(BuildContext context) {
    final List<Setting> _settings = [
      Setting(
          icon: Icons.person,
          title: 'Cập nhật thông tin',
          onTap: () {
            Navigator.pushNamed(context, '/user-info');
          }),
      // Setting(icon: Icons.vpn_key, title: 'Đổi mật khẩu', onTap: () {}),
      Setting(
          icon: Icons.notifications_rounded,
          title: 'Thông báo',
          onTap: () {
            AppSettings.openAppSettings(type: AppSettingsType.notification);
          }),
      Setting(
          icon: Icons.headphones,
          title: 'Giọng đọc',
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => VoiceSettingPage(),
              ),
            );
          }),
      // Setting(icon: Icons.timer, title: 'Nhắc nhở', onTap: () {}),
    ];

    return Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
          backgroundColor: Colors.grey.shade200,
          title: Text(
            'Cài đặt',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.navigate_before,
                size: 32,
              )),
        ),
        body: Column(
          children: [
            SizedBox(
              height: 190,
              child: ListView.separated(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      height: 10,
                    );
                  },
                  itemBuilder: (context, index) {
                    return ListTile(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      tileColor: Colors.white,
                      leading: Icon(_settings[index].icon),
                      title: Text(_settings[index].title),
                      onTap: _settings[index].onTap,
                    );
                  },
                  itemCount: _settings.length),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
                height: 120,
                child: ListView(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  children: [
                    ListTile(
                      tileColor: Colors.white,
                      leading: const Icon(Icons.timer),
                      title: const Text('Nhắc nhở'),
                      trailing: Switch(
                        // This bool value toggles the switch.
                        value: isRemind,
                        activeColor: Colors.blue,
                        onChanged: (bool value) {
                          // This is called when the user toggles the switch.
                          setState(() {
                            isRemind = value;
                          });
                        },
                      ),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12))),
                    ),
                    ListTile(
                      tileColor: Colors.white,
                      leading: null,
                      title: Text(
                        'Đặt giờ',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '21:00',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          const Icon(
                            Icons.chevron_right_rounded,
                            color: Colors.grey,
                            size: 30,
                          )
                        ],
                      ),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(12),
                              bottomRight: Radius.circular(12))),
                      onTap: () async {
                        TimeOfDay? selectedTime24Hour = await showTimePicker(
                          context: context,
                          initialTime: const TimeOfDay(hour: 21, minute: 00),
                          builder: (BuildContext context, Widget? child) {
                            return Theme(
                              data: ThemeData.light(),
                              child: MediaQuery(
                                data: MediaQuery.of(context)
                                    .copyWith(alwaysUse24HourFormat: true),
                                child: child!,
                              ),
                            );
                          },
                        );
                        if (selectedTime24Hour != null) {
                          setState(() {
                            remindTime = selectedTime24Hour;
                          });
                        }
                      },
                    ),
                  ],
                )),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    'Phiên bản ứng dụng 1.0.0',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    // height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                const MaterialStatePropertyAll(Colors.red),
                            shape: MaterialStatePropertyAll(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)))),
                        onPressed: () async {
                          await SecureStorageService.secureStorage
                              .delete(key: 'accessToken');
                          // ignore: use_build_context_synchronously
                          Provider.of<SelectedPageProvider>(context,
                                  listen: false)
                              .selectedPage = 0;
                          // ignore: use_build_context_synchronously
                          Navigator.pushNamedAndRemoveUntil(
                              context, '/welcome', (route) => false);
                        },
                        child: Text(
                          'Đăng xuất',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                        )),
                  )
                ],
              ),
            )
          ],
        ));
  }
}

class Setting {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  Setting({required this.icon, required this.title, required this.onTap});
}
