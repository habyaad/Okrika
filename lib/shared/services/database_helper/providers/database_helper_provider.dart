import 'package:okrika/shared/services/database_helper/data/database_helper_impl.dart';
import 'package:okrika/shared/services/database_helper/domain/repositories/database_helper_repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'database_helper_provider.g.dart';

@riverpod
DatabaseHelperRepo databaseHelper(DatabaseHelperRef ref) {
  return DatabaseHelperImpl.instance;
}
