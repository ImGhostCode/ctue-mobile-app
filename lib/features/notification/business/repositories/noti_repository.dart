import 'package:ctue_app/core/constants/response.dart';
import 'package:ctue_app/core/params/notification_params.dart';
import 'package:ctue_app/features/notification/business/entities/noti_response_entity.dart';
import 'package:dartz/dartz.dart';
import '../../../../../core/errors/failure.dart';

abstract class NotiRepository {
  Future<Either<Failure, ResponseDataModel<NotiResEntity>>>
      getAllUserNotifications({
    required GetAllUserNotiParams getAllUserNotiParams,
  });
}
