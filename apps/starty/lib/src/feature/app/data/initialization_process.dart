import 'package:initialization/initialization.dart';
import 'package:starty/src/feature/app/data/model/app_dependencies.dart';
import 'package:starty/src/feature/app/data/model/dependencies.dart';

final InitializationProcess<Dependencies> initializationProcesss = {
  'Initialize app dependencies':
      (container) => container.app = AppDependencies(),
  'Set app name': (container) => container.app.name = 'Starty',
};
