# products_store

Ecommerce app

🛍️ Products Store App

A Flutter e-commerce application built with Clean Architecture + BLoC state management, integrating Firebase for authentication, Firestore for data storage, FCM for push notifications, and modern Flutter practices like GoRouter, Injectable (DI), and Service Locator.

This app was developed as part of a technical assignment for Simplex.

✨ Features
🔐 Authentication

Sign Up, Sign In, Forgot Password (Firebase Auth)
Session persistence with Splash screen
Secure logout

🏠 Products

Fetch products from Firestore
Product listing with pagination
Product details page with image, description, price, and stock
Add to Cart functionality

🛒 Cart

Add, remove, update quantity
Calculate cart total
Clear cart on logout

💳 Checkout

Create checkout session
On successful checkout → Push Notification with product image

🔔 Notifications (FCM)

Firebase Cloud Messaging integration
Cloud Function sends push notifications on checkout
Notification includes title, body, and product image
Handles background & foreground notifications

👤 Account

View profile
Logout

🏗️ Architecture

This project follows Clean Architecture with layers:
Presentation → Pages + Widgets + BLoC
Domain → Entities + Use Cases + Repository
Data → Repository Implementations + Data Sources + Model

🛠️ Tech Stack

Flutter (3.x)
Dart
Firebase (Auth, Firestore, FCM, Cloud Functions)
BLoC (flutter_bloc, equatable)
GoRouter (declarative navigation)


📲 Installation

Clone the repo

git clone https://github.com/your-username/products_store.git
cd products_store

Install dependencies

flutter pub get

Setup Firebase

Add your google-services.json (Android) and GoogleService-Info.plist (iOS).
Configure firebase_options.dart with FlutterFire CLI.
Run the app
flutter run

📦 Build APK
flutter build apk --release

The APK will be available at:
build/app/outputs/flutter-apk/app-release.apk

👨‍💻 Author

Developed by Raheel Khan
Flutter Developer (4+ years experience)
Passion for Clean Architecture & scalable apps
