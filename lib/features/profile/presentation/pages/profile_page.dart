import 'package:ctue_app/features/profile/presentation/widgets/colored_line.dart';
import 'package:ctue_app/features/profile/presentation/widgets/gradient_border_container.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class ProfilePage extends StatelessWidget {
  ProfilePage({Key? key}) : super(key: key);
  final double size = 30;
  final Color color = Colors.green;

  final List<PhonemeAssessment> _goodPhonemes = [
    PhonemeAssessment(phoneme: 'e', accuracy: 99),
    PhonemeAssessment(phoneme: 'i', accuracy: 94),
    PhonemeAssessment(phoneme: 'ɔː', accuracy: 90),
  ];
  final List<PhonemeAssessment> _needToImprovePhonemes = [
    PhonemeAssessment(phoneme: 'p', accuracy: 25),
    PhonemeAssessment(phoneme: 'w', accuracy: 43),
    PhonemeAssessment(phoneme: 's', accuracy: 50),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              // expandedHeight: 200,
              backgroundColor: Colors.transparent,
              floating: false,
              pinned: false,
              leading: CircleAvatar(
                backgroundColor: Colors.teal, // Set background color as needed
                radius: 30,
                // Set border properties
                // foregroundColor: Colors.teal, // Border color
                child: Stack(alignment: Alignment.center, children: [
                  ClipOval(
                    child: SizedBox(
                      height: 60,
                      width: 60,
                      child: Image.network(
                        'https://logowik.com/content/uploads/images/flutter5786.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const Positioned(
                      bottom: 2,
                      child: Icon(
                        Icons.camera_alt,
                      ))
                ]),
              ),
              title: const Text('Liem'),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.notifications_rounded,
                    color: Colors.grey.shade400,
                    size: 26,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.settings_rounded,
                    color: Colors.grey.shade400,
                    size: 26,
                  ),
                ),
              ],
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                // Your profile content goes here
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Bảng xếp hạng',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(15)),
                  height: 110,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: () {
                      // Handle onTap
                    },
                    child: Column(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  topRight: Radius.circular(15)),
                              // color: Colors.red,
                            ),
                            child: ListTile(
                                leading: SizedBox(
                                  height: 45,
                                  width: 45,
                                  child: Image.asset(
                                      'assets/images/icons/medal.png'),
                                ),
                                subtitle: Text(
                                  'Cùng xem thành tích của bạn bè và những người khác nhé',
                                  style: Theme.of(context).textTheme.bodySmall,
                                )),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                          child: Container(
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(15),
                                  bottomRight: Radius.circular(15)),
                              color: Colors.orange.shade100,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Chi tiết',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                        color: Colors.orange.shade800,
                                        // fontStyle: FontStyle.italic
                                      ),
                                ),
                                Icon(
                                  Icons.chevron_right_rounded,
                                  size: 30,
                                  color: Colors.orange.shade800,
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Chi tiết',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                    height: 370,
                    child: ListView(
                      padding: const EdgeInsets.all(8),
                      scrollDirection: Axis.horizontal,
                      children: [
                        Container(
                          width: 260,
                          height: 240,
                          padding: const EdgeInsets.only(
                              top: 15, left: 15, right: 24, bottom: 15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey
                                    .withOpacity(0.5), // Shadow color
                                spreadRadius: 1, // Spread radius
                                blurRadius: 5, // Blur radius
                                // offset: Offset(1, 1), // Offset
                              ),
                            ],
                          ),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: size,
                                          height: size,
                                          child: Transform.rotate(
                                            angle:
                                                HexagonClipper().degToRad(90),
                                            child: ClipPath(
                                              clipper: HexagonClipper(),
                                              child: Container(
                                                  color: color,
                                                  child: Transform.rotate(
                                                    angle: HexagonClipper()
                                                        .degToRad(-90),
                                                    child: const Icon(
                                                      Icons.mic,
                                                      size: 20,
                                                      color: Colors.white,
                                                    ),
                                                  )),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5),
                                          width: 100,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Phát âm',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleLarge!
                                                    .copyWith(),
                                              ),
                                              Text(
                                                'so với người bản sư',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    GradientBorderContainer(
                                      diameter: 70.0,
                                      borderWidth: 0.1, // 10% of diameter
                                      borderColor1:
                                          Colors.lightGreenAccent.shade700,
                                      borderColor2:
                                          Colors.lightGreenAccent.shade100,
                                      stop1: 0.6,
                                      stop2: 0.4,
                                      percent: 60,
                                      fontSize: 30,
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'CÁC ÂM LÀM TỐT',
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                SizedBox(
                                  height: 80,
                                  child: ListView.builder(
                                    padding: EdgeInsets.zero,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: _goodPhonemes.length,
                                    itemBuilder: (context, index) {
                                      Color lineColor = accuracyToColor(
                                          _goodPhonemes[index].accuracy);

                                      return Row(
                                        children: [
                                          Expanded(
                                            flex: 2,
                                            child: Text(
                                              textAlign: TextAlign.left,
                                              '/${_goodPhonemes[index].phoneme}/',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge!
                                                  .copyWith(
                                                      color: lineColor,
                                                      fontFamily: 'DoulosSIL'),
                                            ),
                                          ),
                                          Expanded(
                                              flex: 8,
                                              child: ColoredLine(
                                                  // length: 150,
                                                  percentLeft:
                                                      _goodPhonemes[index]
                                                              .accuracy /
                                                          100,
                                                  percentRight: 1 -
                                                      (_goodPhonemes[index]
                                                              .accuracy /
                                                          100),
                                                  colorLeft: lineColor,
                                                  colorRight: lineColor
                                                      .withOpacity(0.2))),
                                          Expanded(
                                            flex: 2,
                                            child: Text(
                                                '${_goodPhonemes[index].accuracy}%',
                                                textAlign: TextAlign.right,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium!
                                                    .copyWith(
                                                        color: lineColor)),
                                          )
                                        ],
                                      );
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'CÁC ÂM CẦN CẢI THIỆN',
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                SizedBox(
                                  height: 80,
                                  child: ListView.builder(
                                    padding: EdgeInsets.zero,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: _needToImprovePhonemes.length,
                                    itemBuilder: (context, index) {
                                      Color lineColor = accuracyToColor(
                                          _needToImprovePhonemes[index]
                                              .accuracy);

                                      return Row(
                                        children: [
                                          Expanded(
                                            flex: 2,
                                            child: Text(
                                              textAlign: TextAlign.left,
                                              '/${_needToImprovePhonemes[index].phoneme}/',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge!
                                                  .copyWith(
                                                      color: lineColor,
                                                      fontFamily: 'DoulosSIL'),
                                            ),
                                          ),
                                          Expanded(
                                              flex: 8,
                                              child: ColoredLine(
                                                  // length: 150,
                                                  percentLeft:
                                                      _needToImprovePhonemes[
                                                                  index]
                                                              .accuracy /
                                                          100,
                                                  percentRight: 1 -
                                                      (_needToImprovePhonemes[
                                                                  index]
                                                              .accuracy /
                                                          100),
                                                  colorLeft: lineColor,
                                                  colorRight: lineColor
                                                      .withOpacity(0.2))),
                                          Expanded(
                                            flex: 2,
                                            child: Text(
                                                '${_needToImprovePhonemes[index].accuracy}%',
                                                textAlign: TextAlign.right,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium!
                                                    .copyWith(
                                                        color: lineColor)),
                                          )
                                        ],
                                      );
                                    },
                                  ),
                                )

                                // ListTile(
                                //   horizontalTitleGap: 10,
                                //   contentPadding: EdgeInsets.zero,
                                //   leading: Container(
                                //     width: size,
                                //     height: size,
                                //     child: Transform.rotate(
                                //       angle: HexagonClipper().degToRad(90),
                                //       child: ClipPath(
                                //         clipper: HexagonClipper(),
                                //         child: Container(
                                //             color: color,
                                //             child: Transform.rotate(
                                //               angle: HexagonClipper().degToRad(-90),
                                //               child: const Icon(
                                //                 Icons.mic,
                                //                 size: 30,
                                //                 color: Colors.white,
                                //               ),
                                //             )),
                                //       ),
                                //     ),
                                //   ),
                                //   title: Text(
                                //     'Phát âm',
                                //     style: Theme.of(context).textTheme.bodyLarge,
                                //   ),
                                //   subtitle: Text(
                                //     'so với người bản sư',
                                //     style: Theme.of(context).textTheme.bodySmall,
                                //   ),
                                //   trailing: Container(
                                //     width: 100,
                                //     height: 150,
                                //     decoration: BoxDecoration(
                                //       // shape: BoxShape.circle,
                                //       color: color,
                                //     ),
                                //   ),
                                // )
                              ]),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Container(
                          width: 260,
                          height: 240,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey
                                    .withOpacity(0.5), // Shadow color
                                spreadRadius: 1, // Spread radius
                                blurRadius: 5, // Blur radius
                                // offset: Offset(1, 1), // Offset
                              ),
                            ],
                          ),
                          child: Column(children: []),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Container(
                          width: 260,
                          height: 240,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey
                                    .withOpacity(0.5), // Shadow color
                                spreadRadius: 1, // Spread radius
                                blurRadius: 5, // Blur radius
                                // offset: Offset(1, 1), // Offset
                              ),
                            ],
                          ),
                          child: Column(children: []),
                        ),
                      ],
                    ))
              ]),
            ),
          ],
        ),
      ),
    );
  }
}

class HexagonClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    double angle = 60.0; // Angle between two consecutive corners

    final double radius = size.width / 2;

    for (int i = 0; i < 6; i++) {
      double x = radius * cos(degToRad(angle * i));
      double y = radius * sin(degToRad(angle * i));
      if (i == 0) {
        path.moveTo(x + radius, y + radius);
      } else {
        path.lineTo(x + radius, y + radius);
      }
    }

    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }

  double degToRad(double degree) {
    return degree * (pi / 180.0);
  }
}

Color accuracyToColor(int accuracy) {
  if (accuracy >= 90) {
    return Colors.green;
  } else if (accuracy >= 50) {
    return Colors.yellow;
  } else {
    return Colors.red;
  }
}

class PhonemeAssessment {
  final String phoneme;
  final int accuracy;

  PhonemeAssessment({required this.phoneme, required this.accuracy});
}
