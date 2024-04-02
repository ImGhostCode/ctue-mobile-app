import 'package:ctue_app/features/auth/business/entities/account_entiry.dart';

class UserResEntity {
  final int? totalPages;
  final int? total;
  List<AccountEntity> data = [];

  UserResEntity({this.total, required this.data, this.totalPages});
}
