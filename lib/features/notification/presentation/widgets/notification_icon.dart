import 'package:ctue_app/features/notification/presentation/providers/notification_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotificationIcon extends StatelessWidget {
  final Color? color;
  const NotificationIcon({super.key, this.color});

  @override
  Widget build(BuildContext context) {
    // return NotificationListener<MyNotification>(
    //   onNotification: (notification) {
    //     // Hiển thị thông báo
    //     return true;
    //   },
    //   child:
    bool hasNewNofi =
        Provider.of<NotificationProvider>(context, listen: true).hasNewNoti;

    // return Builder(
    // builder: (context) {
    // Lấy số lượng thông báo
    return hasNewNofi
        ? Stack(
            children: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.notifications,
                  color: color ?? Colors.white,
                  size: 30,
                ),
                onPressed: () {
                  Provider.of<NotificationProvider>(context, listen: false)
                      .hasNewNoti = false;
                  Navigator.pushNamed(context, '/notification');
                },
              ),
              Positioned(
                top: 8.0,
                right: 8.0,
                child: Container(
                  height: 10,
                  width: 10,
                  decoration: const BoxDecoration(
                      color: Colors.red, shape: BoxShape.circle),
                ),
              ),
            ],
          )
        : IconButton(
            icon: const Icon(
              Icons.notifications,
              color: Colors.white,
              size: 30,
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/notification');
            },
          );
  }

  // );
}

class MyNotification extends Notification {
  const MyNotification();
}
