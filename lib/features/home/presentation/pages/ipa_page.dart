import 'package:ctue_app/core/constants/ipa_constants.dart';
import 'package:ctue_app/features/home/presentation/widgets/phoneme.dart';
import 'package:flutter/material.dart';

class IPA extends StatelessWidget {
  const IPA({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'IPA',
          style: Theme.of(context).textTheme.titleMedium!.copyWith(),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Nguyên âm đơn',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
                  height: 470,
                  width: MediaQuery.of(context).size.width,
                  child: GridView.builder(
                    itemCount: vowels.length,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 12,
                    ),
                    primary: false,
                    padding: const EdgeInsets.all(0),
                    itemBuilder: (context, index) {
                      return PhonemeWidget(
                        phoneme: vowels[index],
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  'Nguyên âm đôi',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                  height: 350,
                  width: MediaQuery.of(context).size.width,
                  child: GridView.builder(
                    itemCount: diphthongs.length,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 12,
                    ),
                    primary: false,
                    // padding: const EdgeInsets.all(8),
                    itemBuilder: (context, index) {
                      return PhonemeWidget(
                        phoneme: diphthongs[index],
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  'Phụ âm',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                  height: 470,
                  width: MediaQuery.of(context).size.width,
                  child: GridView.builder(
                    itemCount: consonants.length,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 12,
                    ),
                    primary: false,
                    // padding: const EdgeInsets.all(8),
                    itemBuilder: (context, index) {
                      return PhonemeWidget(
                        phoneme: consonants[index],
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
              ],
            )),
      ),
    );
  }
}
