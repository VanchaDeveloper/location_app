import 'package:location_app/features/data/repositories/firebase_repository_impl.dart';
import 'package:location_app/features/domain/entities/user_entity.dart';
import 'package:location_app/features/domain/repositories/firebase_repository.dart';

class SignUpUseCase {
  final FirebaseRepository repository = FirebaseRepositoryImpl();
  Future<void> call(UserEntity user) {
    return repository.signUp(user);
  }
}
