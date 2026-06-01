# Movie App

A professional, feature-rich movie catalog application built with Flutter, applying Clean Architecture principles and strict code quality standards.

## 🚀 Features

- **Authentication:**
  - Email & Password Login / Signup.
  - Google Sign-In Integration.
  - Secure Token Storage using `flutter_secure_storage`.
  - Forgot Password functionality.

- **Movie Discovery:**
  - Fetch and browse movies from the **YTS API**.
  - **Pagination** support for endless scrolling (See More).
  - Search functionality to find specific movies.
  - Explore section categorized by genres (Action, Drama, Thriller, Comedy, etc.).

- **User Profile:**
  - View and Edit User Profile.
  - Automatically fetches and displays Google Avatar when signed in with Google.
  
- **UI/UX Aesthetics:**
  - Modern, responsive design using `flutter_screenutil`.
  - Custom Dark/Light theme extension support.
  - Smooth micro-animations and intuitive layout (Custom Bottom Nav, App Bars, Shimmer Loading).
  - Cached Network Images for performance optimization.

## 🏗 Architecture & Technologies

This project strictly adheres to **Clean Architecture** to ensure separation of concerns, scalability, and maintainability.

- **State Management:** `flutter_bloc` (Cubit Pattern).
- **Dependency Injection:** `get_it`.
- **Networking:** `dio` with automated token interceptors.
- **Data Handling:** `dartz` for Either (Failure/Success) pattern.
- **Backend:** Firebase (Authentication & Cloud Firestore).

### Folder Structure (Feature-First Pattern)
```
lib/
├── core/
│   ├── di/                 → Service Locator (Get_It)
│   ├── failure/            → Error Handling Models
│   ├── navigation/         → App Routing & Navigation Extensions
│   ├── network/            → API Service & Endpoints
│   ├── services/           → Shared Services
│   ├── theming/            → Colors, Typography & Theme Configurations
│   ├── use_case/           → Base UseCases
│   ├── utils/              → Constants, Extensions, Local Storage
│   └── widgets/            → Global Reusable Widgets (Buttons, Inputs, etc.)
├── features/
│   ├── auth/               → Login, Signup, Reset Password
│   ├── explore/            → Browse Movies by Category
│   ├── home/               → Home Tab & Movie Details
│   ├── main_layout/        → Bottom Navigation & Master View
│   ├── profile/            → User Details & Settings
│   └── search/             → Search Movies Feature
└── main.dart
```

## 🛠 Getting Started

### Prerequisites
- Flutter SDK (latest stable).
- Android Studio / VS Code.
- A Firebase Project (with Android App configured).

### Setup Instructions

1. **Clone the repository:**
   ```bash
   git clone <repository_url>
   cd movie_app
   ```

2. **Install Dependencies:**
   ```bash
   flutter pub get
   ```

3. **Firebase Configuration:**
   - Add your `google-services.json` to `android/app/`.
   - Ensure the SHA-1 and SHA-256 keys of your development machine are added to the Firebase Console to enable Google Sign-In.

4. **Run the App:**
   ```bash
   flutter run
   ```

## 📜 Coding Standards
- Strictly Typed Dart (No implicit dynamics).
- Constant Constructors are enforced globally.
- Features are completely decoupled.
- Domain Layer is pure Dart (No Flutter imports).
- All dependencies are injected via `ServiceLocator`.
