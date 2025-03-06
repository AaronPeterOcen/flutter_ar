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
  String? _selectedModelUrl;
  final List<String> _modelUrls = [
    'https://www.freepnglogos.com/uploads/furniture-png/furniture-png-transparent-furniture-images-pluspng-15.png',
    'https://example.com/path/to/another/model.glb',
    'https://example.com/path/to/yet/another/model.glb',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Augmented Reality View')),
      body: Column(
        children: [
          Expanded(
            child:
                _selectedModelUrl != null
                    ? AugmentedRealityPlugin(_selectedModelUrl!)
                    : const Center(
                      child: Text('Select a model to display in AR'),
                    ),
          ),
          _buildModelSelectionUI(),
        ],
      ),
    );
  }

  Widget _buildModelSelectionUI() {
    return Container(
      padding: const EdgeInsets.all(8.0),
      color: Colors.grey[200],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children:
            _modelUrls.map((url) {
              return ElevatedButton(
                onPressed: () {
                  setState(() {
                    _selectedModelUrl = url;
                  });
                },
                child: Text('Model ${_modelUrls.indexOf(url) + 1}'),
              );
            }).toList(),
      ),
    );
  }
}
