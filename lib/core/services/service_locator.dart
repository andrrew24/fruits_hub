import 'package:firebase_core/firebase_core.dart';
import 'package:fruits_hub/core/services/database_service.dart';
import 'package:fruits_hub/core/services/firebase_auth_service.dart';
import 'package:fruits_hub/core/services/firestore_db_service.dart';
import 'package:fruits_hub/features/auth/data/repo/auth_repo_iml.dart';
import 'package:fruits_hub/features/auth/domain/repo/auth_repo.dart';
import 'package:fruits_hub/firebase_options.dart';
import 'package:get_it/get_it.dart';

GetIt serviceLocator = GetIt.instance;

Future<void> setupServiceLocator() async {
  await setupServices();
  setupRepositories();
}

void setupRepositories() {
  serviceLocator.registerSingleton<AuthRepo>(
    AuthRepoIml(
      firebaseAuthService: serviceLocator<FirebaseAuthService>(),
      databaseService: serviceLocator<DatabaseService>(),
    ),
  );
}

Future<void> setupServices() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  serviceLocator.registerSingleton<FirebaseAuthService>(FirebaseAuthService());

  serviceLocator.registerSingleton<DatabaseService>(FirestoreDatabaseService());
}
