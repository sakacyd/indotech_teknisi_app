import 'dart:io';

import 'package:flutter/material.dart';
import 'package:indotech_teknisi_app/core/error/exceptions.dart';
import 'package:indotech_teknisi_app/features/assignment/data/models/assignment_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AssignmentRemoteDataSource {
  /* Future<AssignmentModel> uploadBlog(AssignmentModel assignment);
  Future<String> uploadBlogImage({
    required File image,
    required BlogModel blog,
  }); */

  Future<List<AssignmentModel>> getAllAssignments();
}

class AssignmentRemoteDataSourceImpl implements AssignmentRemoteDataSource {
  final SupabaseClient supabaseClient;

  AssignmentRemoteDataSourceImpl(this.supabaseClient);

  /* @override
  Future<BlogModel> uploadBlog(BlogModel blog) async {
    try {
      final response =
          await supabaseClient.from('blogs').insert(blog.toJson()).select();

      if (response.isEmpty) {
        throw ServerException(
          'Failed to upload blog: No response from server.',
        );
      }

      return BlogModel.fromJson(response.first);
    } on PostgrestException catch (e) {
      debugPrint('PostgrestException in uploadBlog: ${e.message}');
      throw ServerException('Database error: ${e.message}');
    } catch (e) {
      debugPrint('Unexpected error in uploadBlog: $e');
      throw ServerException('Unexpected error: $e');
    }
  }

  @override
  Future<String> uploadBlogImage({
    required File image,
    required BlogModel blog,
  }) async {
    try {
      await supabaseClient.storage.from('blog_images').upload(blog.id, image);
      return supabaseClient.storage.from('blog_images').getPublicUrl(blog.id);
    } on StorageException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  } */

  @override
  Future<List<AssignmentModel>> getAllAssignments() async {
    try {
      final res = await supabaseClient
          .from('assignments')
          .select(
            '*, customers(name, phone_number, address)',
          )
          .eq('technician_id', supabaseClient.auth.currentSession!.user.id);

      return res
          .map(
            (assignment) => AssignmentModel.fromJson(assignment).copyWith(
              customerName: assignment['customers']['name'],
              customerPhoneNumber: assignment['customers']['phone_number'],
              customerAddress: assignment['customers']['address'],
            ),
          )
          .toList();
    } on PostgrestException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}

/* abstract interface class BlogRemoteDataSource {
  Future<BlogModel> uploadBlog(BlogModel blog);
  Future<String> uploadBlogImage({
    required File image,
    required BlogModel blog,
  });

  Future<List<BlogModel>> getAllBlogs();
}

class BlogRemoteDataSourceImpl implements BlogRemoteDataSource {
  final SupabaseClient supabaseClient;

  BlogRemoteDataSourceImpl(this.supabaseClient);

  @override
  Future<BlogModel> uploadBlog(BlogModel blog) async {
    try {
      final response =
          await supabaseClient.from('blogs').insert(blog.toJson()).select();

      if (response.isEmpty) {
        throw ServerException(
          'Failed to upload blog: No response from server.',
        );
      }

      return BlogModel.fromJson(response.first);
    } on PostgrestException catch (e) {
      debugPrint('PostgrestException in uploadBlog: ${e.message}');
      throw ServerException('Database error: ${e.message}');
    } catch (e) {
      debugPrint('Unexpected error in uploadBlog: $e');
      throw ServerException('Unexpected error: $e');
    }
  }

  @override
  Future<String> uploadBlogImage({
    required File image,
    required BlogModel blog,
  }) async {
    try {
      await supabaseClient.storage.from('blog_images').upload(blog.id, image);
      return supabaseClient.storage.from('blog_images').getPublicUrl(blog.id);
    } on StorageException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<BlogModel>> getAllBlogs() async {
    try {
      final res = await supabaseClient
          .from('blogs')
          .select('*, profiles(name)');

      return res
          .map(
            (blog) => BlogModel.fromJson(
              blog,
            ).copyWith(posterName: blog['profiles']['name']),
          )
          .toList();
    } on PostgrestException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
} */
