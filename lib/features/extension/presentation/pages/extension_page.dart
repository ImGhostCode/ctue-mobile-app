import 'package:ctue_app/features/contribute/presentation/widgets/MyFeatureListTile.dart';
import 'package:ctue_app/features/notification/presentation/widgets/notification_icon.dart';
import 'package:flutter/material.dart';

class ExtentionPage extends StatelessWidget {
  ExtentionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Feature> features = [
      Feature(
          imagePath: 'assets/images/icons/edit.png',
          title: 'Đóng góp',
          subtitle: 'CTUE rất mong được sự đóng góp của bạn.',
          onTap: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => const ContributePage()),
            // );
            Navigator.pushNamed(context, '/contribution');
          }),
      Feature(
          imagePath: 'assets/images/icons/favorite.png',
          title: 'Từ vựng yêu thích của bạn',
          subtitle: 'Danh sách những từ vựng yêu thích mà bạn đã lưu',
          onTap: () {
            Navigator.pushNamed(context, '/favorite-vocabulary');
          }),
      Feature(
          imagePath: 'assets/images/icons/speech-icon.png',
          title: 'Cải thiện phát âm',
          subtitle: 'Nâng cao trình độ nói tiếng Anh của bạn',
          onTap: () {
            Navigator.pushNamed(context, '/improve-pronunciation');
          }),
    ];

    return Scaffold(
        appBar: AppBar(
          // centerTitle: true,
          title: Image.asset(
              'assets/images/ctue-high-resolution-logo-transparent2.png',
              width: 150),
          actions: const [NotificationIcon()],
        ),
        body: SingleChildScrollView(
            child: Container(
                padding: const EdgeInsets.all(16),
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(color: Colors.grey.shade100),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Đề xuất cho bạn',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      SizedBox(
                        height: 100.0, // Set a fixed height for the ListView
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 1, // Number of items in your list
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.asset(
                                      'assets/images/chatbot.png',
                                      height: 60,
                                      width: 60,
                                    ),
                                  ),
                                  Text(
                                    'CTUE AI',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(fontWeight: FontWeight.w600),
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      Text(
                        'Công cụ và tính năng',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Expanded(
                        child: ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          separatorBuilder: (context, index) => const SizedBox(
                            height: 0.5,
                          ),
                          itemCount: features.length,
                          itemBuilder: (context, index) => Card(
                            color:
                                Colors.green, // Set the background color here
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: MyFeatureListTile(
                              imagePath: features[index].imagePath,
                              title: features[index].title,
                              subtitle: features[index].subtitle,
                              onTap: features[index].onTap,
                            ),
                          ),
                        ),
                      )
                    ]))));
  }
}

class Feature {
  final String imagePath;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  Feature({
    required this.imagePath,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });
}
