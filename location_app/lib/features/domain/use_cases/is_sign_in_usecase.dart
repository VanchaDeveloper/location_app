import 'package:location_app/features/data/repositories/firebase_repository_impl.dart';
import 'package:location_app/features/domain/repositories/firebase_repository.dart';

class IsSignInUseCase {
  final FirebaseRepository repository = FirebaseRepositoryImpl();
  Future<bool> call() async {
    return repository.isSignIn();
  }
}
