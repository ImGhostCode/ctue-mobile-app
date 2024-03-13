import 'package:ctue_app/core/constants/response.dart';
import 'package:ctue_app/core/params/speech_params.dart';
import 'package:ctue_app/features/home/data/datasources/template_local_data_source.dart';
import 'package:ctue_app/features/speech/business/repositories/speech_repository.dart';
import 'package:ctue_app/features/speech/data/datasources/speech_remote_data_source.dart';
import 'package:ctue_app/features/speech/data/models/voice_model.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/connection/network_info.dart';
import '../../../../../core/errors/exceptions.dart';
import '../../../../../core/errors/failure.dart';

class SpeechRepositoryImpl implements SpeechRepository {
  final SpeechRemoteDataSource remoteDataSource;
  final TemplateLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  SpeechRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, ResponseDataModel<List<VoiceModel>>>> getVoices(
      {required GetVoiceParams getVoiceParams}) async {
    if (await networkInfo.isConnected!) {
      try {
        ResponseDataModel<List<VoiceModel>> remoteType =
            await remoteDataSource.getVoices(getVoiceParams: getVoiceParams);

        // localDataSource.cacheAuth(AuthToCache: remoteType);

        return Right(remoteType);
      } on ServerException catch (e) {
        return Left(ServerFailure(
            errorMessage: e.errorMessage, statusCode: e.statusCode));
      }
    } else {
      return Left(CacheFailure(errorMessage: 'This is a network exception'));
    }
  }

  @override
  Future<Either<Failure, ResponseDataModel<List<int>>>> textToSpeech(
      {required TTSParams ttsParams}) async {
    if (await networkInfo.isConnected!) {
      try {
        ResponseDataModel<List<int>> remoteType =
            await remoteDataSource.tts(ttsParams: ttsParams);

        // localDataSource.cacheAuth(AuthToCache: remoteType);

        return Right(remoteType);
      } on ServerException catch (e) {
        return Left(ServerFailure(
            errorMessage: e.errorMessage, statusCode: e.statusCode));
      }
    } else {
      return Left(CacheFailure(errorMessage: 'This is a network exception'));
    }
  }
}
