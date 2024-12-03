# Memory Math - Educational Math Game

Memory Math is an engaging educational Flutter application designed to enhance mathematical skills through interactive gameplay. The app offers various game modes to make learning mathematics fun and effective.

## Features

### Game Modes

1. **Find Missing Numbers**
   - Practice arithmetic by finding missing numbers in equations
   - Progressive difficulty levels
   - Instant feedback on answers
   - Score tracking and performance metrics

2. **Quick Math**
   - Speed-based mathematical challenges
   - Multiple operations (Addition, Subtraction, Multiplication, Division)
   - Time-based scoring system
   - Personal best tracking

3. **Math Memory**
   - Memory-based mathematical puzzles
   - Pattern recognition challenges
   - Cognitive skill development
   - Difficulty progression system

### Core Features

- **Multi-language Support**
  - English (Default)
  - Additional languages through localization
  - Easy language switching

- **Theme Support**
  - Light and Dark themes
  - System theme integration
  - Custom color schemes

- **Progress Tracking**
  - Personal statistics
  - Achievement system
  - Performance analytics
  - Progress persistence

- **Audio Feedback**
  - Sound effects for interactions
  - Background music options
  - Mute functionality

## Technical Details

### Key Libraries and Dependencies

### Platform Support

- iOS (12.0+)
- Android (API 21+)
- Windows
- Linux
- macOS

### Architecture

- **State Management**: Provider pattern
- **Dependency Injection**: GetIt service locator
- **Local Storage**: SharedPreferences
- **Design Pattern**: MVVM (Model-View-ViewModel)

## Getting Started

### Prerequisites

- Flutter SDK (Latest stable version)
- Dart SDK
- Android Studio / VS Code
- iOS development setup (for iOS builds)

### Installation

1. Clone the repository:

```bash
git clone https://github.com/yourusername/memory_math.git
```

2. Install dependencies:

```bash
flutter pub get
```

3. Run the application:

```bash
flutter run
```

### Building for Production

#### Android

```bash
flutter build apk --release
```

#### iOS

```bash
flutter build ios --release
```

#### Desktop Platforms

```bash
flutter build windows
flutter build linux
flutter build macos
```

## Development

### Project Structure
```
lib/
├── src/
│   ├── core/          # Core utilities and constants
│   ├── data/          # Data models and repositories
│   ├── ui/            # UI components and screens
│   └── utility/       # Helper functions and utilities
├── generated/         # Generated localization files
└── main.dart         # Application entry point
```

### Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request


## Acknowledgments

- Flutter team for the amazing framework
- Contributors and maintainers
- Educational mathematics resources and inspiration

## Support

For support, email mule.nikhil@gmail.com or create an issue in the repository.

## Screenshots

[Add screenshots of different game modes and features here]
