import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:augmented_reality_plugin/augmented_reality_plugin.dart';
import 'package:camera/camera.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    var allCameras = await availableCameras();
  } on CameraException catch (errorMessage) {
    if (kDebugMode) {
      print('Error: ${errorMessage.description}');
    }
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Augmented Reality App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const AugmentedRealityView(),
    );
  }
}

class AugmentedRealityView extends StatefulWidget {
  const AugmentedRealityView({super.key});
  @override
  _AugmentedRealityViewState createState() => _AugmentedRealityViewState();
}

class _AugmentedRealityViewState extends State<AugmentedRealityView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Augmented Reality View')),
      body: AugmentedRealityPlugin(
        'https://www.freepnglogos.com/uploads/furniture-png/furniture-png-transparent-furniture-images-pluspng-15.png',
      ),
    );
  }
}
