import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:math' as math;

import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:fruits_hub/core/errors/exceptions.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class FirebaseAuthService {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email', 'profile'],
  );

  Future deleteUser() async {
    await FirebaseAuth.instance.currentUser?.delete();
  }

  Future<User> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user!;
    } on FirebaseAuthException catch (e) {
      log("createUser error: ${e.code}");

      switch (e.code) {
        case 'weak-password':
          throw CustomException(message: 'كلمة المرور ضعيفة جداً.');
        case 'email-already-in-use':
          throw CustomException(message: 'الحساب مستخدم مسبقاً.');
        case 'network-request-failed':
          throw CustomException(message: 'تحقق من الاتصال بالإنترنت.');
        default:
          throw CustomException(message: 'حدث خطأ غير متوقع.');
      }
    }
  }

  Future<User> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user!;
    } on FirebaseAuthException catch (e) {
      log("signIn error: ${e.code}");

      switch (e.code) {
        case 'user-not-found':
        case 'wrong-password':
        case 'invalid-credential':
          throw CustomException(
              message: 'البريد الإلكتروني أو كلمة المرور غير صحيحة.');
        case 'network-request-failed':
          throw CustomException(message: 'تحقق من الاتصال بالإنترنت.');
        default:
          throw CustomException(message: 'حدث خطأ غير متوقع.');
      }
    }
  }

  // ================= GOOGLE =================
  Future<User> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        throw CustomException(message: 'تم إلغاء تسجيل الدخول');
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      if (googleAuth.accessToken == null || googleAuth.idToken == null) {
        throw CustomException(message: 'فشل في الحصول على بيانات Google');
      }

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      return userCredential.user!;
    } on CustomException {
      rethrow;
    } catch (e) {
      log("Google SignIn error: $e");
      throw CustomException(message: 'حدث خطأ أثناء تسجيل الدخول بـ Google');
    }
  }

  // ================= FACEBOOK =================
  Future<User> signInWithFacebook() async {
    try {
      final rawNonce = generateNonce();
      final nonce = sha256ofString(rawNonce);

      final LoginResult loginResult =
          await FacebookAuth.instance.login(nonce: nonce);

      if (loginResult.status != LoginStatus.success ||
          loginResult.accessToken == null) {
        throw CustomException(message: 'فشل تسجيل الدخول عبر Facebook');
      }

      OAuthCredential facebookAuthCredential;

      if (Platform.isIOS) {
        facebookAuthCredential = FacebookAuthProvider.credential(
          loginResult.accessToken!.tokenString,
        );
      } else {
        facebookAuthCredential = FacebookAuthProvider.credential(
          loginResult.accessToken!.tokenString,
        );
      }

      final userCredential = await FirebaseAuth.instance
          .signInWithCredential(facebookAuthCredential);

      return userCredential.user!;
    } catch (e) {
      log("Facebook SignIn error: $e");
      throw CustomException(message: 'حدث خطأ أثناء تسجيل الدخول بـ Facebook');
    }
  }

  // ================= APPLE =================
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

      final userCredential =
          await FirebaseAuth.instance.signInWithCredential(oauthCredential);

      return userCredential.user!;
    } catch (e) {
      log("Apple SignIn error: $e");
      throw CustomException(message: 'حدث خطأ أثناء تسجيل الدخول بـ Apple');
    }
  }

  // ================= HELPERS =================
  String generateNonce([int length = 32]) {
    const charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = math.Random.secure();

    return List.generate(
      length,
      (_) => charset[random.nextInt(charset.length)],
    ).join();
  }

  String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  bool isLoggedIn() {
    return FirebaseAuth.instance.currentUser != null;
  }
}
