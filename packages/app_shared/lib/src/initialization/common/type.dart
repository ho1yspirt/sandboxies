import 'dart:async';

import 'package:flutter/foundation.dart';

/// Message information about single initilization process step.
typedef Message = String;

/// Representation of initilization process progress.
typedef InitializationProgress = ({int percent, Message message});

/// [ValueNotifier] for initilization process progress.
typedef InitializationProgressNotifier = ValueNotifier<InitializationProgress>;

/// Representation of single initilization process step.
typedef InitializationStep<T> = FutureOr<void> Function(T dependencies);

/// Representation of initilization process.
typedef InitializationProcess<T> = Map<Message, InitializationStep<T>>;
