# Instagram Flutter - Social Media Mobile Application

A full-stack social networking application inspired by Instagram, built with Flutter for cross-platform mobile development and NestJS for backend services.

## 🚀 Project Overview

This project demonstrates a complete social media application with the following features:
- **User Authentication**: JWT-based login/register with refresh token support
- **Social Features**: Follow/unfollow users, like and comment on posts
- **Content Management**: Photo sharing with Cloudinary integration
- **User Profiles**: Customizable profiles with post collections
- **Cross-platform**: Works on both Android and iOS devices

## 🛠️ Tech Stack

### Frontend (Mobile App)
- **Flutter** - Cross-platform mobile development framework
- **Dart** - Programming language
- **Provider** - State management
- **Dio** - HTTP client for API communication
- **Shared Preferences** - Local data storage
- **Lottie** - Animation support

### Backend
- **NestJS** - TypeScript-based backend framework
- **MySQL** - Database
- **TypeORM** - Object-Relational Mapping
- **JWT** - Authentication & authorization
- **Passport.js** - Authentication strategies
- **Cloudinary** - Image hosting service

## 📱 Features

### Core Functionality
- User registration and authentication
- Photo upload and sharing
- Feed with posts from followed users
- Like and comment system
- User follow/unfollow
- Profile management
- Post saving/bookmarking
- Search functionality

### UI/UX Features
- Instagram-like interface design
- Smooth animations and transitions
- Responsive design for different screen sizes
- Story-like post viewing
- Interactive post interactions

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (version 3.8.0 or higher)
- Dart SDK
- Android Studio / VS Code
- Android Emulator or physical device
- iOS Simulator (for macOS users)

### Installation Steps

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/instagram_flutter.git
   cd instagram_flutter
   ```

2. **Install Flutter dependencies**
   ```bash
   flutter pub get
   ```

3. **Configure backend connection**
   - Update API endpoints in `lib/apps/config/dio_client.dart`
   - Ensure backend server is running

4. **Run the application**
   ```bash
   flutter run
   ```

### Backend Setup
1. Navigate to backend directory (if included)
2. Install dependencies: `npm install`
3. Configure database connection
4. Set up environment variables
5. Start server: `npm run start:dev`

## 📁 Project Structure

```
lib/
├── apps/
│   ├── config/          # App configuration
│   └── utils/           # Utility functions
├── dto/                 # Data Transfer Objects
├── models/              # Data models
├── providers/           # State management
├── repositories/        # Data layer
├── screens/             # UI screens
│   ├── auth/           # Authentication screens
│   ├── home/           # Home feed
│   ├── profile/        # User profiles
│   ├── search/         # Search functionality
│   └── reels/          # Video content
└── services/            # API services
```

## 🔧 Configuration

### Environment Variables
- Backend API URL
- Cloudinary credentials
- Database connection details

### Dependencies
All required packages are listed in `pubspec.yaml` and will be installed automatically with `flutter pub get`.


## 👨‍💻 Developer

**Pham Ngoc Duy** - Mobile Developer Intern
- **Skills**: Flutter, Dart, NestJS, TypeScript, Java, Spring Boot
- **Experience**: Full-stack development with focus on mobile applications
- **Contact**: duysm17102004@gmail.com

## 🔗 Links

- **Backend Repository**: https://github.com/DuyPham1710/instagram