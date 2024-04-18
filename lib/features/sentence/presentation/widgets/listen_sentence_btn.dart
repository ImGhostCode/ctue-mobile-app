import 'dart:typed_data';

import 'package:ctue_app/core/constants/constants.dart';
import 'package:ctue_app/core/services/audio_service.dart';
import 'package:ctue_app/features/speech/business/entities/voice_entity.dart';
import 'package:ctue_app/features/speech/presentation/providers/speech_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:audioplayers/audioplayers.dart';

class ListenSenButton extends StatelessWidget {
  final String text;
  final bool isLoadingPage;
  ListenSenButton({super.key, required this.text, this.isLoadingPage = false});
  final audioPlayer = AudioService.player;

  @override
  Widget build(BuildContext context) {
    return Consumer<SpeechProvider>(
      builder: (context, provider, child) {
        bool isLoading = provider.isLoading;
        return Center(
          child: SizedBox(
            height: 75,
            width: 95,
            child: ElevatedButton(
                style: ButtonStyle(
                    shadowColor: const MaterialStatePropertyAll(Colors.black),
                    backgroundColor: MaterialStatePropertyAll(isLoading
                        ? Colors.grey.shade300
                        : isLoadingPage
                            ? isLoadingColor
                            : Colors.grey.shade100)),
                onPressed: isLoading
                    ? null
                    : () async {
                        VoiceEntity voice = await provider.getSelectedVoice();
                        await provider.eitherFailureOrTts(text, voice);
                        try {
                          await audioPlayer.play(BytesSource(
                              Uint8List.fromList(provider.audioBytes)));
                        } catch (e) {
                          print("Error playing audio: $e");
                        }
                      },
                child: isLoading
                    ? const CircularProgressIndicator()
                    : Icon(
                        Icons.volume_up_outlined,
                        size: 40,
                        color: Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(0.7),
                      )),
          ),
        );
      },
    );
  }
}
