import 'package:ctue_app/features/contribute/business/entities/contribution_entity.dart';

class ContributionResEntity {
  final int? totalPages;
  final int? total;
  List<ContributionEntity> data = [];

  ContributionResEntity({this.total, required this.data, this.totalPages});
}
