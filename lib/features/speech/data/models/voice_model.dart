import 'package:ctue_app/core/constants/constants.dart';
import 'package:ctue_app/features/speech/business/entities/voice_entity.dart';

class VoiceModel extends VoiceEntity {
  VoiceModel(
      {required super.displayName,
      required super.shortName,
      required super.gender,
      required super.locale,
      required super.voiceType});

  factory VoiceModel.fromJson({required Map<String, dynamic> json}) {
    return VoiceModel(
        displayName: json[kDisplayName],
        shortName: json[kShortName],
        gender: json[kGender],
        locale: json[kLocate],
        voiceType: json[kVoiceType]);
  }

  Map<String, dynamic> toJson() {
    return {
      kDisplayName: displayName,
      kShortName: shortName,
      kGender: gender,
      kLocate: locale,
      kVoiceType: voiceType
    };
  }
}
