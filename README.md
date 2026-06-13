# 🍉 Fruits Hub

A modern Flutter e-commerce application for browsing and purchasing fresh fruits. Built with Clean Architecture principles, Firebase backend, and multi-language support (Arabic & English).

## 📱 Overview

Fruits Hub is a full-featured fruit marketplace app that allows users to browse products, manage a shopping cart, and complete purchases with multiple payment options including PayPal and cash on delivery.

## 🛠️ Tech Stack

| Layer | Technology |
|-------|-----------|
| **Framework** | Flutter (Dart SDK >=3.0.0) |
| **State Management** | Flutter Bloc / Cubit |
| **Backend** | Firebase (Auth + Firestore) |
| **Dependency Injection** | GetIt |
| **Local Storage** | SharedPreferences |
| **Payment** | PayPal (flutter_paypal_payment) |
| **Architecture** | Clean Architecture (Data / Domain / Presentation) |
| **Localization** | intl + Flutter Localizations (Arabic & English) |
| **Fonts** | Cairo (Regular, Medium, SemiBold, Bold) |

## 🔑 Key Features

- **Authentication** — Email/password, Google, Facebook, and Apple sign-in
- **Product Browsing** — Featured products, best sellers, and grid views
- **Shopping Cart** — Add/remove items, quantity management, total calculation
- **Checkout Flow** — Multi-step (shipping → payment → order summary)
- **Payment Options** — PayPal integration and cash on delivery
- **Localization** — Full Arabic & English support (default: Arabic)
- **Onboarding** — Welcome page-view for first-time users
- **Skeleton Loading** — Smooth loading states with skeletonizer
- **Product Reviews** — Rating and review system

## 🏗️ Architecture

The project follows **Clean Architecture** with feature-based organization:

```
lib/
├── core/               # Shared utilities, services, widgets
│   ├── cubits/         # Shared state (products)
│   ├── entities/       # Product, Review entities
│   ├── errors/         # Custom exceptions & failures
│   ├── helper_functions/
│   ├── models/         # Data models (Product, Review)
│   ├── repos/          # Products & Orders repositories
│   ├── services/       # Firebase, GetIt, SharedPrefs
│   ├── utils/          # Colors, styles, images, keys
│   └── widgets/        # Reusable UI components
├── features/
│   ├── auth/           # Sign in / Sign up
│   ├── best_selling_fruits/
│   ├── checkout/       # Shipping, payment, order
│   ├── home/           # Main view, cart, products grid
│   ├── on_boarding/    # First-time user experience
│   └── splash/         # Splash screen
├── generated/          # Localization generated files
├── l10n/               # ARB translation files
├── constants.dart
├── firebase_options.dart
└── main.dart
```

## 🎨 Design

- **Primary Color**: `#1F5E3B` (Dark Green)
- **Secondary Color**: `#F4A91F` (Orange/Gold)
- **Font**: Cairo
- **Default Locale**: Arabic (ar)

## 🚀 Getting Started

### Prerequisites

- Flutter SDK >= 3.0.0
- Firebase project configured (Auth + Firestore)
- Android Studio / VS Code with Flutter plugin

### Installation

```bash
# Clone the repository
git clone <repo-url>
cd fruits_market_app

# Install dependencies
flutter pub get

# Run the app
flutter run
```

### Firebase Setup

1. Create a Firebase project at [Firebase Console](https://console.firebase.google.com)
2. Enable Authentication (Email, Google, Facebook, Apple)
3. Create a Firestore database with collections: `users`, `products`, `Orders`
4. Download and configure platform-specific Firebase config files

## 📦 Dependencies

| Package | Purpose |
|---------|---------|
| flutter_bloc | State management |
| firebase_auth | Authentication |
| cloud_firestore | Database |
| get_it | Dependency injection |
| dartz | Functional programming (Either) |
| flutter_paypal_payment | PayPal payments |
| google_sign_in | Google authentication |
| flutter_facebook_auth | Facebook authentication |
| sign_in_with_apple | Apple authentication |
| flutter_svg | SVG rendering |
| shared_preferences | Local storage |
| skeletonizer | Loading skeletons |
| dots_indicator | Page indicator |
| modal_progress_hud_nsn | Loading overlay |
| equatable | Value equality |
| uuid | Unique ID generation |

## 📄 License

This project is private and not published to pub.dev.
