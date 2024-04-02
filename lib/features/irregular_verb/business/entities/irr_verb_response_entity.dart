import 'package:ctue_app/features/irregular_verb/business/entities/irr_verb_entity.dart';

class IrrVerbResEntity {
  final int? totalPages;
  final int? total;
  List<IrrVerbEntity> data = [];

  IrrVerbResEntity({this.total, required this.data, this.totalPages});
}
