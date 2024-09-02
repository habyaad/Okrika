import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:okrika/features/products/presentation/screens/create_product_screen.dart';
import 'package:okrika/features/splash/splash_screen.dart';
import 'features/products/presentation/screens/product_catalogue_screen.dart';
import 'features/products/presentation/screens/product_view_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Okrika',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
      routes: {
        '/product-catalogue': (ctx) => const ProductCatalogueScreen(),
        '/product-view': (ctx) => const ProductViewScreen(),
        '/create-product': (ctx) => const CreateProductScreen(),
      },
    );
  }
}
