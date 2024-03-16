import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:ctue_app/core/services/audio_service.dart';
import 'package:ctue_app/features/profile/presentation/widgets/gradient_border_container.dart';
import 'package:ctue_app/features/speech/presentation/providers/speech_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class RecordButton extends StatefulWidget {
  final String text;

  const RecordButton({super.key, required this.text});

  @override
  State<RecordButton> createState() => _RecordButtonState();
}

class _RecordButtonState extends State<RecordButton> {
  final recorder = FlutterSoundRecorder();
  bool _isRecording = false;
  String? _filePath;
  int? score;
  List<Text> phonemeResults = [];

  @override
  void initState() {
    super.initState();
    _initializeRecorder();
  }

  @override
  void dispose() {
    recorder.closeRecorder();
    super.dispose();
  }

  Future<void> _initializeRecorder() async {
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      return;
    }

    await recorder.openRecorder();
  }

  Future<void> _startRecording() async {
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      return;
    }
    Directory tempDir = await getTemporaryDirectory();
    _filePath = '${tempDir.path}/audio_recording.wav';
    await recorder.startRecorder(
      toFile: _filePath!,
      codec: Codec.pcm16WAV,
    );
    setState(() {
      _isRecording = true;
    });
  }

  Future<void> _stopRecording() async {
    await recorder.stopRecorder();
    setState(() {
      _isRecording = false;
    });
  }

  void _playRecording() async {
    // Implementation for playing back the recorded file
    if (_filePath != null) {
      final audioPlayer = AudioService.player;
      await audioPlayer.play(UrlSource(_filePath!));
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
          shape: MaterialStatePropertyAll(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(24))),
          padding: const MaterialStatePropertyAll(
              EdgeInsets.symmetric(horizontal: 32, vertical: 12))),
      onPressed: () async {
        if (_isRecording) {
          await _stopRecording();
          // _playRecording();
          if (_filePath != null) {
            await Provider.of<SpeechProvider>(context, listen: false)
                .eitherFailureEvaluateSP(widget.text, File(_filePath!));
            showAssessmentResult(
                Provider.of<SpeechProvider>(context, listen: false)
                    .assessmentResult);

            // ignore: use_build_context_synchronously
            showModalBottomSheet<void>(
              context: context,
              backgroundColor: Colors.white,
              builder: (BuildContext context) {
                return SizedBox(
                  height: 350,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          'Kết quả đánh giá phát âm',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        score != 0
                            ? GradientBorderContainer(
                                diameter: 90.0,
                                borderWidth: 0.1, // 10% of diameter
                                borderColor1: scoreToColor(score!),
                                borderColor2:
                                    scoreToColor(score!).withOpacity(0.3),
                                stop1: (score! / 100).toDouble(),
                                stop2: 1 - (score! / 100).toDouble(),
                                percent: score!,
                                fontSize: 30,
                              )
                            : GradientBorderContainer(
                                diameter: 90.0,
                                borderWidth: 0.1, // 10% of diameter
                                borderColor1: Colors.grey.shade300,
                                borderColor2: Colors.grey.shade300,
                                stop1: 1,
                                stop2: 1,
                                percent: 0,
                                fontSize: 30,
                              ),
                        const SizedBox(
                          height: 10,
                        ),
                        phonemeResults.isNotEmpty
                            ? Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text('/',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge!
                                          .copyWith(
                                              fontWeight: FontWeight.normal,
                                              fontFamily: 'DoulosSIL')),
                                  // Text('t',
                                  //     style: Theme.of(context)
                                  //         .textTheme
                                  //         .titleMedium!
                                  //         .copyWith(
                                  //             color: scoreToColor(34),
                                  //             fontWeight: FontWeight.normal,
                                  //             fontFamily: 'DoulosSIL')),
                                  // Text('e',
                                  //     style: Theme.of(context)
                                  //         .textTheme
                                  //         .titleMedium!
                                  //         .copyWith(
                                  //             color: scoreToColor(99),
                                  //             fontWeight: FontWeight.normal,
                                  //             fontFamily: 'DoulosSIL')),
                                  // Text('s',
                                  //     style: Theme.of(context)
                                  //         .textTheme
                                  //         .titleMedium!
                                  //         .copyWith(
                                  //             color: scoreToColor(68),
                                  //             fontWeight: FontWeight.normal,
                                  //             fontFamily: 'DoulosSIL')),
                                  // Text('t',
                                  //     style: Theme.of(context)
                                  //         .textTheme
                                  //         .titleMedium!
                                  //         .copyWith(
                                  //             color: scoreToColor(80),
                                  //             fontWeight: FontWeight.normal,
                                  //             fontFamily: 'DoulosSIL')),
                                  ...phonemeResults,
                                  Text('/',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge!
                                          .copyWith(
                                              fontWeight: FontWeight.normal,
                                              fontFamily: 'DoulosSIL')),
                                ],
                              )
                            : const SizedBox.shrink(),
                        const SizedBox(
                          height: 10,
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  //  isLoading
                                  //     ? MaterialStatePropertyAll(
                                  //         Colors.tealAccent.shade700.withOpacity(0.8))
                                  // :
                                  MaterialStatePropertyAll(
                                      Colors.tealAccent.shade700),
                              padding: const MaterialStatePropertyAll(
                                  EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4))),
                          onPressed:
                              // isLoading
                              //     ? null
                              //     :
                              () async {
                            try {
                              _playRecording();
                            } catch (e) {
                              print("Error playing audio: $e");
                            }
                          },
                          child: const Icon(
                            Icons.headphones,
                            size: 30,
                            color: Colors.white,
                          ),
                        ),
                        const Spacer(),
                        OutlinedButton(
                          style: const ButtonStyle(
                              side: MaterialStatePropertyAll(
                                  BorderSide(color: Colors.red))),
                          child: Text(
                            'Đóng',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(color: Colors.red),
                          ),
                          onPressed: () => Navigator.pop(context),
                        )
                        // ElevatedButton(
                        //   style: ButtonStyle(backgroundColor: ),
                        //   child: const Text('Đóng'),
                        //   onPressed: () => Navigator.pop(context),
                        // ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        } else {
          await _startRecording();
        }
      },
      child: Icon(
        _isRecording ? Icons.stop_rounded : Icons.mic_rounded,
        size: 50,
        color: Colors.white,
      ),
    );
  }

  void showAssessmentResult(dynamic data) {
    if (data != null) {
      score = data.score;
      data.phonemeAssessments.forEach((phoneme) {
        phonemeResults.add(Text(phoneme.label,
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.normal,
                color: scoreToColor(phoneme.score),
                fontFamily: 'DoulosSIL')));
      });
    } else {
      score = 0;
      phonemeResults = [];
    }
  }
}

Color scoreToColor(int score) {
  if (score > 79) {
    return Colors.green;
  } else if (score > 59) {
    return Colors.yellow.shade700;
  } else {
    return Colors.red;
  }
}
