abstract class Failure {
  final String message;
  final String context;

  Failure({this.context = '', this.message = ''});
}