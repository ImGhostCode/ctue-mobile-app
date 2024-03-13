class VoiceEntity {
  final String displayName;
  final String shortName;
  final String gender;
  final String locale;
  final String voiceType;

  VoiceEntity(
      {required this.displayName,
      required this.shortName,
      required this.gender,
      required this.locale,
      required this.voiceType});
}
