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

  bool isDark = false;

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
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(color: Colors.grey.shade100),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Từ điển',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      SizedBox(
                        height: 45,
                        child: SearchAnchor(
                            viewElevation: 8,
                            dividerColor: Colors.teal,
                            viewBackgroundColor: Colors.white,
                            viewHintText: 'Tra từ điển',
                            headerHintStyle:
                                const TextStyle(color: Colors.grey),
                            viewShape: const ContinuousRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              side: BorderSide(color: Colors.grey),
                            ),
                            builder: (BuildContext context,
                                SearchController controller) {
                              return SearchBar(
                                hintText: 'Tra từ điển',
                                hintStyle:
                                    const MaterialStatePropertyAll<TextStyle>(
                                        TextStyle(
                                            color: Colors.grey,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600)),
                                elevation: const MaterialStatePropertyAll(0),
                                backgroundColor: MaterialStatePropertyAll(
                                    Colors.grey.shade100),
                                controller: controller,
                                padding:
                                    const MaterialStatePropertyAll<EdgeInsets>(
                                        EdgeInsets.symmetric(
                                            horizontal: 12.0, vertical: 2)),
                                onTap: () {
                                  controller.openView();
                                },
                                onChanged: (_) {
                                  controller.openView();
                                },
                                leading: Icon(
                                  Icons.search,
                                  size: 28,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                trailing: <Widget>[
                                  IconButton(
                                    icon: const Icon(Icons.keyboard_voice),
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    onPressed: () {
                                      print('Use voice command');
                                    },
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.camera_alt),
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    onPressed: () {
                                      print('Use image search');
                                    },
                                  ),
                                ],
                              );
                            },
                            suggestionsBuilder: (BuildContext context,
                                SearchController controller) {
                              return List<ListTile>.generate(5, (int index) {
                                final String item = 'item $index';
                                return ListTile(
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 4),
                                  title: Text(item),
                                  onTap: () {
                                    // setState(() {
                                    //   controller.closeView(item);
                                    // });
                                  },
                                  trailing: IconButton(
                                    icon: Icon(Icons.history),
                                    onPressed: () {},
                                  ),
                                );
                              });
                            }),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),

                // Text(
                //   'Đề xuất cho bạn',
                //   style: Theme.of(context).textTheme.titleLarge,
                // ),
                // SizedBox(
                //   height: 90.0, // Set a fixed height for the ListView
                //   child: ListView.builder(
                //     scrollDirection: Axis.horizontal,
                //     itemCount: 1, // Number of items in your list
                //     itemBuilder: (BuildContext context, int index) {
                //       return Padding(
                //         padding: const EdgeInsets.all(8.0),
                //         child: Column(
                //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //           children: [
                //             ClipRRect(
                //               borderRadius: BorderRadius.circular(10),
                //               child: Image.asset(
                //                 'assets/images/chatbot.png',
                //                 height: 52,
                //                 width: 52,
                //               ),
                //             ),
                //             Text(
                //               'CTUE AI',
                //               style: Theme.of(context).textTheme.bodyMedium,
                //             )
                //           ],
                //         ),
                //       );
                //     },
                //   ),
                // ),

                Container(
                    padding: const EdgeInsets.all(8),
                    color: Colors.white,
                    child: Container(
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.blue.shade50,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                              flex: 3,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Đã đến lúc ôn tập',
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                  Text(
                                    '3 từ',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(color: Colors.red),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  ElevatedButton(
                                      onPressed: () {},
                                      child: const Text('Ôn tập ngay'))
                                ],
                              )),
                          Expanded(
                              flex: 1,
                              child: SizedBox(
                                  height: 100,
                                  width: 100,
                                  child: Image.asset(
                                    'assets/images/note.png',
                                    fit: BoxFit.fill,
                                  )))
                        ],
                      ),
                    )),

                const SizedBox(
                  height: 8,
                ),

                Container(
                    height: 480,
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(color: Colors.white),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Nguồn học',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Expanded(
                          child: ListView.separated(
                            physics: const NeverScrollableScrollPhysics(),
                            separatorBuilder: (context, index) =>
                                const SizedBox(
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
                      ],
                    ))
              ]),
        ),
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
