import 'package:ctue_app/features/notification/presentation/providers/notification_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotificationIcon extends StatelessWidget {
  const NotificationIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return NotificationListener<MyNotification>(
      onNotification: (notification) {
        // Hiển thị thông báo
        return true;
      },
      child: Builder(
        builder: (context) {
          bool hasNewNofi =
              Provider.of<NotificationProvider>(context, listen: true)
                  .hasNewNofi;
          // Lấy số lượng thông báo
          if (hasNewNofi) {
            return Stack(
              children: <Widget>[
                IconButton(
                  icon: const Icon(
                    Icons.notifications,
                    color: Colors.white,
                    size: 30,
                  ),
                  onPressed: () {
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
            );
          } else {
            return IconButton(
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
        },
      ),
    );
  }
}

class MyNotification extends Notification {
  const MyNotification();
}
