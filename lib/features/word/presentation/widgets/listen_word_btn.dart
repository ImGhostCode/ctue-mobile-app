import 'dart:typed_data';

import 'package:audioplayers/audioplayers.dart';
import 'package:ctue_app/core/services/audio_service.dart';
import 'package:ctue_app/features/speech/business/entities/voice_entity.dart';
import 'package:ctue_app/features/speech/presentation/providers/speech_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListenWordButton extends StatelessWidget {
  final String text;
  final bool isLoadingPage;
  final bool showBackgound;
  final int? width;
  final int? height;
  final double? iconSize;
  final IconData? icon;
  final double? rate;
  ListenWordButton(
      {super.key,
      required this.text,
      this.width,
      this.height,
      this.icon,
      this.rate = 1,
      this.iconSize = 30.0,
      this.isLoadingPage = false,
      this.showBackgound = true});
  final _audioPlayer = AudioService.player;

  @override
  Widget build(BuildContext context) {
    return Consumer<SpeechProvider>(
      builder: (context, provider, child) {
        bool isLoading = provider.isLoadingWidget;

        return showBackgound
            ? ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: isLoading
                        ? MaterialStatePropertyAll(
                            Colors.tealAccent.shade700.withOpacity(0.8))
                        : MaterialStatePropertyAll(isLoadingPage
                            ? Colors.grey.shade50
                            : Colors.tealAccent.shade700),
                    padding: const MaterialStatePropertyAll(
                        EdgeInsets.symmetric(horizontal: 8, vertical: 6))),
                onPressed: isLoading
                    ? null
                    : () async {
                        await _playAudio(provider, rate!);
                      },
                child: Icon(
                  icon ?? Icons.volume_up_rounded,
                  size: iconSize,
                  color: Colors.white,
                ),
              )
            : IconButton(
                onPressed: isLoading
                    ? null
                    : () async {
                        await _playAudio(provider, rate!);
                      },
                icon: Icon(
                  Icons.volume_up_rounded,
                  color: Colors.grey.shade600,
                ));
      },
    );
  }

  Future<void> _playAudio(SpeechProvider provider, double rate) async {
    VoiceEntity voice = await provider.getSelectedVoice();
    await provider.eitherFailureOrTts(text, voice, rate);
    try {
      await _audioPlayer.play(
        BytesSource(Uint8List.fromList(provider.audioBytes)),
      );
    } catch (e) {
      print("Error playing audio: $e");
    }
  }
}
