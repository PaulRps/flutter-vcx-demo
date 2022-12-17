// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'menu_navigation.state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$MenuNavigationState {
  MenuItem get menuItem => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(MenuItem menuItem) wallet,
    required TResult Function(MenuItem menuItem) connection,
    required TResult Function(MenuItem menuItem) credential,
    required TResult Function(MenuItem menuItem) proof,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(MenuItem menuItem)? wallet,
    TResult? Function(MenuItem menuItem)? connection,
    TResult? Function(MenuItem menuItem)? credential,
    TResult? Function(MenuItem menuItem)? proof,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(MenuItem menuItem)? wallet,
    TResult Function(MenuItem menuItem)? connection,
    TResult Function(MenuItem menuItem)? credential,
    TResult Function(MenuItem menuItem)? proof,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(WalletMenu value) wallet,
    required TResult Function(ConnectionMenu value) connection,
    required TResult Function(CredentialMenu value) credential,
    required TResult Function(ProofMenu value) proof,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(WalletMenu value)? wallet,
    TResult? Function(ConnectionMenu value)? connection,
    TResult? Function(CredentialMenu value)? credential,
    TResult? Function(ProofMenu value)? proof,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(WalletMenu value)? wallet,
    TResult Function(ConnectionMenu value)? connection,
    TResult Function(CredentialMenu value)? credential,
    TResult Function(ProofMenu value)? proof,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MenuNavigationStateCopyWith<MenuNavigationState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MenuNavigationStateCopyWith<$Res> {
  factory $MenuNavigationStateCopyWith(
          MenuNavigationState value, $Res Function(MenuNavigationState) then) =
      _$MenuNavigationStateCopyWithImpl<$Res, MenuNavigationState>;
  @useResult
  $Res call({MenuItem menuItem});
}

/// @nodoc
class _$MenuNavigationStateCopyWithImpl<$Res, $Val extends MenuNavigationState>
    implements $MenuNavigationStateCopyWith<$Res> {
  _$MenuNavigationStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? menuItem = null,
  }) {
    return _then(_value.copyWith(
      menuItem: null == menuItem
          ? _value.menuItem
          : menuItem // ignore: cast_nullable_to_non_nullable
              as MenuItem,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WalletMenuCopyWith<$Res>
    implements $MenuNavigationStateCopyWith<$Res> {
  factory _$$WalletMenuCopyWith(
          _$WalletMenu value, $Res Function(_$WalletMenu) then) =
      __$$WalletMenuCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({MenuItem menuItem});
}

/// @nodoc
class __$$WalletMenuCopyWithImpl<$Res>
    extends _$MenuNavigationStateCopyWithImpl<$Res, _$WalletMenu>
    implements _$$WalletMenuCopyWith<$Res> {
  __$$WalletMenuCopyWithImpl(
      _$WalletMenu _value, $Res Function(_$WalletMenu) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? menuItem = null,
  }) {
    return _then(_$WalletMenu(
      menuItem: null == menuItem
          ? _value.menuItem
          : menuItem // ignore: cast_nullable_to_non_nullable
              as MenuItem,
    ));
  }
}

/// @nodoc

class _$WalletMenu implements WalletMenu {
  const _$WalletMenu({this.menuItem = MenuItem.wallet});

  @override
  @JsonKey()
  final MenuItem menuItem;

  @override
  String toString() {
    return 'MenuNavigationState.wallet(menuItem: $menuItem)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WalletMenu &&
            (identical(other.menuItem, menuItem) ||
                other.menuItem == menuItem));
  }

  @override
  int get hashCode => Object.hash(runtimeType, menuItem);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WalletMenuCopyWith<_$WalletMenu> get copyWith =>
      __$$WalletMenuCopyWithImpl<_$WalletMenu>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(MenuItem menuItem) wallet,
    required TResult Function(MenuItem menuItem) connection,
    required TResult Function(MenuItem menuItem) credential,
    required TResult Function(MenuItem menuItem) proof,
  }) {
    return wallet(menuItem);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(MenuItem menuItem)? wallet,
    TResult? Function(MenuItem menuItem)? connection,
    TResult? Function(MenuItem menuItem)? credential,
    TResult? Function(MenuItem menuItem)? proof,
  }) {
    return wallet?.call(menuItem);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(MenuItem menuItem)? wallet,
    TResult Function(MenuItem menuItem)? connection,
    TResult Function(MenuItem menuItem)? credential,
    TResult Function(MenuItem menuItem)? proof,
    required TResult orElse(),
  }) {
    if (wallet != null) {
      return wallet(menuItem);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(WalletMenu value) wallet,
    required TResult Function(ConnectionMenu value) connection,
    required TResult Function(CredentialMenu value) credential,
    required TResult Function(ProofMenu value) proof,
  }) {
    return wallet(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(WalletMenu value)? wallet,
    TResult? Function(ConnectionMenu value)? connection,
    TResult? Function(CredentialMenu value)? credential,
    TResult? Function(ProofMenu value)? proof,
  }) {
    return wallet?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(WalletMenu value)? wallet,
    TResult Function(ConnectionMenu value)? connection,
    TResult Function(CredentialMenu value)? credential,
    TResult Function(ProofMenu value)? proof,
    required TResult orElse(),
  }) {
    if (wallet != null) {
      return wallet(this);
    }
    return orElse();
  }
}

abstract class WalletMenu implements MenuNavigationState {
  const factory WalletMenu({final MenuItem menuItem}) = _$WalletMenu;

  @override
  MenuItem get menuItem;
  @override
  @JsonKey(ignore: true)
  _$$WalletMenuCopyWith<_$WalletMenu> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ConnectionMenuCopyWith<$Res>
    implements $MenuNavigationStateCopyWith<$Res> {
  factory _$$ConnectionMenuCopyWith(
          _$ConnectionMenu value, $Res Function(_$ConnectionMenu) then) =
      __$$ConnectionMenuCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({MenuItem menuItem});
}

/// @nodoc
class __$$ConnectionMenuCopyWithImpl<$Res>
    extends _$MenuNavigationStateCopyWithImpl<$Res, _$ConnectionMenu>
    implements _$$ConnectionMenuCopyWith<$Res> {
  __$$ConnectionMenuCopyWithImpl(
      _$ConnectionMenu _value, $Res Function(_$ConnectionMenu) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? menuItem = null,
  }) {
    return _then(_$ConnectionMenu(
      menuItem: null == menuItem
          ? _value.menuItem
          : menuItem // ignore: cast_nullable_to_non_nullable
              as MenuItem,
    ));
  }
}

/// @nodoc

class _$ConnectionMenu implements ConnectionMenu {
  const _$ConnectionMenu({this.menuItem = MenuItem.connection});

  @override
  @JsonKey()
  final MenuItem menuItem;

  @override
  String toString() {
    return 'MenuNavigationState.connection(menuItem: $menuItem)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConnectionMenu &&
            (identical(other.menuItem, menuItem) ||
                other.menuItem == menuItem));
  }

  @override
  int get hashCode => Object.hash(runtimeType, menuItem);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ConnectionMenuCopyWith<_$ConnectionMenu> get copyWith =>
      __$$ConnectionMenuCopyWithImpl<_$ConnectionMenu>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(MenuItem menuItem) wallet,
    required TResult Function(MenuItem menuItem) connection,
    required TResult Function(MenuItem menuItem) credential,
    required TResult Function(MenuItem menuItem) proof,
  }) {
    return connection(menuItem);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(MenuItem menuItem)? wallet,
    TResult? Function(MenuItem menuItem)? connection,
    TResult? Function(MenuItem menuItem)? credential,
    TResult? Function(MenuItem menuItem)? proof,
  }) {
    return connection?.call(menuItem);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(MenuItem menuItem)? wallet,
    TResult Function(MenuItem menuItem)? connection,
    TResult Function(MenuItem menuItem)? credential,
    TResult Function(MenuItem menuItem)? proof,
    required TResult orElse(),
  }) {
    if (connection != null) {
      return connection(menuItem);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(WalletMenu value) wallet,
    required TResult Function(ConnectionMenu value) connection,
    required TResult Function(CredentialMenu value) credential,
    required TResult Function(ProofMenu value) proof,
  }) {
    return connection(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(WalletMenu value)? wallet,
    TResult? Function(ConnectionMenu value)? connection,
    TResult? Function(CredentialMenu value)? credential,
    TResult? Function(ProofMenu value)? proof,
  }) {
    return connection?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(WalletMenu value)? wallet,
    TResult Function(ConnectionMenu value)? connection,
    TResult Function(CredentialMenu value)? credential,
    TResult Function(ProofMenu value)? proof,
    required TResult orElse(),
  }) {
    if (connection != null) {
      return connection(this);
    }
    return orElse();
  }
}

abstract class ConnectionMenu implements MenuNavigationState {
  const factory ConnectionMenu({final MenuItem menuItem}) = _$ConnectionMenu;

  @override
  MenuItem get menuItem;
  @override
  @JsonKey(ignore: true)
  _$$ConnectionMenuCopyWith<_$ConnectionMenu> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CredentialMenuCopyWith<$Res>
    implements $MenuNavigationStateCopyWith<$Res> {
  factory _$$CredentialMenuCopyWith(
          _$CredentialMenu value, $Res Function(_$CredentialMenu) then) =
      __$$CredentialMenuCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({MenuItem menuItem});
}

/// @nodoc
class __$$CredentialMenuCopyWithImpl<$Res>
    extends _$MenuNavigationStateCopyWithImpl<$Res, _$CredentialMenu>
    implements _$$CredentialMenuCopyWith<$Res> {
  __$$CredentialMenuCopyWithImpl(
      _$CredentialMenu _value, $Res Function(_$CredentialMenu) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? menuItem = null,
  }) {
    return _then(_$CredentialMenu(
      menuItem: null == menuItem
          ? _value.menuItem
          : menuItem // ignore: cast_nullable_to_non_nullable
              as MenuItem,
    ));
  }
}

/// @nodoc

class _$CredentialMenu implements CredentialMenu {
  const _$CredentialMenu({this.menuItem = MenuItem.credential});

  @override
  @JsonKey()
  final MenuItem menuItem;

  @override
  String toString() {
    return 'MenuNavigationState.credential(menuItem: $menuItem)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CredentialMenu &&
            (identical(other.menuItem, menuItem) ||
                other.menuItem == menuItem));
  }

  @override
  int get hashCode => Object.hash(runtimeType, menuItem);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CredentialMenuCopyWith<_$CredentialMenu> get copyWith =>
      __$$CredentialMenuCopyWithImpl<_$CredentialMenu>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(MenuItem menuItem) wallet,
    required TResult Function(MenuItem menuItem) connection,
    required TResult Function(MenuItem menuItem) credential,
    required TResult Function(MenuItem menuItem) proof,
  }) {
    return credential(menuItem);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(MenuItem menuItem)? wallet,
    TResult? Function(MenuItem menuItem)? connection,
    TResult? Function(MenuItem menuItem)? credential,
    TResult? Function(MenuItem menuItem)? proof,
  }) {
    return credential?.call(menuItem);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(MenuItem menuItem)? wallet,
    TResult Function(MenuItem menuItem)? connection,
    TResult Function(MenuItem menuItem)? credential,
    TResult Function(MenuItem menuItem)? proof,
    required TResult orElse(),
  }) {
    if (credential != null) {
      return credential(menuItem);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(WalletMenu value) wallet,
    required TResult Function(ConnectionMenu value) connection,
    required TResult Function(CredentialMenu value) credential,
    required TResult Function(ProofMenu value) proof,
  }) {
    return credential(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(WalletMenu value)? wallet,
    TResult? Function(ConnectionMenu value)? connection,
    TResult? Function(CredentialMenu value)? credential,
    TResult? Function(ProofMenu value)? proof,
  }) {
    return credential?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(WalletMenu value)? wallet,
    TResult Function(ConnectionMenu value)? connection,
    TResult Function(CredentialMenu value)? credential,
    TResult Function(ProofMenu value)? proof,
    required TResult orElse(),
  }) {
    if (credential != null) {
      return credential(this);
    }
    return orElse();
  }
}

abstract class CredentialMenu implements MenuNavigationState {
  const factory CredentialMenu({final MenuItem menuItem}) = _$CredentialMenu;

  @override
  MenuItem get menuItem;
  @override
  @JsonKey(ignore: true)
  _$$CredentialMenuCopyWith<_$CredentialMenu> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ProofMenuCopyWith<$Res>
    implements $MenuNavigationStateCopyWith<$Res> {
  factory _$$ProofMenuCopyWith(
          _$ProofMenu value, $Res Function(_$ProofMenu) then) =
      __$$ProofMenuCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({MenuItem menuItem});
}

/// @nodoc
class __$$ProofMenuCopyWithImpl<$Res>
    extends _$MenuNavigationStateCopyWithImpl<$Res, _$ProofMenu>
    implements _$$ProofMenuCopyWith<$Res> {
  __$$ProofMenuCopyWithImpl(
      _$ProofMenu _value, $Res Function(_$ProofMenu) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? menuItem = null,
  }) {
    return _then(_$ProofMenu(
      menuItem: null == menuItem
          ? _value.menuItem
          : menuItem // ignore: cast_nullable_to_non_nullable
              as MenuItem,
    ));
  }
}

/// @nodoc

class _$ProofMenu implements ProofMenu {
  const _$ProofMenu({this.menuItem = MenuItem.proof});

  @override
  @JsonKey()
  final MenuItem menuItem;

  @override
  String toString() {
    return 'MenuNavigationState.proof(menuItem: $menuItem)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProofMenu &&
            (identical(other.menuItem, menuItem) ||
                other.menuItem == menuItem));
  }

  @override
  int get hashCode => Object.hash(runtimeType, menuItem);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProofMenuCopyWith<_$ProofMenu> get copyWith =>
      __$$ProofMenuCopyWithImpl<_$ProofMenu>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(MenuItem menuItem) wallet,
    required TResult Function(MenuItem menuItem) connection,
    required TResult Function(MenuItem menuItem) credential,
    required TResult Function(MenuItem menuItem) proof,
  }) {
    return proof(menuItem);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(MenuItem menuItem)? wallet,
    TResult? Function(MenuItem menuItem)? connection,
    TResult? Function(MenuItem menuItem)? credential,
    TResult? Function(MenuItem menuItem)? proof,
  }) {
    return proof?.call(menuItem);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(MenuItem menuItem)? wallet,
    TResult Function(MenuItem menuItem)? connection,
    TResult Function(MenuItem menuItem)? credential,
    TResult Function(MenuItem menuItem)? proof,
    required TResult orElse(),
  }) {
    if (proof != null) {
      return proof(menuItem);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(WalletMenu value) wallet,
    required TResult Function(ConnectionMenu value) connection,
    required TResult Function(CredentialMenu value) credential,
    required TResult Function(ProofMenu value) proof,
  }) {
    return proof(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(WalletMenu value)? wallet,
    TResult? Function(ConnectionMenu value)? connection,
    TResult? Function(CredentialMenu value)? credential,
    TResult? Function(ProofMenu value)? proof,
  }) {
    return proof?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(WalletMenu value)? wallet,
    TResult Function(ConnectionMenu value)? connection,
    TResult Function(CredentialMenu value)? credential,
    TResult Function(ProofMenu value)? proof,
    required TResult orElse(),
  }) {
    if (proof != null) {
      return proof(this);
    }
    return orElse();
  }
}

abstract class ProofMenu implements MenuNavigationState {
  const factory ProofMenu({final MenuItem menuItem}) = _$ProofMenu;

  @override
  MenuItem get menuItem;
  @override
  @JsonKey(ignore: true)
  _$$ProofMenuCopyWith<_$ProofMenu> get copyWith =>
      throw _privateConstructorUsedError;
}
