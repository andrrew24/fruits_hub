import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fruits_hub/core/errors/failure.dart';
import 'package:fruits_hub/core/exception/custom_exception.dart';
import 'package:fruits_hub/core/services/database_service.dart';
import 'package:fruits_hub/core/services/firebase_auth_service.dart';
import 'package:fruits_hub/core/utils/backend_endpoints.dart';
import 'package:fruits_hub/features/auth/data/model/user_model.dart';
import 'package:fruits_hub/features/auth/domain/entity/user_entity.dart';
import 'package:fruits_hub/features/auth/domain/repo/auth_repo.dart';

class AuthRepoIml implements AuthRepo {
  final FirebaseAuthService firebaseAuthService;
  final DatabaseService databaseService;

  AuthRepoIml({
    required this.firebaseAuthService,
    required this.databaseService,
  });

  @override
  Future<Either<Failure, UserEntity>> createUserwithEmailandPassword({
    required String email,
    required String password,
    required String name,
  }) async {
    User? user;
    try {
      user = await firebaseAuthService.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      UserEntity userEntity = UserEntity(
        email: email,
        uid: user.uid,
        fullName: name,
      );

      await saveUserInDatabase(userEntity: userEntity);

      return Right(userEntity);
    } on CustomException catch (e) {
      await deleteUser(user);
      return Left(ServerFailure(e.message));
    } catch (e) {
      await deleteUser(user);
      return Left(
        ServerFailure(
          'An error occurred, please try again later. ${e.toString()}',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      var user = await firebaseAuthService.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      await databaseService.getData(
        path: BackendEndpoints.usersCollection,
        uid: user.uid,
      );

      return Right(UserModel.fromFirebaseUser(user));
    } on CustomException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('An error occurred, please try again later.'));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signInWithGoogle() async {
    User? user;
    try {
      user = await firebaseAuthService.signInWithGoogle();

      UserEntity userEntity = UserEntity(
        email: user.email ?? '',
        uid: user.uid,
        fullName: user.displayName ?? '',
      );

      bool userExists = await databaseService.checkIfDataExists(
        path: BackendEndpoints.usersCollection,
        uid: user.uid,
      );

      if (!userExists) {
        await saveUserInDatabase(userEntity: userEntity);
      }

      await databaseService.getData(
        path: BackendEndpoints.usersCollection,
        uid: user.uid,
      );

      return Right(userEntity);
    } on CustomException catch (e) {
      await deleteUser(user);
      return Left(ServerFailure(e.message));
    } catch (e) {
      await deleteUser(user);
      return Left(ServerFailure('An error occurred, please try again later.'));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signInWithFacebook() async {
    User? user;
    try {
      user = await firebaseAuthService.signInWithFacebook();

      UserEntity userEntity = UserEntity(
        email: user.email ?? '',
        uid: user.uid,
        fullName: user.displayName ?? '',
      );

      bool userExists = await databaseService.checkIfDataExists(
        path: BackendEndpoints.usersCollection,
        uid: user.uid,
      );

      if (!userExists) {
        await saveUserInDatabase(userEntity: userEntity);
      }

      await databaseService.getData(
        path: BackendEndpoints.usersCollection,
        uid: user.uid,
      );

      return Right(userEntity);
    } on CustomException catch (e) {
      await deleteUser(user);
      return Left(ServerFailure(e.message));
    } catch (e) {
      await deleteUser(user);
      return Left(ServerFailure('An error occurred, please try again later.'));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signInWithApple() async{
    User? user;
    try {
      user = await firebaseAuthService.signInWithApple();

      UserEntity userEntity = UserEntity(email: user.email!, uid: user.uid, fullName: user.displayName!);

      bool userExists = await databaseService.checkIfDataExists(
        path: BackendEndpoints.usersCollection,
        uid: user.uid,
      );

      if (!userExists) {
        await saveUserInDatabase(userEntity: userEntity);
      }

      await databaseService.getData(
        path: BackendEndpoints.usersCollection,
        uid: user.uid,
      );

      return Right(userEntity);
    }on CustomException catch (e) {
      await deleteUser(user);
      return Left(ServerFailure(e.message));
    } catch (e) {
      await deleteUser(user);
      return Left(ServerFailure('An error occurred, please try again later.'));
    }
  }


  @override
  Future saveUserInDatabase({required UserEntity userEntity}) async {
    return await databaseService.addData(
      uid: userEntity.uid,
      path: BackendEndpoints.usersCollection,
      data: userEntity.toMap(),
    );
  }

  @override
  Future<void> deleteUser(User? user) async {
    if (user != null) {
      try {
        await firebaseAuthService.deleteUser();
        await databaseService.deleteUserData(
          path: BackendEndpoints.usersCollection,
          uid: user.uid,
        );
      } catch (deleteError) {
        // Log the deletion error but don't change the main error
        log('Failed to delete user: $deleteError');
      }
    }
  }
  
  
}
