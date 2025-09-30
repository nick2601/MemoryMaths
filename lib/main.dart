import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mathsgames/src/data/models/random_find_missing_data.dart';

import 'package:mathsgames/src/ui/app/app.dart';
import 'package:mathsgames/src/ui/app/auth_provider.dart';
import 'package:mathsgames/src/ui/app/coin_provider.dart';
import 'package:mathsgames/src/ui/app/theme_provider.dart';
import 'package:mathsgames/src/ui/dashboard/dashboard_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:flutter_background_service_android/flutter_background_service_android.dart';

// bool onIosBackground(ServiceInstance service) {
//   WidgetsFlutterBinding.ensureInitialized();
//   print('FLUTTER BACKGROUND FETCH');
//   return true;
// }

// void onStart(ServiceInstance service) {
//   if (service is AndroidServiceInstance) {
//     service.on('setAsForeground').listen((event) {
//       service.setAsForegroundService();
//     });
//
//     service.on('setAsBackground').listen((event) {
//       service.setAsBackgroundService();
//     });
//   }
//
//   service.on('stopService').listen((event) {
//     service.stopSelf();
//   });
//
//   // bring to foreground
//   Timer.periodic(const Duration(seconds: 1), (timer) async {
//     if (service is AndroidServiceInstance) {
//       service.setForegroundNotificationInfo(
//         title: "My App Service",
//         content: "Updated at ${DateTime.now()}",
//       );
//     }
//
//     /// you can see this log in logcat
//     print('FLUTTER BACKGROUND SERVICE: ${DateTime.now()}');
//
//     // test using external plugin
//     final deviceInfo = DeviceInfoPlugin();
//     String? device;
//     if (Platform.isAndroid) {
//       final androidInfo = await deviceInfo.androidInfo;
//       device = androidInfo.model;
//     }
//
//     if (Platform.isIOS) {
//       final iosInfo = await deviceInfo.iosInfo;
//       device = iosInfo.model;
//     }
//
//     service.invoke(
//       'update',
//       {
//         "current_date": DateTime.now().toIso8601String(),
//         "device": device,
//       },
//     );
//   });
// }

//
// Future<void> initializeService() async {
//   final service = FlutterBackgroundService();
//   await service.configure(
//     androidConfiguration: AndroidConfiguration(
//       // this will executed when app is in foreground or background in separated isolate
//       onStart: onStart,
//
//       // auto start service
//       autoStart: true,
//       isForegroundMode: true,
//     ),
//     iosConfiguration: IosConfiguration(
//       // auto start service
//       autoStart: true,
//       // this will executed when app is in foreground in separated isolate
//       onForeground: onStart,
//
//       // you have to enable background fetch capability on xcode project
//       onBackground: onIosBackground,
//     ),
//   );
//   service.startService();
// }

/// Main entry point of the application.
/// Initializes necessary services and runs the app with required providers.
Future<void> main() async {
  // Ensure Flutter bindings are initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize shared preferences for persistent storage
  final sharedPreferences = await SharedPreferences.getInstance();

  // Debug print statement for formatted string
  print("va===${getFormattedString(19.2)}");

  // Set up dependency injection
  setupServiceLocator(sharedPreferences);

  // Run the app with multiple providers for state management
  runApp(
    MultiProvider(
      providers: [
        // Theme provider for app-wide theme management
        ChangeNotifierProvider(
          create: (context) =>
              ThemeProvider(sharedPreferences: sharedPreferences),
        ),
        // Dashboard provider for managing dashboard state
        ChangeNotifierProvider<DashboardProvider>(
          create: (context) => GetIt.I.get<DashboardProvider>(),
        ),
        // Coin provider for managing in-game currency
        ChangeNotifierProvider<CoinProvider>(
          create: (context) => GetIt.I.get<CoinProvider>(),
        ),
        // Authentication provider for user management
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: MyApp(),
    ),
  );
}

/// Sets up dependency injection using GetIt service locator.
/// Registers singleton instances of providers that require shared preferences.
///
/// @param sharedPreferences Instance of SharedPreferences for persistent storage
setupServiceLocator(SharedPreferences sharedPreferences) {
  GetIt.I.registerSingleton<DashboardProvider>(
      DashboardProvider(preferences: sharedPreferences));
}

// class MyApp extends StatefulWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   _MyAppState createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//   String text = "Stop Service";
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Service App'),
//         ),
//         body: Column(
//           children: [
//             StreamBuilder<Map<String, dynamic>?>(
//               stream: FlutterBackgroundService().on('update'),
//               builder: (context, snapshot) {
//                 if (!snapshot.hasData) {
//                   return const Center(
//                     child: CircularProgressIndicator(),
//                   );
//                 }
//
//                 final data = snapshot.data!;
//                 String? device = data["device"];
//                 DateTime? date = DateTime.tryParse(data["current_date"]);
//                 return Column(
//                   children: [
//                     Text(device ?? 'Unknown'),
//                     Text(date.toString()),
//                   ],
//                 );
//               },
//             ),
//             ElevatedButton(
//               child: const Text("Foreground Mode"),
//               onPressed: () {
//                 FlutterBackgroundService().invoke("setAsForeground");
//               },
//             ),
//             ElevatedButton(
//               child: const Text("Background Mode"),
//               onPressed: () {
//                 FlutterBackgroundService().invoke("setAsBackground");
//               },
//             ),
//             ElevatedButton(
//               child: Text(text),
//               onPressed: () async {
//                 final service = FlutterBackgroundService();
//                 var isRunning = await service.isRunning();
//                 if (isRunning) {
//                   service.invoke("stopService");
//                 } else {
//                   service.startService();
//                 }
//
//                 if (!isRunning) {
//                   text = 'Stop Service';
//                 } else {
//                   text = 'Start Service';
//                 }
//                 setState(() {});
//               },
//             ),
//           ],
//         ),
//         floatingActionButton: FloatingActionButton(
//           onPressed: () {},
//           child: const Icon(Icons.play_arrow),
//         ),
//       ),
//     );
//   }
// }
//
//
//
