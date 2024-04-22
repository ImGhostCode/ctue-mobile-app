import 'package:ctue_app/features/extension/business/entities/favorite_entity.dart';

class FavoriteResEntity {
  final int? totalPages;
  final int? total;
  List<FavoriteEntity> data = [];

  FavoriteResEntity({this.total, required this.data, this.totalPages});
}
