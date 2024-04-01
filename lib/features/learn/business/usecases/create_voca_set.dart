import '../repositories/learn_repository.dart';

class CreVocaSetUsecase {
  final LearnRepository learnRepository;

  CreVocaSetUsecase({required this.learnRepository});

  // Future<Either<Failure, ResponseDataModel<VocaSetEntity>>> call({
  //   required CreVocaSetParams creVocaSetParams,
  // }) async {
  //   return await vocaSetRepository.createVocaSet(
  //       creVocaSetParams: creVocaSetParams);
  // }
}
