import 'package:location_app/features/domain/entities/user_entity.dart';

abstract class FirebaseRemoteDataSource {
  Future<void> signIn(UserEntity user);
  Future<void> signUp(UserEntity user);
  Future<bool> isSignIn();
  Future<void> signOut();
}
