<h1 align="center">Sandboxies<h1/>

### This is a Flutter monorepo. Collection of multiple Flutter apps and shared packages.

# Getting Started

## Prerequisites

Make sure you have the following installed on your local machine:

- Flutter and Dart SDK
- SDK source: FVM (ensure SDK versions are matched, FVM preferred)
- VSCode (Preferred IDE, as launch.json is set)
- Android Studio or Xcode for iOS development

## VSCode extensions

Required:

- `Dart-Code.dart-code`
- `Dart-Code.flutter`
- `localizely.flutter-intl`

Optional:

- `FelixAngelov.bloc`
- `aaron-bond.better-comments`
- `ryanluker.vscode-coverage-gutters`
- `BracketPairColorDLW.bracket-pair-color-dlw`
- `plugfox.flutter-plus`
- `luanpotter.dart-import`
- `andreasblech.better-tests`
- `hzgood.dart-data-class-generator`
- `miquelddg.dart-barrel-file-generator`

## VSCode settings

Dart line length:

```json
"dart.lineLength": 80,
"[dart]": {
  "editor.rulers": [80],
}
```

## Installation

- Clone the repository:

```bash
git clone https://github.com/ho1yspirt/sandboxies.git

cd sendboxies
```

- Install required dependencies:

if FVM global is set or Official Flutter SDK is used:

```bash
dart pub get
```

if FVM global isn't set:

```bash
fvm dart pub get
```

# Folder Structure

```
└── 📁apps
└── 📁packages
└── 📁tools
```

# Sources and links

- Consider Effective dart:

  https://dart.dev/effective-dart
