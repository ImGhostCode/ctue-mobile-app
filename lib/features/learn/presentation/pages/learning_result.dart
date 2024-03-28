import 'package:ctue_app/core/constants/memory_level_constants.dart';
import 'package:ctue_app/features/profile/presentation/widgets/gradient_border_container.dart';
import 'package:flutter/material.dart';

class LearningResult extends StatelessWidget {
  const LearningResult({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // centerTitle: true,
          // title: null,
          backgroundColor: Colors.white,
          scrolledUnderElevation: 0,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.close,
              size: 30,
            ),
          )),
      body: Container(
        decoration: BoxDecoration(color: Colors.white),
        padding: EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          SizedBox(
            height: 150,
            width: 250,
            child: Image.asset('assets/images/congratulation.png'),
          ),
          Text(
            'Chúc mừng! Bạn hãy tiếp tục học để giỏi hơn nữa nhé!!!',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Column(
            children: [
              Row(
                children: [
                  Container(
                    height: 30,
                    width: 30,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Colors.red),
                    child: const Icon(
                      Icons.south,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  const Text(
                    '2 từ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
              ),
              Wrap(
                spacing: 6,
                children: [
                  ...List.generate(
                      5,
                      (index) => SizedBox(
                            child: Chip(
                              backgroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 6),
                              shape: RoundedRectangleBorder(
                                  side: const BorderSide(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(20)),
                              avatar: GradientBorderContainer(
                                  diameter: level_1.diameter,
                                  borderWidth: level_1.borderWidth,
                                  borderColor1: level_1.borderColor1,
                                  borderColor2: level_1.borderColor2,
                                  stop1: level_1.stop1,
                                  stop2: level_1.stop2,
                                  percent: level_1.percent,
                                  fontSize: level_1.fontSize),
                              label: const Text('Aaron'),
                            ),
                          ))
                ],
              )
            ],
          ),
          Column(
            children: [
              Row(
                children: [
                  Container(
                    height: 30,
                    width: 30,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.green.shade500),
                    child: const Icon(
                      Icons.north,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  const Text(
                    '2 từ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
              ),
              Wrap(
                spacing: 6,
                children: [
                  ...List.generate(
                      5,
                      (index) => SizedBox(
                            child: Chip(
                              backgroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 6),
                              shape: RoundedRectangleBorder(
                                  side: const BorderSide(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(20)),
                              avatar: GradientBorderContainer(
                                  diameter: level_1.diameter,
                                  borderWidth: level_1.borderWidth,
                                  borderColor1: level_1.borderColor1,
                                  borderColor2: level_1.borderColor2,
                                  stop1: level_1.stop1,
                                  stop2: level_1.stop2,
                                  percent: level_1.percent,
                                  fontSize: level_1.fontSize),
                              label: const Text('Aaron'),
                            ),
                          ))
                ],
              )
            ],
          )
        ]),
      ),
    );
  }
}
