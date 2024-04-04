import '../../../../../core/constants/constants.dart';
import '../../business/entities/irr_verb_entity.dart';

class IrrVerbModel extends IrrVerbEntity {
  const IrrVerbModel(
      {required super.v1,
      required super.v2,
      required super.v3,
      required super.meaning,
      super.isDeleted,
      required super.id});

  factory IrrVerbModel.fromJson({required Map<String, dynamic> json}) {
    return IrrVerbModel(
      v1: json[kV1],
      v2: json[kV2],
      v3: json[kV3],
      meaning: json[kMeaning],
      isDeleted: json[kIsDeleted],
      id: json[kId],
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
