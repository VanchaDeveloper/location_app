import 'package:location_app/features/data/remote/data_sources/firebase_remote_data_source.dart';
import 'package:location_app/features/data/remote/data_sources/firebase_remote_data_source_impl.dart';
import 'package:location_app/features/domain/entities/user_entity.dart';
import 'package:location_app/features/domain/repositories/firebase_repository.dart';

class FirebaseRepositoryImpl implements FirebaseRepository {
  final FirebaseRemoteDataSource remoteDataSource =
      FirebaseRemoteDataSourceImpl();

  @override
  Future<bool> isSignIn() async => await remoteDataSource.isSignIn();

  @override
  Future<void> signOut() async => await remoteDataSource.signOut();

  @override
  Future<void> signIn(UserEntity user) async => remoteDataSource.signIn(user);

  @override
  Future<void> signUp(UserEntity user) async => remoteDataSource.signUp(user);
}
