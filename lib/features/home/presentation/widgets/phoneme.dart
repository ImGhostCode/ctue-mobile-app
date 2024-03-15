// import 'package:audioplayers/audioplayers.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:ctue_app/core/constants/ipa_constants.dart';
import 'package:ctue_app/core/services/audio_service.dart';
import 'package:flutter/material.dart';
// import 'package:just_audio/just_audio.dart';

final AudioPlayer player = AudioService.player;

class PhonemeWidget extends StatelessWidget {
  final Phoneme phoneme;
  PhonemeWidget({super.key, required this.phoneme});

  bool isAudioPlaying = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _showPhonemeDetail(context, phoneme),
      child: Container(
          // height: 80,
          // width: 80,
          // margin: const EdgeInsets.all(8),
          // padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            // color: vowels[index].bgColor,
            color: _getBgColor(phoneme.type),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '/${phoneme.label}/',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.w600, fontFamily: 'DoulosSIL'),
              ),
              Text(
                phoneme.examples[0].split(' ')[0],
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Colors.black54),
              )
            ],
          )),
    );
  }
}

_getBgColor(type) {
  switch (type) {
    case Type.short:
      return Colors.orange.shade50;

    case Type.long:
      return Colors.orange.shade100;

    case Type.diphthongs:
      return Colors.blue.shade300;

    case Type.unvoiced:
      return Colors.green.shade400;

    case Type.voiced:
      return Colors.teal.shade200;

    default:
      return Colors.amber.shade100;
  }
}

_showPhonemeDetail(context, phoneme) {
  showDialog<String>(
    context: context,
    builder: (BuildContext context) => Dialog(
      backgroundColor: Colors.white,
      insetPadding: const EdgeInsets.symmetric(horizontal: 12),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(18)),
        padding: const EdgeInsets.all(16),
        height: 280,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: [
                Text(
                  '/${phoneme.label}/',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(fontSize: 40, fontFamily: 'DoulosSIL'),
                ),
                const SizedBox(
                  width: 10,
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
                  decoration: BoxDecoration(
                      color: _getBgColor(phoneme.type),
                      borderRadius: BorderRadius.circular(12)),
                  child: Text(
                    phoneme.type.toString().split('.')[1],
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
                const Spacer(),
                ElevatedButton(
                    onPressed: () async {
                      // await player.setAudioSource(
                      //     AudioSource.asset('assets/audios/${phoneme.source}'));
                      // await player.play();
                      // await player.stop();
                      await player
                          .play(AssetSource('audios/${phoneme.source}'));
                    },
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.volume_up_rounded),
                        SizedBox(
                          width: 3,
                        ),
                        Text('Nghe phát âm')
                      ],
                    ))
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              'Mẹo phát âm',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(),
            ),
            const SizedBox(
              height: 5,
            ),
            Expanded(
              child: ListView(
                children: [
                  ...phoneme.tips.map((e) => Text(
                        e,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                            ),
                      ))
                ],
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              'Ví dụ',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              '${phoneme.examples.map((e) => '${e.split(' ')[0] + ' /' + e.split(' ')[1] + '/'}').join(', ')}',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                  fontFamily: 'DoulosSIL'),
            )
          ],
        ),
      ),
    ),
  );
}
