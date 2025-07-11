import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:fruits_hub/core/helper_functions/applesignin_helper_funs.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:fruits_hub/core/exception/custom_exception.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart' hide generateNonce;

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> deleteUser() async {
    await _auth.currentUser!.delete();
  }

  Future<User> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      return userCredential.user!;
    } on FirebaseAuthException catch (e) {
      log('FirebaseAuthException: ${e.code}, Message: ${e.message}');
      if (e.code == 'weak-password') {
        throw CustomException("The password provided is too weak.");
      } else if (e.code == 'email-already-in-use') {
        throw CustomException('The account already exists for that email.');
      } else if (e.code == "network-request-failed") {
        throw CustomException(
          'Network error, please check your internet connection.',
        );
      } else {
        throw CustomException('An unknown error occurred: ${e.message}');
      }
    } catch (e) {
      log('Error during user creation: $e');
      throw CustomException('An unknown error occurred: ${e.toString()}');
    }
  }

  Future<User> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user!;
    } on FirebaseAuthException catch (e) {
      log('FirebaseAuthException: ${e.code}, Message: ${e.message}');
      if (e.code == 'user-not-found') {
        throw CustomException('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        throw CustomException('Wrong password provided.');
      } else if (e.code == "network-request-failed") {
        throw CustomException(
          'Network error, please check your internet connection.',
        );
      } else {
        throw CustomException('An unknown error occurred: ${e.message}');
      }
    } catch (e) {
      log('Error during email sign-in: $e');
      throw CustomException('An unknown error occurred: ${e.toString()}');
    }
  }

  Future<User> signInWithGoogle() async {
    try {
      final signIn = GoogleSignIn.instance;

      await signIn.initialize(
        clientId:
            "434905090125-jqfs3s74rl6b52er0hbh22tm4kaluu52.apps.googleusercontent.com",
      );

      final account = await signIn.authenticate();

      final googleAuth = account.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.idToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await _auth.signInWithCredential(credential);

      return userCredential.user!;
    } on FirebaseAuthException catch (e) {
      log('FirebaseAuthException: ${e.code}, Message: ${e.message}');
      if (e.code == 'account-exists-with-different-credential') {
        throw CustomException(
          'An account already exists with a different sign-in method. Try using email/password or another provider.',
        );
      } else if (e.code == "network-request-failed") {
        throw CustomException(
          'Network error, please check your internet connection.',
        );
      } else {
        throw CustomException('Google sign-in error: ${e.message}');
      }
    } catch (e) {
      log('Error during Google sign-in: $e');
      throw CustomException(
        'An unknown error occurred during Google sign-in: ${e.toString()}',
      );
    }
  }

  Future<User> signInWithFacebook() async {
    late LoginResult loginResult;
    try {
      loginResult = await FacebookAuth.instance.login();

      if (loginResult.status != LoginStatus.success) {
        throw CustomException('Facebook sign-in was canceled.');
      }

      final facebookAuthCredential = FacebookAuthProvider.credential(
        loginResult.accessToken!.tokenString,
      );

      final userCredential = await _auth.signInWithCredential(
        facebookAuthCredential,
      );

      return userCredential.user!;
    } on FirebaseAuthException catch (e) {
      log('FirebaseAuthException: ${e.code}, Message: ${e.message}');
      if (e.code == 'account-exists-with-different-credential') {
        throw CustomException(
          'An account already exists with a different sign-in method. Try using another provider.',
        );
      } else if (e.code == "network-request-failed") {
        throw CustomException(
          'Network error, please check your internet connection.',
        );
      } else {
        throw CustomException('${e.message}');
      }
    } catch (e) {
      log('Error during Facebook sign-in: $e');
      if (loginResult.status == LoginStatus.cancelled) {
        throw CustomException('Facebook sign-in was canceled by the user.');
      } else {
        throw CustomException(
          'An unknown error occurred during Facebook sign-in: ${e.toString()}',
        );
      }
    }
  }


  Future<User> signInWithApple() async {
  try {
  final rawNonce = generateNonce();
  final nonce = sha256ofString(rawNonce);
  final appleCredential = await SignInWithApple.getAppleIDCredential(
    scopes: [
      AppleIDAuthorizationScopes.email,
      AppleIDAuthorizationScopes.fullName,
    ],
    nonce: nonce,
  );
  
  final oauthCredential = OAuthProvider("apple.com").credential(
    idToken: appleCredential.identityToken,
    rawNonce: rawNonce,
  );
  

  return (await FirebaseAuth.instance.signInWithCredential(oauthCredential)).user!;
} on FirebaseAuthException catch (e) {
      log('FirebaseAuthException: ${e.code}, Message: ${e.message}');
      if (e.code == 'account-exists-with-different-credential') {
        throw CustomException(
          'An account already exists with a different sign-in method. Try using email/password or another provider.',
        );
      } else if (e.code == "network-request-failed") {
        throw CustomException(
          'Network error, please check your internet connection.',
        );
      } else {
        throw CustomException('Google sign-in error: ${e.message}');
      }
    } catch (e) {
      log('Error during email sign-in: $e');
      throw CustomException('An unknown error occurred: ${e.toString()}');
    }
}
}
