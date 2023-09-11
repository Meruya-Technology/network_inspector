abstract class UseCase<T, P> {
  Future<T> build(P param);

  Future<T> execute(P param) async {
    /// Validate usecase
    /// Execute
    /// ignore: body_might_complete_normally_catch_error
    return await build(param).catchError((error) {
      handleError(error);
    });
  }

  Future<void> handleError(dynamic error);
}
