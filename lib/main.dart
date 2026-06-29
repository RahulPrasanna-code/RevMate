import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'theme/app_theme.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'features/dashboard/dashboard_screen.dart';
import 'features/fuel_log/fuel_log_screen.dart';
import 'features/service_log/service_log_screen.dart';
import 'features/expenses/expenses_screen.dart';
import 'features/bike_profile/bike_profile_screen.dart';
import 'features/rides/rides_screen.dart';
import 'features/chat/chat_screen.dart';
import 'data/services/notification_service.dart';

Future<void> main() async {
  await runZonedGuarded<Future<void>>(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      // Load .env if present. Missing .env is fine — keys can be provided via secure storage.
      await dotenv.load(fileName: '.env').catchError((_) {});

      FlutterError.onError = (details) {
        FlutterError.presentError(details);
        print('FlutterError caught: ${details.exceptionAsString()}');
        if (details.stack != null) {
          print(details.stack);
        }
      };

      final container = ProviderContainer();
      final notificationService = container.read(notificationServiceProvider);
      await notificationService.init();
      await notificationService.checkAndNotify();

      runApp(UncontrolledProviderScope(container: container, child: const MainApp()));
    },
    (error, stack) {
      print('Uncaught zone error: $error');
      print(stack);
    },
  );
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'RevMate',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('RevMate'), centerTitle: false),
      body: _buildBody(_selectedIndex),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) =>
            setState(() => _selectedIndex = index),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          NavigationDestination(
            icon: Icon(Icons.local_gas_station),
            label: 'Fuel',
          ),
          NavigationDestination(icon: Icon(Icons.build), label: 'Service'),
          NavigationDestination(
            icon: Icon(Icons.receipt_long),
            label: 'Expenses',
          ),
          NavigationDestination(
            icon: Icon(Icons.route),
            label: 'Rides',
          ),
          NavigationDestination(
            icon: Icon(Icons.two_wheeler),
            label: 'Profile',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const ChatScreen()),
          );
        },
        child: const Icon(Icons.chat_bubble),
      ),
    );
  }

  Widget _buildBody(int index) {
    switch (index) {
      case 0:
        return const DashboardScreen();
      case 1:
        return const FuelLogScreen();
      case 2:
        return const ServiceLogScreen();
      case 3:
        return const ExpensesScreen();
      case 4:
        return const RidesScreen();
      case 5:
        return const BikeProfileScreen();
      default:
        return const Center(child: Text('Unknown'));
    }
  }
}
