import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'filter_provider.g.dart';

@Riverpod(keepAlive: true)
class Filter extends _$Filter {
  @override
  Map<String, dynamic> build() {
    return {};
  }

  void setKey(String key, dynamic value) {
    state[key] = value;
  }

  void removeKey(String key) {
    state.remove(key);
  }

  void removeFilter() {
    state = {};
  }
}
