import 'package:ctue_app/core/api/api_service.dart';
import 'package:ctue_app/core/constants/constants.dart';
import 'package:ctue_app/core/constants/response.dart';
import 'package:ctue_app/core/params/speech_params.dart';
import 'package:ctue_app/features/home/data/datasources/template_local_data_source.dart';
import 'package:ctue_app/features/speech/business/entities/voice_entity.dart';
import 'package:ctue_app/features/speech/business/usecases/get_voices_usecase.dart';
import 'package:ctue_app/features/speech/business/usecases/tts_usecase.dart';
import 'package:ctue_app/features/speech/data/datasources/speech_remote_data_source.dart';
import 'package:ctue_app/features/speech/data/repositories/speech_repository_impl.dart';
import 'package:data_connection_checker_tv/data_connection_checker.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/connection/network_info.dart';
import '../../../../../core/errors/failure.dart';

class SpeechProvider extends ChangeNotifier {
  List<VoiceEntity> listVoices = [];
  List<int> audioBytes = [];
  VoiceEntity? selectedVoice;

  Failure? failure;
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  SpeechProvider({
    this.failure,
  });

  List<VoiceEntity> getUSVoices() {
    return listVoices.where((voice) => voice.locale == localeUS).toList();
  }

  void setVoice(VoiceEntity voice) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    selectedVoice = voice;
    await prefs.setString('displayName', voice.displayName);
    await prefs.setString('locale', voice.locale);
    await prefs.setString('gender', voice.gender);
    await prefs.setString('shortName', voice.shortName);
    await prefs.setString('voiceType', voice.voiceType);
  }

  Future<VoiceEntity> getSelectedVoice() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (selectedVoice != null) {
      return selectedVoice!;
    } else if (prefs.getString('locale') != null) {
      return VoiceEntity(
          displayName: prefs.getString('displayName')!,
          shortName: prefs.getString('shortName')!,
          gender: prefs.getString('gender')!,
          locale: prefs.getString('locale')!,
          voiceType: prefs.getString('voiceType')!);
    } else {
      return VoiceEntity(
          displayName: defaultDisplayName,
          shortName: defaultShortName,
          gender: defaultGender,
          locale: defaultLocale,
          voiceType: defaultVoiceType);
    }
  }

  void eitherFailureOrGetVoices() async {
    _isLoading = true;

    SpeechRepositoryImpl repository = SpeechRepositoryImpl(
      remoteDataSource: SpeechRemoteDataSourceImpl(
        dio: ApiService.dio,
      ),
      localDataSource: TemplateLocalDataSourceImpl(
        sharedPreferences: await SharedPreferences.getInstance(),
      ),
      networkInfo: NetworkInfoImpl(
        DataConnectionChecker(),
      ),
    );

    final failureOrSpeech =
        await GetVoiceUsecase(speechRepository: repository).call(
      getVoiceParams: GetVoiceParams(),
    );

    failureOrSpeech.fold(
      (Failure newFailure) {
        _isLoading = false;
        listVoices = [];
        failure = newFailure;
        notifyListeners();
      },
      (ResponseDataModel<List<VoiceEntity>> newVoices) {
        _isLoading = false;
        listVoices = newVoices.data;
        failure = null;
        notifyListeners();
      },
    );
  }

  Future eitherFailureOrTts(String text, VoiceEntity voice) async {
    _isLoading = true;

    SpeechRepositoryImpl repository = SpeechRepositoryImpl(
      remoteDataSource: SpeechRemoteDataSourceImpl(
        dio: ApiService.dio,
      ),
      localDataSource: TemplateLocalDataSourceImpl(
        sharedPreferences: await SharedPreferences.getInstance(),
      ),
      networkInfo: NetworkInfoImpl(
        DataConnectionChecker(),
      ),
    );

    final failureOrSpeech = await TtsUsecase(speechRepository: repository).call(
      ttsParams: TTSParams(text: text, voice: voice),
    );

    failureOrSpeech.fold(
      (Failure newFailure) {
        _isLoading = false;
        audioBytes = [];
        failure = newFailure;
        notifyListeners();
      },
      (ResponseDataModel<List<int>> newVoices) {
        _isLoading = false;
        audioBytes = newVoices.data;
        failure = null;
        notifyListeners();
      },
    );
  }
}
