# Setup Guide for Diabuddy
This document outlines the steps to set up the development environment for the Diabuddy Flutter application.
## Prerequisites
* **Flutter SDK**: Version >=3.2.6 <4.0.0
  * [Flutter installation guide](https://docs.flutter.dev/get-started/install?gad_source=1&gclid=CjwKCAiAkc28BhB0EiwAM001TYCOczWOsZ9zOPcknmcOrEvTA8U_nPdLyd4bRQvwTda_M6-gwCDz4RoCIecQAvD_BwE&gclsrc=aw.ds)
* **Dart SDK**: Included with Flutter
* **Android Studio**: for managing Android dependencies and emulators
* **Visual Studio Code**: for lightweight development
* **Git**: version control system
## Install the Pre-Compiled APK
The debug APK for Diabuddy is available for direct testing. You can download it [here](https://drive.google.com/drive/folders/1_YDvrrbrAgj4S61q59SdIgTVCB3BMVPt?usp=sharing).
After downloading, follow these steps:
1. Transfer the APK to your Android device.
2. Enable "Install unknown apps" for the file manager app or browser you used to download the APK.
3. Open the APK file and follow the installation prompts.
## Instructions
1. **Clone the Repository**<br>
Clone the project repository using Git and navigate inside the directory of the project:
```
git clone https://github.com/ics-uplb/ay2024-2025-1st-sem-cmsc190-sp2-lbsomoson.git
cd ay2024-2025-1st-sem-cmsc190-sp2-lbsomoson
```
2. **Install Flutter Dependencies**<br>
Run the following command to install dependencies listed in `pubspec.yaml`
```
flutter pub get
```
3. **Configure Launcher Icons**<br>
This project uses `flutter_launcher_icons` to manage app icons. To regenerate launcher icons:
```
flutter pub run flutter_launcher_icons:main
```
4. **Configure Firebase**<br>
Run the following to ensure Firebase initialization:
```
flutterfire configure
```
5. **Run the Application**<br>
To run the application:
* Connect a device or start an emulator.
* Use the following command:
```
flutter run
```
6. **Notes**<br>
* Ensure `minSdkVersion` is set to 21 in `android/app/build.gradle` for compatibility.
* For troubleshooting or feature additions, refer to the Flutter documentation and the official plugin guides.
