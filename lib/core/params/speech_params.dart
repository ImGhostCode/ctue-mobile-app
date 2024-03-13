import 'package:ctue_app/features/speech/business/entities/voice_entity.dart';

class GetVoiceParams {
  // final String speechRegion;
  // final String speechKey;
  GetVoiceParams();
}

class TTSParams {
  final VoiceEntity voice;
  final String text;

  TTSParams({required this.voice, required this.text});
}
