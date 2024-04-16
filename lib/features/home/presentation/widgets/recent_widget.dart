import 'package:ctue_app/core/constants/constants.dart';

import 'package:ctue_app/features/home/presentation/providers/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecentPagesWidget extends StatelessWidget {
  RecentPagesWidget({Key? key}) : super(key: key);

  final List<Recommend> _listRecommends = [
    Recommend(path: '/contribution', title: 'Đóng góp từ vựng'),
    Recommend(path: '/setting', title: 'Cài đặt giọng đọc'),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, provider, child) {
        if (provider.recentPages.isEmpty) {
          return ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return ListTile(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  leading: Icon(
                    Icons.recommend,
                    size: 35,
                    color: Colors.yellow.shade700,
                  ),
                  title: Text(
                    _listRecommends[index].title,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, _listRecommends[index].path);
                  },
                  trailing: const Icon(
                    Icons.chevron_right_rounded,
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(
                  height: 2,
                );
              },
              itemCount: _listRecommends.length);
        } else if (provider.recentPages.isNotEmpty) {
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: provider.recentPages.length,
            itemBuilder: (context, index) {
              final url = provider.recentPages[index];
              return ListTile(
                leading: Icon(
                  Icons.history,
                  size: 25,
                  color: Colors.blue.shade700,
                ),
                title: Text(
                  getRouteName(url),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                trailing: const Icon(Icons.chevron_right_rounded),
                onTap: () {
                  // Navigate to the corresponding page
                  Navigator.pushNamed(context, url);
                },
              );
            },
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}

class Recommend {
  final String title;
  final String path;

  Recommend({required this.path, required this.title});
}
