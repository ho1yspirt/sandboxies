<h1 align="center">App Shared<h1/>

### Package of shared code that represents application common code.

## Features

- Application settings;
- Logging utils;
- Widgets across all application in monorepository;
- Application initialization process;

## Getting started

- Import package;
- It would be better to use deferred import or at least named;

## Usage

Example of `initialization` feature:

```dart
final initProgress = ValueNotifier((percent: 0, message: ''));
final container = Dependencies(); // Dependencies container or any other source of data-class.

await initialization.loadLibrary();
await initialization.initializeApp(
    configuration: () {
        // Any preconfiguration that executes before initialization process.
    },
    container: () => container,
    initializationProcess: initializationProcesss, // process variable.
    splash: AppSplash(initProgress: initProgress), // AppSplash Flutter widget.
    onProgress: (progress) {
        // Any call on each step of the process progress.
        initProgress.value = progress;
    },
    onSuccess: (dependencies) async {
        await app.loadLibrary();
        runApp(app.App(dependencies: dependencies)); // App Flutter widget.
    },
    onError: (error, stackTrace) async {
        await error_app.loadLibrary();
        runApp(error_app.ErrorApp(error: error)); // ErrorApp Flutter widget.
    },
);
```

## Additional information

- If some kind of code appears duplicated in more than one-two projects it would be better to move it inside app_shared package and adapt it for future usage in other projects;
- If any bug or misconception may appear report it and contribute changes to improve package;
