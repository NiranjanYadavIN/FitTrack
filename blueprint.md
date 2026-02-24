# FitTrack Mini Blueprint

## Overview

FitTrack Mini is a Flutter-based mobile application designed to help users track their daily fitness activities. The app provides a simple and intuitive interface for monitoring steps, water intake, and various physical activities. It uses local storage to persist user data, ensuring that information is retained between sessions.

## Style, Design, and Features

### Implemented

- **Step Counting:** The app tracks the user's daily steps using the `pedometer` package.
- **Water Intake:** Users can log their water consumption through a dialog.
- **Activity Tracking:** Users can record different types of physical activities, including the duration and calories burned, through a dialog.
- **Local Storage:** The app uses the `hive` package to store all fitness data locally on the device.
- **Provider State Management:** The `provider` package is used for state management, ensuring that the UI updates reactively to data changes.
- **Bottom Navigation:** A bottom navigation bar allows users to switch between the Home, Activities, and Settings screens.
- **Circular Progress Indicator:** The home screen displays a circular progress indicator for the daily step count.
- **Card-based UI:** The UI uses cards to display information in a modern and organized layout.
- **Floating Action Button:** A floating action button is available for quick access to adding new activities.
- **Settings Screen:** A settings screen allows the user to clear all the data.
- **Error Handling and Data Validation:** Basic error handling and data validation are implemented in the dialogs.
