import 'package:ctue_app/features/contribute/presentation/widgets/MyFeatureListTile.dart';
import 'package:flutter/material.dart';

class GamePage extends StatelessWidget {
  GamePage({super.key});

  final List<GameType> gametypes = [
    GameType(
        name: 'Hãy chọn từ đúng',
        imagePath: 'assets/images/icons/games/correct-word.png',
        route: '/correct-word'),
    GameType(
        name: 'Ghép từ',
        imagePath: 'assets/images/icons/games/word-match.png',
        route: '/word-match')
  ];

  final List<Feature> features = [
    Feature(
        imagePath: 'assets/images/icons/favorite.png',
        title: 'Từ vựng yêu thích của bạn',
        subtitle: 'Danh sách những từ vựng yêu thích mà bạn đã lưu',
        onTap: () {}),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text("Trò chơi"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          // color: Colors.blueGrey.shade50,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 200,
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.centerRight,
                          colors: <Color>[
                            Color.fromRGBO(7, 181, 194, 1),
                            Color.fromRGBO(25, 228, 180, 1)
                          ]),
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.tealAccent.shade700),
                  child: Row(children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        'Ôn luyện kiến thức hiệu quả và đỡ nhàm chán hơn qua việc chơi game cùng CTUE nhé',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                            fontSize: 16),
                      ),
                    ),
                    Expanded(
                        flex: 1,
                        child: Image.asset(
                          'assets/images/icons/game.png',
                          height: 80,
                          width: 80,
                          fit: BoxFit.contain,
                        ))
                  ]),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Đề xuất cho bạn',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  // Adding a Container to provide constraints
                  height:
                      170, // You can adjust these values based on your design
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: const EdgeInsets.all(8),
                        width: 140,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.tealAccent.shade400, width: 1.8),
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white),
                        child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                                context, gametypes[index].route);
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    width: double.infinity,
                                    height: 100,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: Colors.yellow.shade100),
                                  ),
                                  SizedBox(
                                    height: 70,
                                    width: 70,
                                    child: Image.asset(
                                      gametypes[index].imagePath,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                gametypes[index].name,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        width: 8,
                      );
                    },
                    itemCount: gametypes.length,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                // Text(
                //   'Thư viên kỹ năng',
                //   style: Theme.of(context).textTheme.titleLarge,
                // ),
                // const SizedBox(
                //   height: 10,
                // ),
                // SizedBox(
                //   height: 80,
                //   child: ListView.separated(
                //     padding: EdgeInsets.zero,
                //     physics: const NeverScrollableScrollPhysics(),
                //     separatorBuilder: (context, index) => const SizedBox(
                //       height: 5,
                //     ),
                //     itemCount: features.length,
                //     itemBuilder: (context, index) => MyFeatureListTile(
                //         imagePath: features[index].imagePath,
                //         title: features[index].title,
                //         subtitle: features[index].subtitle,
                //         onTap: features[index].onTap),
                //   ),
                // ),
                // const SizedBox(
                //   height: 10,
                // ),
                // Text(
                //   'Thư viên kỹ năng',
                //   style: Theme.of(context).textTheme.titleLarge,
                // ),
                // const SizedBox(
                //   height: 10,
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class GameType {
  String imagePath;
  String name;
  String route;

  GameType({required this.name, required this.imagePath, required this.route});
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
