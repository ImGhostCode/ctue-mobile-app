import 'package:ctue_app/features/home/presentation/pages/communication_phrase_page.dart';
import 'package:dartz/dartz.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../../core/params/params.dart';
import '../entities/template_entity.dart';

abstract class TemplateRepository {
  Future<Either<Failure, Topic>> getTopics({
    required TemplateParams templateParams,
  });
}
