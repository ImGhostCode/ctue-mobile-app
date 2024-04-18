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
  ListenWordButton({super.key, required this.text, this.isLoadingPage = false});
  final _audioPlayer = AudioService.player;

  @override
  Widget build(BuildContext context) {
    return Consumer<SpeechProvider>(
      builder: (context, provider, child) {
        bool isLoading = provider.isLoadingWidget;

        return ElevatedButton(
          style: ButtonStyle(
              backgroundColor: isLoading
                  ? MaterialStatePropertyAll(
                      Colors.tealAccent.shade700.withOpacity(0.8))
                  : MaterialStatePropertyAll(isLoadingPage
                      ? Colors.grey.shade50
                      : Colors.tealAccent.shade700),
              padding: const MaterialStatePropertyAll(
                  EdgeInsets.symmetric(horizontal: 8, vertical: 4))),
          onPressed: isLoading
              ? null
              : () async {
                  VoiceEntity voice = await provider.getSelectedVoice();
                  await provider.eitherFailureOrTts(text, voice);
                  try {
                    await _audioPlayer.play(
                        BytesSource(Uint8List.fromList(provider.audioBytes)));
                  } catch (e) {
                    print("Error playing audio: $e");
                  }
                },
          child: const Icon(
            Icons.volume_up_rounded,
            size: 30,
            color: Colors.white,
          ),
        );
      },
    );
  }
}
