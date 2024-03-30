import 'package:ctue_app/core/constants/constants.dart';
import 'package:ctue_app/features/specialization/business/entities/specialization_entity.dart';

class SpecializationModel extends SpecializationEntity {
  SpecializationModel({super.id, required super.name});

  factory SpecializationModel.fromJson({required Map<String, dynamic> json}) {
    return SpecializationModel(id: json['id'], name: json['name']);
  }

  Map<String, dynamic> toJson() {
    return {kId: id, kName: name};
  }
}
