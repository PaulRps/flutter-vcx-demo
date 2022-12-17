// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'wallet_page.state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$WalletInitialState {
  String? get walletKey => throw _privateConstructorUsedError;
  String? get walletName => throw _privateConstructorUsedError;
  bool get isWalletOpened => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $WalletInitialStateCopyWith<WalletInitialState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WalletInitialStateCopyWith<$Res> {
  factory $WalletInitialStateCopyWith(
          WalletInitialState value, $Res Function(WalletInitialState) then) =
      _$WalletInitialStateCopyWithImpl<$Res, WalletInitialState>;
  @useResult
  $Res call({String? walletKey, String? walletName, bool isWalletOpened});
}

/// @nodoc
class _$WalletInitialStateCopyWithImpl<$Res, $Val extends WalletInitialState>
    implements $WalletInitialStateCopyWith<$Res> {
  _$WalletInitialStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? walletKey = freezed,
    Object? walletName = freezed,
    Object? isWalletOpened = null,
  }) {
    return _then(_value.copyWith(
      walletKey: freezed == walletKey
          ? _value.walletKey
          : walletKey // ignore: cast_nullable_to_non_nullable
              as String?,
      walletName: freezed == walletName
          ? _value.walletName
          : walletName // ignore: cast_nullable_to_non_nullable
              as String?,
      isWalletOpened: null == isWalletOpened
          ? _value.isWalletOpened
          : isWalletOpened // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_WalletInitialStateCopyWith<$Res>
    implements $WalletInitialStateCopyWith<$Res> {
  factory _$$_WalletInitialStateCopyWith(_$_WalletInitialState value,
          $Res Function(_$_WalletInitialState) then) =
      __$$_WalletInitialStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? walletKey, String? walletName, bool isWalletOpened});
}

/// @nodoc
class __$$_WalletInitialStateCopyWithImpl<$Res>
    extends _$WalletInitialStateCopyWithImpl<$Res, _$_WalletInitialState>
    implements _$$_WalletInitialStateCopyWith<$Res> {
  __$$_WalletInitialStateCopyWithImpl(
      _$_WalletInitialState _value, $Res Function(_$_WalletInitialState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? walletKey = freezed,
    Object? walletName = freezed,
    Object? isWalletOpened = null,
  }) {
    return _then(_$_WalletInitialState(
      walletKey: freezed == walletKey
          ? _value.walletKey
          : walletKey // ignore: cast_nullable_to_non_nullable
              as String?,
      walletName: freezed == walletName
          ? _value.walletName
          : walletName // ignore: cast_nullable_to_non_nullable
              as String?,
      isWalletOpened: null == isWalletOpened
          ? _value.isWalletOpened
          : isWalletOpened // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_WalletInitialState implements _WalletInitialState {
  _$_WalletInitialState(
      {this.walletKey, this.walletName, this.isWalletOpened = false});

  @override
  final String? walletKey;
  @override
  final String? walletName;
  @override
  @JsonKey()
  final bool isWalletOpened;

  @override
  String toString() {
    return 'WalletInitialState(walletKey: $walletKey, walletName: $walletName, isWalletOpened: $isWalletOpened)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_WalletInitialState &&
            (identical(other.walletKey, walletKey) ||
                other.walletKey == walletKey) &&
            (identical(other.walletName, walletName) ||
                other.walletName == walletName) &&
            (identical(other.isWalletOpened, isWalletOpened) ||
                other.isWalletOpened == isWalletOpened));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, walletKey, walletName, isWalletOpened);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_WalletInitialStateCopyWith<_$_WalletInitialState> get copyWith =>
      __$$_WalletInitialStateCopyWithImpl<_$_WalletInitialState>(
          this, _$identity);
}

abstract class _WalletInitialState implements WalletInitialState {
  factory _WalletInitialState(
      {final String? walletKey,
      final String? walletName,
      final bool isWalletOpened}) = _$_WalletInitialState;

  @override
  String? get walletKey;
  @override
  String? get walletName;
  @override
  bool get isWalletOpened;
  @override
  @JsonKey(ignore: true)
  _$$_WalletInitialStateCopyWith<_$_WalletInitialState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$RetrieveWalletDataState {
  String? get walletKey => throw _privateConstructorUsedError;
  String? get walletName => throw _privateConstructorUsedError;
  bool get isWalletOpened => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RetrieveWalletDataStateCopyWith<RetrieveWalletDataState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RetrieveWalletDataStateCopyWith<$Res> {
  factory $RetrieveWalletDataStateCopyWith(RetrieveWalletDataState value,
          $Res Function(RetrieveWalletDataState) then) =
      _$RetrieveWalletDataStateCopyWithImpl<$Res, RetrieveWalletDataState>;
  @useResult
  $Res call({String? walletKey, String? walletName, bool isWalletOpened});
}

/// @nodoc
class _$RetrieveWalletDataStateCopyWithImpl<$Res,
        $Val extends RetrieveWalletDataState>
    implements $RetrieveWalletDataStateCopyWith<$Res> {
  _$RetrieveWalletDataStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? walletKey = freezed,
    Object? walletName = freezed,
    Object? isWalletOpened = null,
  }) {
    return _then(_value.copyWith(
      walletKey: freezed == walletKey
          ? _value.walletKey
          : walletKey // ignore: cast_nullable_to_non_nullable
              as String?,
      walletName: freezed == walletName
          ? _value.walletName
          : walletName // ignore: cast_nullable_to_non_nullable
              as String?,
      isWalletOpened: null == isWalletOpened
          ? _value.isWalletOpened
          : isWalletOpened // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_RetrieveWalletDataStateCopyWith<$Res>
    implements $RetrieveWalletDataStateCopyWith<$Res> {
  factory _$$_RetrieveWalletDataStateCopyWith(_$_RetrieveWalletDataState value,
          $Res Function(_$_RetrieveWalletDataState) then) =
      __$$_RetrieveWalletDataStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? walletKey, String? walletName, bool isWalletOpened});
}

/// @nodoc
class __$$_RetrieveWalletDataStateCopyWithImpl<$Res>
    extends _$RetrieveWalletDataStateCopyWithImpl<$Res,
        _$_RetrieveWalletDataState>
    implements _$$_RetrieveWalletDataStateCopyWith<$Res> {
  __$$_RetrieveWalletDataStateCopyWithImpl(_$_RetrieveWalletDataState _value,
      $Res Function(_$_RetrieveWalletDataState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? walletKey = freezed,
    Object? walletName = freezed,
    Object? isWalletOpened = null,
  }) {
    return _then(_$_RetrieveWalletDataState(
      walletKey: freezed == walletKey
          ? _value.walletKey
          : walletKey // ignore: cast_nullable_to_non_nullable
              as String?,
      walletName: freezed == walletName
          ? _value.walletName
          : walletName // ignore: cast_nullable_to_non_nullable
              as String?,
      isWalletOpened: null == isWalletOpened
          ? _value.isWalletOpened
          : isWalletOpened // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_RetrieveWalletDataState implements _RetrieveWalletDataState {
  _$_RetrieveWalletDataState(
      {required this.walletKey,
      required this.walletName,
      this.isWalletOpened = false});

  @override
  final String? walletKey;
  @override
  final String? walletName;
  @override
  @JsonKey()
  final bool isWalletOpened;

  @override
  String toString() {
    return 'RetrieveWalletDataState(walletKey: $walletKey, walletName: $walletName, isWalletOpened: $isWalletOpened)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RetrieveWalletDataState &&
            (identical(other.walletKey, walletKey) ||
                other.walletKey == walletKey) &&
            (identical(other.walletName, walletName) ||
                other.walletName == walletName) &&
            (identical(other.isWalletOpened, isWalletOpened) ||
                other.isWalletOpened == isWalletOpened));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, walletKey, walletName, isWalletOpened);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_RetrieveWalletDataStateCopyWith<_$_RetrieveWalletDataState>
      get copyWith =>
          __$$_RetrieveWalletDataStateCopyWithImpl<_$_RetrieveWalletDataState>(
              this, _$identity);
}

abstract class _RetrieveWalletDataState implements RetrieveWalletDataState {
  factory _RetrieveWalletDataState(
      {required final String? walletKey,
      required final String? walletName,
      final bool isWalletOpened}) = _$_RetrieveWalletDataState;

  @override
  String? get walletKey;
  @override
  String? get walletName;
  @override
  bool get isWalletOpened;
  @override
  @JsonKey(ignore: true)
  _$$_RetrieveWalletDataStateCopyWith<_$_RetrieveWalletDataState>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$WalletErrorState {
  String? get walletKey => throw _privateConstructorUsedError;
  String? get walletName => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;
  bool get isWalletOpened => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $WalletErrorStateCopyWith<WalletErrorState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WalletErrorStateCopyWith<$Res> {
  factory $WalletErrorStateCopyWith(
          WalletErrorState value, $Res Function(WalletErrorState) then) =
      _$WalletErrorStateCopyWithImpl<$Res, WalletErrorState>;
  @useResult
  $Res call(
      {String? walletKey,
      String? walletName,
      String? errorMessage,
      bool isWalletOpened});
}

/// @nodoc
class _$WalletErrorStateCopyWithImpl<$Res, $Val extends WalletErrorState>
    implements $WalletErrorStateCopyWith<$Res> {
  _$WalletErrorStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? walletKey = freezed,
    Object? walletName = freezed,
    Object? errorMessage = freezed,
    Object? isWalletOpened = null,
  }) {
    return _then(_value.copyWith(
      walletKey: freezed == walletKey
          ? _value.walletKey
          : walletKey // ignore: cast_nullable_to_non_nullable
              as String?,
      walletName: freezed == walletName
          ? _value.walletName
          : walletName // ignore: cast_nullable_to_non_nullable
              as String?,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      isWalletOpened: null == isWalletOpened
          ? _value.isWalletOpened
          : isWalletOpened // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_WalletErrorStateCopyWith<$Res>
    implements $WalletErrorStateCopyWith<$Res> {
  factory _$$_WalletErrorStateCopyWith(
          _$_WalletErrorState value, $Res Function(_$_WalletErrorState) then) =
      __$$_WalletErrorStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? walletKey,
      String? walletName,
      String? errorMessage,
      bool isWalletOpened});
}

/// @nodoc
class __$$_WalletErrorStateCopyWithImpl<$Res>
    extends _$WalletErrorStateCopyWithImpl<$Res, _$_WalletErrorState>
    implements _$$_WalletErrorStateCopyWith<$Res> {
  __$$_WalletErrorStateCopyWithImpl(
      _$_WalletErrorState _value, $Res Function(_$_WalletErrorState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? walletKey = freezed,
    Object? walletName = freezed,
    Object? errorMessage = freezed,
    Object? isWalletOpened = null,
  }) {
    return _then(_$_WalletErrorState(
      walletKey: freezed == walletKey
          ? _value.walletKey
          : walletKey // ignore: cast_nullable_to_non_nullable
              as String?,
      walletName: freezed == walletName
          ? _value.walletName
          : walletName // ignore: cast_nullable_to_non_nullable
              as String?,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      isWalletOpened: null == isWalletOpened
          ? _value.isWalletOpened
          : isWalletOpened // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_WalletErrorState implements _WalletErrorState {
  _$_WalletErrorState(
      {this.walletKey,
      this.walletName,
      required this.errorMessage,
      this.isWalletOpened = false});

  @override
  final String? walletKey;
  @override
  final String? walletName;
  @override
  final String? errorMessage;
  @override
  @JsonKey()
  final bool isWalletOpened;

  @override
  String toString() {
    return 'WalletErrorState(walletKey: $walletKey, walletName: $walletName, errorMessage: $errorMessage, isWalletOpened: $isWalletOpened)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_WalletErrorState &&
            (identical(other.walletKey, walletKey) ||
                other.walletKey == walletKey) &&
            (identical(other.walletName, walletName) ||
                other.walletName == walletName) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.isWalletOpened, isWalletOpened) ||
                other.isWalletOpened == isWalletOpened));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, walletKey, walletName, errorMessage, isWalletOpened);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_WalletErrorStateCopyWith<_$_WalletErrorState> get copyWith =>
      __$$_WalletErrorStateCopyWithImpl<_$_WalletErrorState>(this, _$identity);
}

abstract class _WalletErrorState implements WalletErrorState {
  factory _WalletErrorState(
      {final String? walletKey,
      final String? walletName,
      required final String? errorMessage,
      final bool isWalletOpened}) = _$_WalletErrorState;

  @override
  String? get walletKey;
  @override
  String? get walletName;
  @override
  String? get errorMessage;
  @override
  bool get isWalletOpened;
  @override
  @JsonKey(ignore: true)
  _$$_WalletErrorStateCopyWith<_$_WalletErrorState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$WalletAlreadyOpenedState {
  String? get walletKey => throw _privateConstructorUsedError;
  String? get walletName => throw _privateConstructorUsedError;
  bool get isWalletOpened => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $WalletAlreadyOpenedStateCopyWith<WalletAlreadyOpenedState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WalletAlreadyOpenedStateCopyWith<$Res> {
  factory $WalletAlreadyOpenedStateCopyWith(WalletAlreadyOpenedState value,
          $Res Function(WalletAlreadyOpenedState) then) =
      _$WalletAlreadyOpenedStateCopyWithImpl<$Res, WalletAlreadyOpenedState>;
  @useResult
  $Res call({String? walletKey, String? walletName, bool isWalletOpened});
}

/// @nodoc
class _$WalletAlreadyOpenedStateCopyWithImpl<$Res,
        $Val extends WalletAlreadyOpenedState>
    implements $WalletAlreadyOpenedStateCopyWith<$Res> {
  _$WalletAlreadyOpenedStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? walletKey = freezed,
    Object? walletName = freezed,
    Object? isWalletOpened = null,
  }) {
    return _then(_value.copyWith(
      walletKey: freezed == walletKey
          ? _value.walletKey
          : walletKey // ignore: cast_nullable_to_non_nullable
              as String?,
      walletName: freezed == walletName
          ? _value.walletName
          : walletName // ignore: cast_nullable_to_non_nullable
              as String?,
      isWalletOpened: null == isWalletOpened
          ? _value.isWalletOpened
          : isWalletOpened // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_WalletAlreadyOpenedStateCopyWith<$Res>
    implements $WalletAlreadyOpenedStateCopyWith<$Res> {
  factory _$$_WalletAlreadyOpenedStateCopyWith(
          _$_WalletAlreadyOpenedState value,
          $Res Function(_$_WalletAlreadyOpenedState) then) =
      __$$_WalletAlreadyOpenedStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? walletKey, String? walletName, bool isWalletOpened});
}

/// @nodoc
class __$$_WalletAlreadyOpenedStateCopyWithImpl<$Res>
    extends _$WalletAlreadyOpenedStateCopyWithImpl<$Res,
        _$_WalletAlreadyOpenedState>
    implements _$$_WalletAlreadyOpenedStateCopyWith<$Res> {
  __$$_WalletAlreadyOpenedStateCopyWithImpl(_$_WalletAlreadyOpenedState _value,
      $Res Function(_$_WalletAlreadyOpenedState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? walletKey = freezed,
    Object? walletName = freezed,
    Object? isWalletOpened = null,
  }) {
    return _then(_$_WalletAlreadyOpenedState(
      walletKey: freezed == walletKey
          ? _value.walletKey
          : walletKey // ignore: cast_nullable_to_non_nullable
              as String?,
      walletName: freezed == walletName
          ? _value.walletName
          : walletName // ignore: cast_nullable_to_non_nullable
              as String?,
      isWalletOpened: null == isWalletOpened
          ? _value.isWalletOpened
          : isWalletOpened // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_WalletAlreadyOpenedState implements _WalletAlreadyOpenedState {
  _$_WalletAlreadyOpenedState(
      {this.walletKey, this.walletName, this.isWalletOpened = true});

  @override
  final String? walletKey;
  @override
  final String? walletName;
  @override
  @JsonKey()
  final bool isWalletOpened;

  @override
  String toString() {
    return 'WalletAlreadyOpenedState(walletKey: $walletKey, walletName: $walletName, isWalletOpened: $isWalletOpened)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_WalletAlreadyOpenedState &&
            (identical(other.walletKey, walletKey) ||
                other.walletKey == walletKey) &&
            (identical(other.walletName, walletName) ||
                other.walletName == walletName) &&
            (identical(other.isWalletOpened, isWalletOpened) ||
                other.isWalletOpened == isWalletOpened));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, walletKey, walletName, isWalletOpened);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_WalletAlreadyOpenedStateCopyWith<_$_WalletAlreadyOpenedState>
      get copyWith => __$$_WalletAlreadyOpenedStateCopyWithImpl<
          _$_WalletAlreadyOpenedState>(this, _$identity);
}

abstract class _WalletAlreadyOpenedState implements WalletAlreadyOpenedState {
  factory _WalletAlreadyOpenedState(
      {final String? walletKey,
      final String? walletName,
      final bool isWalletOpened}) = _$_WalletAlreadyOpenedState;

  @override
  String? get walletKey;
  @override
  String? get walletName;
  @override
  bool get isWalletOpened;
  @override
  @JsonKey(ignore: true)
  _$$_WalletAlreadyOpenedStateCopyWith<_$_WalletAlreadyOpenedState>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$WalletAreNotOpenedState {
  String? get walletKey => throw _privateConstructorUsedError;
  String? get walletName => throw _privateConstructorUsedError;
  bool get isWalletOpened => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $WalletAreNotOpenedStateCopyWith<WalletAreNotOpenedState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WalletAreNotOpenedStateCopyWith<$Res> {
  factory $WalletAreNotOpenedStateCopyWith(WalletAreNotOpenedState value,
          $Res Function(WalletAreNotOpenedState) then) =
      _$WalletAreNotOpenedStateCopyWithImpl<$Res, WalletAreNotOpenedState>;
  @useResult
  $Res call({String? walletKey, String? walletName, bool isWalletOpened});
}

/// @nodoc
class _$WalletAreNotOpenedStateCopyWithImpl<$Res,
        $Val extends WalletAreNotOpenedState>
    implements $WalletAreNotOpenedStateCopyWith<$Res> {
  _$WalletAreNotOpenedStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? walletKey = freezed,
    Object? walletName = freezed,
    Object? isWalletOpened = null,
  }) {
    return _then(_value.copyWith(
      walletKey: freezed == walletKey
          ? _value.walletKey
          : walletKey // ignore: cast_nullable_to_non_nullable
              as String?,
      walletName: freezed == walletName
          ? _value.walletName
          : walletName // ignore: cast_nullable_to_non_nullable
              as String?,
      isWalletOpened: null == isWalletOpened
          ? _value.isWalletOpened
          : isWalletOpened // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_WalletAreNotOpenedStateCopyWith<$Res>
    implements $WalletAreNotOpenedStateCopyWith<$Res> {
  factory _$$_WalletAreNotOpenedStateCopyWith(_$_WalletAreNotOpenedState value,
          $Res Function(_$_WalletAreNotOpenedState) then) =
      __$$_WalletAreNotOpenedStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? walletKey, String? walletName, bool isWalletOpened});
}

/// @nodoc
class __$$_WalletAreNotOpenedStateCopyWithImpl<$Res>
    extends _$WalletAreNotOpenedStateCopyWithImpl<$Res,
        _$_WalletAreNotOpenedState>
    implements _$$_WalletAreNotOpenedStateCopyWith<$Res> {
  __$$_WalletAreNotOpenedStateCopyWithImpl(_$_WalletAreNotOpenedState _value,
      $Res Function(_$_WalletAreNotOpenedState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? walletKey = freezed,
    Object? walletName = freezed,
    Object? isWalletOpened = null,
  }) {
    return _then(_$_WalletAreNotOpenedState(
      walletKey: freezed == walletKey
          ? _value.walletKey
          : walletKey // ignore: cast_nullable_to_non_nullable
              as String?,
      walletName: freezed == walletName
          ? _value.walletName
          : walletName // ignore: cast_nullable_to_non_nullable
              as String?,
      isWalletOpened: null == isWalletOpened
          ? _value.isWalletOpened
          : isWalletOpened // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_WalletAreNotOpenedState implements _WalletAreNotOpenedState {
  _$_WalletAreNotOpenedState(
      {this.walletKey, this.walletName, this.isWalletOpened = false});

  @override
  final String? walletKey;
  @override
  final String? walletName;
  @override
  @JsonKey()
  final bool isWalletOpened;

  @override
  String toString() {
    return 'WalletAreNotOpenedState(walletKey: $walletKey, walletName: $walletName, isWalletOpened: $isWalletOpened)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_WalletAreNotOpenedState &&
            (identical(other.walletKey, walletKey) ||
                other.walletKey == walletKey) &&
            (identical(other.walletName, walletName) ||
                other.walletName == walletName) &&
            (identical(other.isWalletOpened, isWalletOpened) ||
                other.isWalletOpened == isWalletOpened));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, walletKey, walletName, isWalletOpened);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_WalletAreNotOpenedStateCopyWith<_$_WalletAreNotOpenedState>
      get copyWith =>
          __$$_WalletAreNotOpenedStateCopyWithImpl<_$_WalletAreNotOpenedState>(
              this, _$identity);
}

abstract class _WalletAreNotOpenedState implements WalletAreNotOpenedState {
  factory _WalletAreNotOpenedState(
      {final String? walletKey,
      final String? walletName,
      final bool isWalletOpened}) = _$_WalletAreNotOpenedState;

  @override
  String? get walletKey;
  @override
  String? get walletName;
  @override
  bool get isWalletOpened;
  @override
  @JsonKey(ignore: true)
  _$$_WalletAreNotOpenedStateCopyWith<_$_WalletAreNotOpenedState>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$WalletOpenedState {
  String? get walletKey => throw _privateConstructorUsedError;
  String? get walletName => throw _privateConstructorUsedError;
  bool get isWalletOpened => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $WalletOpenedStateCopyWith<WalletOpenedState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WalletOpenedStateCopyWith<$Res> {
  factory $WalletOpenedStateCopyWith(
          WalletOpenedState value, $Res Function(WalletOpenedState) then) =
      _$WalletOpenedStateCopyWithImpl<$Res, WalletOpenedState>;
  @useResult
  $Res call({String? walletKey, String? walletName, bool isWalletOpened});
}

/// @nodoc
class _$WalletOpenedStateCopyWithImpl<$Res, $Val extends WalletOpenedState>
    implements $WalletOpenedStateCopyWith<$Res> {
  _$WalletOpenedStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? walletKey = freezed,
    Object? walletName = freezed,
    Object? isWalletOpened = null,
  }) {
    return _then(_value.copyWith(
      walletKey: freezed == walletKey
          ? _value.walletKey
          : walletKey // ignore: cast_nullable_to_non_nullable
              as String?,
      walletName: freezed == walletName
          ? _value.walletName
          : walletName // ignore: cast_nullable_to_non_nullable
              as String?,
      isWalletOpened: null == isWalletOpened
          ? _value.isWalletOpened
          : isWalletOpened // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_WalletOpenedStateCopyWith<$Res>
    implements $WalletOpenedStateCopyWith<$Res> {
  factory _$$_WalletOpenedStateCopyWith(_$_WalletOpenedState value,
          $Res Function(_$_WalletOpenedState) then) =
      __$$_WalletOpenedStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? walletKey, String? walletName, bool isWalletOpened});
}

/// @nodoc
class __$$_WalletOpenedStateCopyWithImpl<$Res>
    extends _$WalletOpenedStateCopyWithImpl<$Res, _$_WalletOpenedState>
    implements _$$_WalletOpenedStateCopyWith<$Res> {
  __$$_WalletOpenedStateCopyWithImpl(
      _$_WalletOpenedState _value, $Res Function(_$_WalletOpenedState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? walletKey = freezed,
    Object? walletName = freezed,
    Object? isWalletOpened = null,
  }) {
    return _then(_$_WalletOpenedState(
      walletKey: freezed == walletKey
          ? _value.walletKey
          : walletKey // ignore: cast_nullable_to_non_nullable
              as String?,
      walletName: freezed == walletName
          ? _value.walletName
          : walletName // ignore: cast_nullable_to_non_nullable
              as String?,
      isWalletOpened: null == isWalletOpened
          ? _value.isWalletOpened
          : isWalletOpened // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_WalletOpenedState implements _WalletOpenedState {
  _$_WalletOpenedState(
      {this.walletKey, this.walletName, this.isWalletOpened = true});

  @override
  final String? walletKey;
  @override
  final String? walletName;
  @override
  @JsonKey()
  final bool isWalletOpened;

  @override
  String toString() {
    return 'WalletOpenedState(walletKey: $walletKey, walletName: $walletName, isWalletOpened: $isWalletOpened)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_WalletOpenedState &&
            (identical(other.walletKey, walletKey) ||
                other.walletKey == walletKey) &&
            (identical(other.walletName, walletName) ||
                other.walletName == walletName) &&
            (identical(other.isWalletOpened, isWalletOpened) ||
                other.isWalletOpened == isWalletOpened));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, walletKey, walletName, isWalletOpened);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_WalletOpenedStateCopyWith<_$_WalletOpenedState> get copyWith =>
      __$$_WalletOpenedStateCopyWithImpl<_$_WalletOpenedState>(
          this, _$identity);
}

abstract class _WalletOpenedState implements WalletOpenedState {
  factory _WalletOpenedState(
      {final String? walletKey,
      final String? walletName,
      final bool isWalletOpened}) = _$_WalletOpenedState;

  @override
  String? get walletKey;
  @override
  String? get walletName;
  @override
  bool get isWalletOpened;
  @override
  @JsonKey(ignore: true)
  _$$_WalletOpenedStateCopyWith<_$_WalletOpenedState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$WalletClosedState {
  String? get walletKey => throw _privateConstructorUsedError;
  String? get walletName => throw _privateConstructorUsedError;
  bool get isWalletOpened => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $WalletClosedStateCopyWith<WalletClosedState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WalletClosedStateCopyWith<$Res> {
  factory $WalletClosedStateCopyWith(
          WalletClosedState value, $Res Function(WalletClosedState) then) =
      _$WalletClosedStateCopyWithImpl<$Res, WalletClosedState>;
  @useResult
  $Res call({String? walletKey, String? walletName, bool isWalletOpened});
}

/// @nodoc
class _$WalletClosedStateCopyWithImpl<$Res, $Val extends WalletClosedState>
    implements $WalletClosedStateCopyWith<$Res> {
  _$WalletClosedStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? walletKey = freezed,
    Object? walletName = freezed,
    Object? isWalletOpened = null,
  }) {
    return _then(_value.copyWith(
      walletKey: freezed == walletKey
          ? _value.walletKey
          : walletKey // ignore: cast_nullable_to_non_nullable
              as String?,
      walletName: freezed == walletName
          ? _value.walletName
          : walletName // ignore: cast_nullable_to_non_nullable
              as String?,
      isWalletOpened: null == isWalletOpened
          ? _value.isWalletOpened
          : isWalletOpened // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_WalletClosedStateCopyWith<$Res>
    implements $WalletClosedStateCopyWith<$Res> {
  factory _$$_WalletClosedStateCopyWith(_$_WalletClosedState value,
          $Res Function(_$_WalletClosedState) then) =
      __$$_WalletClosedStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? walletKey, String? walletName, bool isWalletOpened});
}

/// @nodoc
class __$$_WalletClosedStateCopyWithImpl<$Res>
    extends _$WalletClosedStateCopyWithImpl<$Res, _$_WalletClosedState>
    implements _$$_WalletClosedStateCopyWith<$Res> {
  __$$_WalletClosedStateCopyWithImpl(
      _$_WalletClosedState _value, $Res Function(_$_WalletClosedState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? walletKey = freezed,
    Object? walletName = freezed,
    Object? isWalletOpened = null,
  }) {
    return _then(_$_WalletClosedState(
      walletKey: freezed == walletKey
          ? _value.walletKey
          : walletKey // ignore: cast_nullable_to_non_nullable
              as String?,
      walletName: freezed == walletName
          ? _value.walletName
          : walletName // ignore: cast_nullable_to_non_nullable
              as String?,
      isWalletOpened: null == isWalletOpened
          ? _value.isWalletOpened
          : isWalletOpened // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_WalletClosedState implements _WalletClosedState {
  _$_WalletClosedState(
      {this.walletKey, this.walletName, this.isWalletOpened = false});

  @override
  final String? walletKey;
  @override
  final String? walletName;
  @override
  @JsonKey()
  final bool isWalletOpened;

  @override
  String toString() {
    return 'WalletClosedState(walletKey: $walletKey, walletName: $walletName, isWalletOpened: $isWalletOpened)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_WalletClosedState &&
            (identical(other.walletKey, walletKey) ||
                other.walletKey == walletKey) &&
            (identical(other.walletName, walletName) ||
                other.walletName == walletName) &&
            (identical(other.isWalletOpened, isWalletOpened) ||
                other.isWalletOpened == isWalletOpened));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, walletKey, walletName, isWalletOpened);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_WalletClosedStateCopyWith<_$_WalletClosedState> get copyWith =>
      __$$_WalletClosedStateCopyWithImpl<_$_WalletClosedState>(
          this, _$identity);
}

abstract class _WalletClosedState implements WalletClosedState {
  factory _WalletClosedState(
      {final String? walletKey,
      final String? walletName,
      final bool isWalletOpened}) = _$_WalletClosedState;

  @override
  String? get walletKey;
  @override
  String? get walletName;
  @override
  bool get isWalletOpened;
  @override
  @JsonKey(ignore: true)
  _$$_WalletClosedStateCopyWith<_$_WalletClosedState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$WalletDeletedState {
  String? get walletKey => throw _privateConstructorUsedError;
  String? get walletName => throw _privateConstructorUsedError;
  bool get isWalletOpened => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $WalletDeletedStateCopyWith<WalletDeletedState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WalletDeletedStateCopyWith<$Res> {
  factory $WalletDeletedStateCopyWith(
          WalletDeletedState value, $Res Function(WalletDeletedState) then) =
      _$WalletDeletedStateCopyWithImpl<$Res, WalletDeletedState>;
  @useResult
  $Res call({String? walletKey, String? walletName, bool isWalletOpened});
}

/// @nodoc
class _$WalletDeletedStateCopyWithImpl<$Res, $Val extends WalletDeletedState>
    implements $WalletDeletedStateCopyWith<$Res> {
  _$WalletDeletedStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? walletKey = freezed,
    Object? walletName = freezed,
    Object? isWalletOpened = null,
  }) {
    return _then(_value.copyWith(
      walletKey: freezed == walletKey
          ? _value.walletKey
          : walletKey // ignore: cast_nullable_to_non_nullable
              as String?,
      walletName: freezed == walletName
          ? _value.walletName
          : walletName // ignore: cast_nullable_to_non_nullable
              as String?,
      isWalletOpened: null == isWalletOpened
          ? _value.isWalletOpened
          : isWalletOpened // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_WalletDeletedStateCopyWith<$Res>
    implements $WalletDeletedStateCopyWith<$Res> {
  factory _$$_WalletDeletedStateCopyWith(_$_WalletDeletedState value,
          $Res Function(_$_WalletDeletedState) then) =
      __$$_WalletDeletedStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? walletKey, String? walletName, bool isWalletOpened});
}

/// @nodoc
class __$$_WalletDeletedStateCopyWithImpl<$Res>
    extends _$WalletDeletedStateCopyWithImpl<$Res, _$_WalletDeletedState>
    implements _$$_WalletDeletedStateCopyWith<$Res> {
  __$$_WalletDeletedStateCopyWithImpl(
      _$_WalletDeletedState _value, $Res Function(_$_WalletDeletedState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? walletKey = freezed,
    Object? walletName = freezed,
    Object? isWalletOpened = null,
  }) {
    return _then(_$_WalletDeletedState(
      walletKey: freezed == walletKey
          ? _value.walletKey
          : walletKey // ignore: cast_nullable_to_non_nullable
              as String?,
      walletName: freezed == walletName
          ? _value.walletName
          : walletName // ignore: cast_nullable_to_non_nullable
              as String?,
      isWalletOpened: null == isWalletOpened
          ? _value.isWalletOpened
          : isWalletOpened // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_WalletDeletedState implements _WalletDeletedState {
  _$_WalletDeletedState(
      {this.walletKey, this.walletName, this.isWalletOpened = false});

  @override
  final String? walletKey;
  @override
  final String? walletName;
  @override
  @JsonKey()
  final bool isWalletOpened;

  @override
  String toString() {
    return 'WalletDeletedState(walletKey: $walletKey, walletName: $walletName, isWalletOpened: $isWalletOpened)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_WalletDeletedState &&
            (identical(other.walletKey, walletKey) ||
                other.walletKey == walletKey) &&
            (identical(other.walletName, walletName) ||
                other.walletName == walletName) &&
            (identical(other.isWalletOpened, isWalletOpened) ||
                other.isWalletOpened == isWalletOpened));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, walletKey, walletName, isWalletOpened);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_WalletDeletedStateCopyWith<_$_WalletDeletedState> get copyWith =>
      __$$_WalletDeletedStateCopyWithImpl<_$_WalletDeletedState>(
          this, _$identity);
}

abstract class _WalletDeletedState implements WalletDeletedState {
  factory _WalletDeletedState(
      {final String? walletKey,
      final String? walletName,
      final bool isWalletOpened}) = _$_WalletDeletedState;

  @override
  String? get walletKey;
  @override
  String? get walletName;
  @override
  bool get isWalletOpened;
  @override
  @JsonKey(ignore: true)
  _$$_WalletDeletedStateCopyWith<_$_WalletDeletedState> get copyWith =>
      throw _privateConstructorUsedError;
}
