// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fetch_single_product_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$fetchSingleProductHash() =>
    r'6993d52ce9f06d31ffb4402724573123884d4608';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [fetchSingleProduct].
@ProviderFor(fetchSingleProduct)
const fetchSingleProductProvider = FetchSingleProductFamily();

/// See also [fetchSingleProduct].
class FetchSingleProductFamily extends Family<AsyncValue<ProductModel>> {
  /// See also [fetchSingleProduct].
  const FetchSingleProductFamily();

  /// See also [fetchSingleProduct].
  FetchSingleProductProvider call(
    int id,
  ) {
    return FetchSingleProductProvider(
      id,
    );
  }

  @override
  FetchSingleProductProvider getProviderOverride(
    covariant FetchSingleProductProvider provider,
  ) {
    return call(
      provider.id,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'fetchSingleProductProvider';
}

/// See also [fetchSingleProduct].
class FetchSingleProductProvider
    extends AutoDisposeFutureProvider<ProductModel> {
  /// See also [fetchSingleProduct].
  FetchSingleProductProvider(
    int id,
  ) : this._internal(
          (ref) => fetchSingleProduct(
            ref as FetchSingleProductRef,
            id,
          ),
          from: fetchSingleProductProvider,
          name: r'fetchSingleProductProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$fetchSingleProductHash,
          dependencies: FetchSingleProductFamily._dependencies,
          allTransitiveDependencies:
              FetchSingleProductFamily._allTransitiveDependencies,
          id: id,
        );

  FetchSingleProductProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final int id;

  @override
  Override overrideWith(
    FutureOr<ProductModel> Function(FetchSingleProductRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FetchSingleProductProvider._internal(
        (ref) => create(ref as FetchSingleProductRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<ProductModel> createElement() {
    return _FetchSingleProductProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FetchSingleProductProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin FetchSingleProductRef on AutoDisposeFutureProviderRef<ProductModel> {
  /// The parameter `id` of this provider.
  int get id;
}

class _FetchSingleProductProviderElement
    extends AutoDisposeFutureProviderElement<ProductModel>
    with FetchSingleProductRef {
  _FetchSingleProductProviderElement(super.provider);

  @override
  int get id => (origin as FetchSingleProductProvider).id;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
