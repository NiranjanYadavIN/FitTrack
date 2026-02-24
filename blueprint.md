# FitTrack Mini Blueprint

## Overview

This document outlines the architecture and implementation of FitTrack Mini, a Flutter-based fitness tracking application. The app is designed to be a lightweight and user-friendly tool for monitoring daily fitness activities.

## Core Features

*   **Local Data Persistence**: Utilizes `hive` and `shared_preferences` for efficient on-device data storage.
*   **State Management**: Employs the `provider` package for scalable and maintainable state management.
*   **Clean UI**: Features a simple and intuitive user interface built with Flutter's Material components.

## Project Structure

```
lib/
├── data/
│   ├── models/
│   │   ├── activity_model.dart
│   │   ├── daily_step_model.dart
│   │   └── water_model.dart
├── pages/
│   └── home_page.dart
├── services/
│   └── local_storage_service.dart
└── main.dart
```

## Implementation Details

### Data Persistence

The `LocalStorageService` abstracts the data storage mechanism, using `Hive` for storing structured data (daily steps, water intake, and activities) and `shared_preferences` for simple key-value pairs. The service is provided to the widget tree using `ChangeNotifierProvider`, allowing widgets to react to data changes.

### State Management

The `provider` package is used to manage the application's state. The `LocalStorageService` acts as a `ChangeNotifier`, notifying its listeners when the data is updated. The UI is built using `Consumer` widgets, which automatically rebuild when the data changes.

### User Interface

The UI is built using Flutter's Material components. The `HomePage` displays the user's fitness data in a clear and concise manner. The `google_fonts` package is used to enhance the app's typography.
