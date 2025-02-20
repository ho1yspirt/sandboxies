import 'package:initialization/initialization.dart';
import 'package:starty/src/feature/app/data/model/app_dependencies.dart';
import 'package:starty/src/feature/app/data/model/dependencies.dart';

final InitializationProcess<Dependencies> initializationProcesss = {
  'Initialize app dependencies':
      (container) => container.app = AppDependencies(),
  'Test async':
      (container) async => await Future.delayed(const Duration(seconds: 1)),
  'Test another async':
      (container) async => await Future.delayed(const Duration(seconds: 2)),
  'Test final async':
      (container) async => await Future.delayed(const Duration(seconds: 3)),
  'Set app name': (container) => container.app.name = 'Starty',
};
