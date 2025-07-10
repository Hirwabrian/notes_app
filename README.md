

## 📒 Notes App

A mobile app that allows users to sign up, log in, and manage personal notes securely using Firebase Authentication and Firestore.

This project was developed as part of a **Mobile Development** course, with the goal of understanding full-stack integration, state management, and clean architecture in Flutter.

---

## Features

Email/password authentication
Create, read, update, and delete (CRUD) notes
Individual user note storage (each user's notes are kept separate)
Simple, responsive UI
Provider for clean state management
Firebase integration (Web/App compatible)

---

## Setup & Build Instructions

###Prerequisites

Before getting started, make sure you have the following installed:

| Tool                      | Version     |
| ------------------------- | ----------- |
| Flutter SDK               | 3.8.0+      |
| Dart                      | 3.x         |
| Android Studio or VS Code | Latest      |
| Firebase Project          | (Free tier) |

---

### Step-by-Step Setup

#### 1. Clone the repository

```bash
git clone https://github.com/your-username/notes_app.git
cd notes_app
```

#### 2. Install all dependencies

```bash
flutter pub get
```

#### 3. Set up Firebase

* Go to [Firebase Console](https://console.firebase.google.com/)
* Create a new project (e.g. `flutter-notes-app`)
* Add a Web or Android app to the project
* Enable:

  * **Email/Password Authentication**
  * **Cloud Firestore**
* Run the Firebase CLI tool to configure your project:

```bash
flutterfire configure
```

This will generate a `firebase_options.dart` file automatically.

#### 4. Run the app

```bash
flutter run
```

> You can also test the app on Chrome if you're running on Web.

---

## Project Structure

```
lib/
├── main.dart               # App entry point
├── models/
│   └── note_model.dart     # Note data structure
├── providers/
│   ├── auth_provider.dart  # Manages login/signup logic
│   └── notes_provider.dart # Manages notes state
├── screens/
│   ├── login_screen.dart
│   ├── signup_screen.dart
│   └── home_screen.dart
├── services/
│   ├── auth_service.dart   # Firebase Auth API calls
│   └── notes_service.dart  # Firestore calls for notes
```

---

## Architecture Overview

This app uses a **Provider-based MVVM-style architecture**:
* **Provider** exposes reactive `isLoading`, `notes`, or `auth` state to the UI.
* **Services** abstract the Firebase SDK calls (Auth/Firestore) from logic.
* Screens stay clean and declarative.

---

## .gitignore & Security

The following sensitive/generated files are **ignored** via `.gitignore`:

```gitignore
# Dart/Pub
.dart_tool/
.packages
build/

# Firebase
firebase_options.dart

# IDE
.idea/
.vscode/

# Android/iOS
android/
ios/
```

> Never push API keys or `firebase_options.dart` to public repos.

---

## Errors Encountered & Solutions

### Main Error: `MissingPluginException` / Pigeon Not Configured

**Cause**: Firebase dependencies were misaligned, and Pigeon (used for platform channels) wasn’t properly linked.

**Fix**:

```bash
flutter clean
rm -rf .dart_tool
flutter pub get
flutterfire configure
```

###`use_build_context_synchronously` Dart Analyzer Warning

**Cause**: `BuildContext` was being used after an `await`, which is unsafe.

**Fix**:
Captured `ScaffoldMessenger.of(context)` before the async gap and added `if (!mounted) return;` after `await`.

---

## Testing

Basic functional testing was done manually across:

* Firebase login/signup
* Notes creation, update, and deletion
* Navigation flows
