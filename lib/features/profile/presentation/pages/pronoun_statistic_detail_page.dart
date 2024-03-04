import 'package:ctue_app/features/profile/presentation/widgets/colored_line.dart';
import 'package:flutter/material.dart';

class ProStatisticDetailPage extends StatefulWidget {
  const ProStatisticDetailPage({super.key});

  @override
  State<ProStatisticDetailPage> createState() => _ProStatisticDetailPageState();
}

class _ProStatisticDetailPageState extends State<ProStatisticDetailPage> {
  final List<PhonemeAssessment> _listPhonemes = [
    PhonemeAssessment(phoneme: 'e', accuracy: 99),
    PhonemeAssessment(phoneme: 'i', accuracy: 94),
    PhonemeAssessment(phoneme: 'ɔː', accuracy: 90),
    PhonemeAssessment(phoneme: 'y', accuracy: 73),
    PhonemeAssessment(phoneme: 'h', accuracy: 63),
    PhonemeAssessment(phoneme: 'f', accuracy: 53),
    PhonemeAssessment(phoneme: 's', accuracy: 50),
    PhonemeAssessment(phoneme: 'w', accuracy: 43),
    PhonemeAssessment(phoneme: 'p', accuracy: 25),
    PhonemeAssessment(phoneme: 'g', accuracy: 23),
    PhonemeAssessment(phoneme: 'l', accuracy: 15),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Chi tiết phát âm',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.navigate_before,
              size: 32,
            )),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
          child: Column(
            children: [
              // Row(
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Text(
              //       'Đánh giá',
              //       style: Theme.of(context).textTheme.titleLarge,
              //     ),
              //     GradientBorderContainer(
              //       diameter: 80.0,
              //       borderWidth: 0.1, // 10% of diameter
              //       borderColor1: Colors.lightGreenAccent.shade700,
              //       borderColor2: Colors.lightGreenAccent.shade100,
              //       stop1: 0.6,
              //       stop2: 0.4,
              //       percent: 60,
              //       fontSize: 30,
              //     ),
              //   ],
              // ),
              // const SizedBox(
              //   height: 30,
              // ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                // separatorBuilder: (context, index) {
                //   return const Divider();
                // },
                itemBuilder: (context, index) {
                  Color lineColor =
                      accuracyToColor(_listPhonemes[index].accuracy);
                  return ListTile(
                    leading: Text(
                      textAlign: TextAlign.left,
                      '/${_listPhonemes[index].phoneme}/',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(color: lineColor, fontFamily: 'DoulosSIL'),
                    ),
                    title: ColoredLine(
                        // length: 150,
                        height: 9,
                        percentLeft: _listPhonemes[index].accuracy / 100,
                        percentRight: 1 - (_listPhonemes[index].accuracy / 100),
                        colorLeft: lineColor,
                        colorRight: lineColor.withOpacity(0.2)),
                    subtitle: Text('${_listPhonemes[index].accuracy}%',
                        textAlign: TextAlign.right,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: lineColor)),
                    minVerticalPadding: 0,
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 4, vertical: 0),
                  );
                },
                itemCount: _listPhonemes.length,
              ),
            ],
          ),
        ),
      ),
    );
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
