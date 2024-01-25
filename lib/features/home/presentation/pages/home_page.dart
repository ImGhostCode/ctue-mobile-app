import 'package:ctue_app/features/home/presentation/widgets/MyFeatureListTile.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final List<Feature> features = [
    Feature(
        imagePath: 'assets/images/icons/ipa.png',
        title: 'Bảng phiên âm IPA',
        subtitle:
            'Luyện nghe, phát âm chuẩn với 44 âm trong bảng phiên âm quốc tế IPA',
        onTap: () {}),
    Feature(
        imagePath: 'assets/images/icons/communicate.png',
        title: 'Mẫu câu giao tiếp',
        subtitle: 'Luyện nghe, nói câu giao tiếp tiếng Anh hăng ngày cùng CTUE',
        onTap: () {}),
    Feature(
        imagePath: 'assets/images/icons/dictionary.png',
        title: 'Từ điển trong CTUE',
        subtitle: 'Danh sách từ vựng được phân loại theo cấp độ, loại từ,...',
        onTap: () {}),
    Feature(
        imagePath: 'assets/images/icons/favorite.png',
        title: 'Từ vựng yêu thích của bạn',
        subtitle: 'Danh sách những từ vựng yêu thích mà bạn đã lưu',
        onTap: () {}),
    Feature(
        imagePath: 'assets/images/icons/verb.png',
        title: 'Động từ bất quy tắc',
        subtitle: 'Tất cả những độgn từ bất quy tắc trong tiếng Anh',
        onTap: () {}),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // centerTitle: true,
        title: Image.asset(
            'assets/images/ctue-high-resolution-logo-transparent2.png',
            width: 150),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.notifications,
                color: Colors.white,
                size: 28,
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  text: 'Welcome back,\n',
                  style: Theme.of(context).textTheme.bodyMedium,
                  children: <TextSpan>[
                    TextSpan(
                        text: 'Liem',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.teal,
                            )),
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                'Đề xuất cho bạn',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(
                height: 90.0, // Set a fixed height for the ListView
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 1, // Number of items in your list
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              'assets/images/chatbot.png',
                              height: 52,
                              width: 52,
                            ),
                          ),
                          Text(
                            'CTUE AI',
                            style: Theme.of(context).textTheme.bodyMedium,
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
              Text(
                'Công cụ và tính năng',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: ListView.separated(
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 5,
                  ),
                  itemCount: features.length,
                  itemBuilder: (context, index) => MyFeatureListTile(
                      imagePath: features[index].imagePath,
                      title: features[index].title,
                      subtitle: features[index].subtitle,
                      onTap: features[index].onTap),
                ),
              )
            ]),
      ),
    );
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
