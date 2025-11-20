sealed class FBResult<T> {}

class FBSuccess<T> extends FBResult<T> {
  final T? data;
  FBSuccess({this.data});
}

class FBError<T> extends FBResult<T> {
  final String message;
  FBError({required this.message});
}
