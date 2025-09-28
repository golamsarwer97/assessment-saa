import 'package:http/http.dart' as http;
import 'package:connectivity_plus/connectivity_plus.dart';

import '../../data/datasources/product_remote_data_source.dart';
import '../../data/datasources/note_local_data_source.dart';
import '../../data/datasources/note_remote_data_source.dart';

import '../../data/repositories/product_repository_impl.dart';
import '../../data/repositories/note_repository_impl.dart';
import '../../domain/repositories/product_repository.dart';
import '../../domain/repositories/note_repository.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/product_usecase.dart';

import '../../domain/usecases/note_usecases.dart';
import '../../presentation/auth/login_controller.dart';
import '../../presentation/notes/note_controller.dart';
import '../../presentation/products/product_controller.dart';
import '../network/network_info.dart';

import 'package:get/get.dart';

// Bindings for GetX dependency injection
class LoginBinding extends Bindings {
  @override
  void dependencies() {
    // Use cases
    Get.lazyPut(() => LoginUseCase());

    // Controllers
    Get.lazyPut(() => LoginController(Get.find()));
  }
}

class ProductsBinding extends Bindings {
  @override
  void dependencies() {
    // External dependencies
    Get.lazyPut(() => http.Client());

    // Data sources
    Get.lazyPut<ProductRemoteDataSource>(() => ProductRemoteDataSourceImpl(Get.find()));

    // Repositories
    Get.lazyPut<ProductRepository>(() => ProductRepositoryImpl(Get.find()));

    // Use cases
    Get.lazyPut(() => GetProductsUseCase(Get.find()));

    // Controllers
    Get.lazyPut(() => ProductController(Get.find()));
  }
}

class NotesBinding extends Bindings {
  @override
  void dependencies() {
    // External dependencies
    Get.lazyPut(() => Connectivity());
    Get.lazyPut(() => http.Client());

    // Core
    Get.lazyPut<NetworkInfo>(() => NetworkInfoImpl(Get.find()));

    // Data sources
    Get.lazyPut<NoteLocalDataSource>(() => NoteLocalDataSourceImpl());
    Get.lazyPut<NoteRemoteDataSource>(() => NoteRemoteDataSourceImpl(Get.find()));

    // Repositories
    Get.lazyPut<NoteRepository>(() => NoteRepositoryImpl(
          localDataSource: Get.find(),
          remoteDataSource: Get.find(),
          networkInfo: Get.find(),
        ));

    // Use cases
    Get.lazyPut(() => GetNotesUseCase(Get.find()));
    Get.lazyPut(() => SaveNoteUseCase(Get.find()));
    Get.lazyPut(() => DeleteNoteUseCase(Get.find()));
    Get.lazyPut(() => SyncNotesUseCase(Get.find()));

    // Controllers
    Get.lazyPut(() => NoteController(
          getNotesUseCase: Get.find(),
          saveNoteUseCase: Get.find(),
          deleteNoteUseCase: Get.find(),
          syncNotesUseCase: Get.find(),
        ));
  }
}
