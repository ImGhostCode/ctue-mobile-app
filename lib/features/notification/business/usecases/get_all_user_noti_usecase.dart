import 'package:ctue_app/core/constants/response.dart';
import 'package:ctue_app/core/errors/failure.dart';
import 'package:ctue_app/core/params/notification_params.dart';
import 'package:ctue_app/features/notification/business/entities/noti_response_entity.dart';
import 'package:ctue_app/features/notification/business/repositories/noti_repository.dart';

import 'package:dartz/dartz.dart';

class GetAllNotiNotiUsecase {
  final NotiRepository notiRepository;

  GetAllNotiNotiUsecase({required this.notiRepository});

  Future<Either<Failure, ResponseDataModel<NotiResEntity>>> call({
    required GetAllUserNotiParams getAllNotiNotiParams,
  }) async {
    return await notiRepository.getAllUserNotifications(
        getAllUserNotiParams: getAllNotiNotiParams);
  }
}
