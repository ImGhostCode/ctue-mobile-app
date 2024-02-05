import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Thông báo',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          backgroundColor: Colors.white,
          elevation: 2,
          shadowColor: Colors.black,
        ),
        body: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            itemBuilder: (context, index) {
              return const SizedBox(
                height: 5,
              );
            },
            separatorBuilder: (context, index) {
              return GestureDetector(
                onTap: () {},
                child: ListTile(
                  shape: RoundedRectangleBorder(
                      side: const BorderSide(color: Colors.blue),
                      borderRadius: BorderRadius.circular(12)),
                  tileColor: Colors.grey.shade100,
                  leading: FittedBox(
                    child: CircleAvatar(
                        radius: 25.0, // Set the radius of the circle
                        backgroundColor: Colors
                            .blue, // Set the background color of the circle
                        child: ClipOval(
                          child: Image.network(
                            'https://logowik.com/content/uploads/images/flutter5786.jpg',
                            height: 60,
                            width: 60,
                            fit: BoxFit.cover,
                          ),
                        )),
                  ),
                  title: Text('Đóng góp của bạn đã được chấp nhận'),
                  subtitle: Text(
                    '14/1/2024',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  trailing: const Icon(Icons.chevron_right_rounded),
                ),
              );
            },
            itemCount: 5));
  }
}
