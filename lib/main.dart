import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;

import 'core/dependency_injection/dependency_injection.dart';
import 'core/theme/app_theme.dart';
import 'core/network/network_info.dart';
import 'data/datasources/product_remote_data_source.dart';
import 'data/datasources/note_local_data_source.dart';
import 'data/datasources/note_remote_data_source.dart';
import 'data/local/note_adapter.dart';
import 'data/repositories/product_repository_impl.dart';
import 'data/repositories/note_repository_impl.dart';
import 'domain/repositories/product_repository.dart';
import 'domain/repositories/note_repository.dart';
import 'domain/usecases/login_usecase.dart';
import 'domain/usecases/product_usecase.dart';
import 'domain/usecases/note_usecases.dart';
import 'presentation/auth/login_controller.dart';
import 'presentation/products/product_controller.dart';
import 'presentation/notes/note_controller.dart';
import 'presentation/auth/login_screen.dart';
import 'presentation/products/products_screen.dart';
import 'presentation/notes/notes_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  final appDocumentDirectory = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);

  // Register Hive adapters
  Hive.registerAdapter(NoteHiveAdapter());
  // Note: Run 'flutter packages pub run build_runner build' first to generate adapters

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return GetMaterialApp(
          title: 'Clean Architecture App',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: ThemeMode.system,
          initialRoute: '/login',
          getPages: [
            GetPage(
              name: '/login',
              page: () => LoginScreen(),
              binding: LoginBinding(),
            ),
            GetPage(
              name: '/products',
              page: () => ProductsScreen(),
              binding: ProductsBinding(),
            ),
            GetPage(
              name: '/notes',
              page: () => NotesScreen(),
              binding: NotesBinding(),
            ),
          ],
        );
      },
    );
  }
}
