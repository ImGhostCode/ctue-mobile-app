import '../../../../../core/constants/constants.dart';
import '../../business/entities/irr_verb_entity.dart';

class IrrVerbModel extends IrrVerbEntity {
  const IrrVerbModel(
      {required super.v1,
      required super.v2,
      required super.v3,
      required super.meaning,
      super.isDeleted});

  factory IrrVerbModel.fromJson({required Map<String, dynamic> json}) {
    return IrrVerbModel(
      v1: json['v1'],
      v2: json['v2'],
      v3: json['v3'],
      meaning: json['meaning'],
      isDeleted: json['isDeleted'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      kV1: v1,
      kV2: v2,
      kV3: v3,
      kMeaning: meaning,
      kIsDeleted: isDeleted,
    };
  }
}
