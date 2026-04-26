# FlowStateAI — Flutter Frontend

> Flutter client for the FlowStateAI cognitive load estimation system.

FlowStateAI estimates how mentally busy you are — just from how you type and move your mouse. This repository contains the Flutter frontend that visualizes session data produced by the FlowStateAI backend.

[![Flutter](https://img.shields.io/badge/flutter-3.x-02569B?logo=flutter)](https://flutter.dev/)
[![Dart](https://img.shields.io/badge/dart-3.x-0175C2?logo=dart)](https://dart.dev/)
[![Status](https://img.shields.io/badge/status-in%20development-orange)]()
[![License](https://img.shields.io/badge/license-MIT-green)]()

> **Note:** This repo contains only the Flutter frontend. The full project (Python backend + Flutter frontend) is developed collaboratively and lives in a separate private repository.

---

## Table of Contents

- [How It Works](#how-it-works)
- [Project Structure](#project-structure)
- [Prerequisites](#prerequisites)
- [Setup](#setup)
- [Running the App](#running-the-app)
- [Screens](#screens)
- [Demo Mode](#demo-mode)
- [Troubleshooting](#troubleshooting)
- [Development Status](#development-status)
- [Contributing](#contributing)
- [License](#license)

---

## How It Works

The backend (Python) collects keyboard and mouse events during a session and produces a `frontend_summary.json` file. This Flutter app reads that JSON and displays the cognitive load metrics on a dashboard.

```
Python Backend  →  frontend_summary.json  →  json_loader.dart  →  Dashboard UI
```

The app can also run in **demo mode** using a sample JSON file — no backend connection needed.

---

## Project Structure

```
frontend/
├── assets/
│   └── sample/
│       └── frontend_summary.json   # Sample data for demo mode
│
├── models/                         # Data models (SessionSummary, etc.)
│
├── screens/
│   ├── home_screen.dart            # Landing screen
│   ├── session_screen.dart         # Active session view
│   ├── dashboard_screen.dart       # Session results & metrics
│   └── focus_page.dart             # Focus/cognitive load display
│
├── services/
│   └── json_loader.dart            # Reads and parses frontend_summary.json
│
├── main.dart                       # App entry point
├── pubspec.yaml
└── pubspec.lock
```

---

## Prerequisites

| Tool | Version |
|------|---------|
| Flutter | 3.x |
| Dart | 3.x |
| Git | any |

Install Flutter: [flutter.dev/docs/get-started/install](https://flutter.dev/docs/get-started/install)

---

## Setup

```bash
git clone https://github.com/elifyesilyurt/FlowStateAI.git
cd FlowStateAI/frontend

flutter pub get
```

---

## Running the App

```bash
# Run on connected device or emulator
flutter run

# Run on a specific platform
flutter run -d chrome       # Web
flutter run -d macos        # macOS desktop
flutter run -d android      # Android emulator
```

---

## Screens

| Screen | File | Description |
|--------|------|-------------|
| Home | `home_screen.dart` | Landing screen, entry point |
| Session | `session_screen.dart` | Active session monitoring view |
| Dashboard | `dashboard_screen.dart` | Session results with metric cards |
| Focus Page | `focus_page.dart` | Cognitive load level display |

**App flow:**

```
Home Screen  →  Start Session
    →  Session Screen  →  Stop
        →  Dashboard (metrics from JSON)
            →  Focus Page
```

---

## Demo Mode

The app works without a live backend connection using the bundled sample file.

Sample file location:
```
assets/sample/frontend_summary.json
```

Dashboard metrics pulled from the JSON:

| Card | JSON Field | Example |
|------|------------|---------|
| Total Events | `total_events` | 23 |
| Keyboard Activity | `keyboard_events` | 14 |
| Mouse Activity | `mouse_events` | 9 |
| Duration | `duration_seconds` | 180 |
| Flow Density | `event_density` | 0.13 |

**Error states:**
- File not found → `"No data available"`
- File malformed → `"Data format error"`

---

## Troubleshooting

**`flutter pub get` fails**

Make sure Flutter is installed and in your PATH:
```bash
flutter doctor
```
Fix any issues reported before running again.

---

**Assets not loading (`frontend_summary.json` not found)**

Confirm the asset is declared in `pubspec.yaml`:
```yaml
flutter:
  assets:
    - assets/sample/frontend_summary.json
```
Then run `flutter pub get` again.

---

**App not launching on macOS**

macOS builds require Xcode. Run:
```bash
sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer
sudo xcodebuild -runFirstLaunch
```

---

## Development Status

- [x] Home screen
- [x] Session screen
- [x] Dashboard screen with metric cards
- [x] Focus page
- [x] JSON loader service (`json_loader.dart`)
- [x] Demo mode with sample data
- [ ] Live backend connection
- [ ] Session history screen
- [ ] Cognitive load classification UI (Low / Medium / High)

---

## Contributing

Pull requests are welcome. For major changes, please open an issue first.

1. Fork the repo
2. Create a feature branch (`git checkout -b feature/your-feature`)
3. Commit your changes (`git commit -m 'feat: add your feature'`)
4. Push to the branch (`git push origin feature/your-feature`)
5. Open a Pull Request

---

## License

MIT © 2026 Elif Yeşilyurt

---

> 🇹🇷 [Türkçe Dokümantasyon](docs/README_TR.md)
