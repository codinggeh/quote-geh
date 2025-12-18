# Quote Geh

[![Flutter](https://img.shields.io/badge/Flutter-3.5+-blue.svg)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.5+-blue.svg)](https://dart.dev)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

A beautiful daily inspiration app built with Flutter. Discover wisdom that moves you!

## ✨ Features

- 💬 Random inspirational quotes (auto-refresh every 15 seconds)
- ❤️ Save favorites locally
- 🔄 Share quotes with friends
- 🌙 Dark/Light theme support
- 🌍 Multi-language (English & Indonesian)
- 🌐 Web support with GitHub Pages

## 🚀 Live Demo

**[Try Quote Geh →](https://coding-geh.github.io/quote-geh/)**

## 📦 Installation

### Prerequisites

- Flutter SDK (3.5.0 or higher)

### Setup

1. **Clone the repository**
   ```bash
   git clone https://github.com/Coding-Geh/quote-geh.git
   cd quote-geh
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Generate code**
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```

4. **Run the app**
   ```bash
   flutter run
   ```

## 🔨 Build for Production

### Android
```bash
flutter build apk --release
```

### iOS
```bash
flutter build ios --release
```

### Web
```bash
flutter build web --release
```

## 🏗️ Project Structure

```
lib/
├── core/
│   ├── constants/    # API & App constants
│   ├── theme/        # Theme configuration
│   └── utils/        # API helper
├── models/           # Data models (Quote)
├── services/         # API & local services
├── viewmodels/       # State management (Riverpod)
└── views/            # UI screens & widgets
```

## 🛠️ Tech Stack

- **Framework**: Flutter
- **State Management**: Riverpod
- **HTTP Client**: Dio
- **Localization**: easy_localization
- **API**: ZenQuotes (Free, no API key required)

## 📄 License

This project is licensed under the MIT License.

---

Made with ❤️ by [Coding Geh](https://codinggeh.com)
