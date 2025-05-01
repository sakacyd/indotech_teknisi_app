part of 'assignment_bloc.dart';

@immutable
sealed class AssignmentEvent {}

/* final class AssignmentUpload extends AssignmentEvent {
  final String title;
  final String content;
  final String posterId;
  final File image;
  final List<String> topics;

  AssignmentUpload({
    required this.title,
    required this.content,
    required this.posterId,
    required this.image,
    required this.topics,
  });
} */

final class AssignmentFetchAll extends AssignmentEvent {}