import 'package:audioplayers/audioplayers.dart';

//Singleton Pattern
class AudioService {
  static final AudioPlayer _player = AudioPlayer();

  static AudioPlayer get player => _player;

  AudioService._internal();

  static init() {}
}
