import 'dart:io';

import 'package:indotech_teknisi_app/core/error/failures.dart';
import 'package:indotech_teknisi_app/features/assignment/domain/entities/assignment.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AssignmentRepository {
  /* Future<Either<Failure, Assignment>> uploadBlog({
    required File image,
    required String title,
    required String content,
    required String posterId,
    required List<String> topics,
  }); */

  Future<Either<Failure, List<Assignment>>> getAllAssignments();
}