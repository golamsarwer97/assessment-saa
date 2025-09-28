# Assessment of a Flutter App

A comprehensive Flutter application built with Clean Architecture, featuring user authentication, product listing with search/filter functionality, and a notes management system with offline-first capabilities.

## 🚀 Features

### 🔐 Authentication
- Email and password login with validation
- Firebase-style validation rules:
  - Valid email format (regex)
  - Password: min 6 chars, 1 number, 1 uppercase letter
- Success/error feedback with SnackBar

### 🛍️ Products Module
- Fetch products from FakeStore API
- Grid layout display
- Search products by title
- Filter by category (men's clothing, jewelry, electronics, etc.)
- Pull-to-refresh functionality
- Skeleton loader during data loading
- Responsive design with Sizer

### 📝 Notes Module
- Create, edit, and delete notes
- Local storage using Hive
- Offline-first architecture
- Auto-sync with mock API when online
- Color tagging for notes
- Search functionality
- Manual sync option

### 🎨 UI/UX
- Dark/Light theme support
- Responsive design
- Custom error handling
- Loading states and skeleton screens
- Intuitive user interface

## 🏗️ Architecture

The app follows Clean Architecture with clear separation of concerns:
lib/
├── core/
│ ├── constants/ # App constants
│ ├── errors/ # Custom exceptions & failures
│ ├── network/ # Network info
│ ├── theme/ # App themes
│ └── utils/ # Validators & utilities
├── data/
│ ├── datasources/ # Local & remote data sources
│ ├── local/ # Hive adapters
│ ├── models/ # Data models
│ └── repositories/ # Repository implementations
├── domain/
│ ├── entities/ # Business entities
│ ├── repositories/ # Repository contracts
│ └── usecases/ # Business logic
└── presentation/
├── auth/ # Login screens & controllers
├── products/ # Product listing
├── notes/ # Notes management
└── widgets/ # Reusable components

text

## 🛠️ Tech Stack

- **Flutter** - UI Framework
- **GetX** - State management & navigation
- **Hive** - Local database
- **HTTP** - API calls
- **Sizer** - Responsive design
- **Connectivity Plus** - Network status
- **Dartz** - Functional programming
- **Equatable** - Value equality
- **Shimmer** - Loading animations
- **Pull to Refresh** - Refresh functionality

## 📋 Prerequisites

- Flutter SDK (>=3.0.0)
- Dart (>=3.0.0)
- Android Studio/VSCode

## ⚙️ Installation & Setup

1. **Clone and setup**
   ```bash
   git clone <repository-url>
   cd clean_architecture_app
   flutter pub get
