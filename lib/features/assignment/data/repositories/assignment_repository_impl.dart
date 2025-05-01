import 'dart:io';

import 'package:indotech_teknisi_app/core/constants/constants.dart';
import 'package:indotech_teknisi_app/core/error/exceptions.dart';
import 'package:indotech_teknisi_app/core/error/failures.dart';
import 'package:indotech_teknisi_app/core/network/connection_checker.dart';
import 'package:indotech_teknisi_app/features/assignment/data/datasources/assignment_local_data_source.dart';
import 'package:indotech_teknisi_app/features/assignment/data/datasources/assignment_remote_data_source.dart';
import 'package:indotech_teknisi_app/features/assignment/data/models/assignment_model.dart';
import 'package:indotech_teknisi_app/features/assignment/domain/entities/assignment.dart';
import 'package:indotech_teknisi_app/features/assignment/domain/repositories/assignment_repositories.dart';
import 'package:fpdart/fpdart.dart';
import 'package:uuid/uuid.dart';

class AssignmentRepositoryImpl implements AssignmentRepository {
  final AssignmentRemoteDataSource assignmentRemoteDataSource;
  final AssignmentLocalDataSource assignmentLocalDataSource;
  final ConnectionChecker connectionChecker;

  AssignmentRepositoryImpl(
    this.assignmentRemoteDataSource,
    this.assignmentLocalDataSource,
    this.connectionChecker,
  );
  /* @override
  Future<Either<Failure, Blog>> uploadBlog({
    required File image,
    required String title,
    required String content,
    required String posterId,
    required List<String> topics,
  }) async {
    try {
      if (!await connectionChecker.isConnected) {
        return left(Failure(Constants.noConnectionMessage));
      }
      BlogModel blogModel = BlogModel(
        id: const Uuid().v1(),
        title: title,
        content: content,
        posterId: posterId,
        imageUrl: '',
        updatedAt: DateTime.now(),
        topics: topics,
      );

      final imageUrl = await blogRemoteDataSource.uploadBlogImage(
        image: image,
        blog: blogModel,
      );

      blogModel = blogModel.copyWith(imageUrl: imageUrl);

      final uploadedBlog = await blogRemoteDataSource.uploadBlog(blogModel);
      return right(uploadedBlog);
    } on ServerException catch (e) {
      return left(Failure(e.toString()));
    }
  } */

  @override
  Future<Either<Failure, List<Assignment>>> getAllAssignments() async {
    try {
      var assignments = <AssignmentModel>[];
      if (!await connectionChecker.isConnected) {
        assignments = assignmentLocalDataSource.getLastAssignments();
      } else {
        assignments = await assignmentRemoteDataSource.getAllAssignments();
        assignmentLocalDataSource.cacheAssignments(assignments);
      }
      return right(assignments);
    } on ServerException catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
