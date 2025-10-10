# wts_bloc

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

# IOS build ipa without signing

```sh
flutter build ipa --no-codesign
```

## Build IOS ipa

and transerfor to apple strore connect

```
flutter build ipa
```

## Steps to Build IPA Without Signing

1. Open Terminal: Navigate to your Flutter project directory.
2. Run the Build Command: Execute the command above. This will create an unsigned .xcarchive file instead of an IPA file directly. The --no-codesign flag tells Flutter not to attempt any code signing during the build process.
3. Locate the Build Output: After the build completes, you can find the output in the build/ios/iphoneos directory.
4. Create the IPA Manually:

- Copy the Runner.app file from the build/ios/iphoneos directory into a new folder named Payload.
- Compress the Payload folder into a ZIP file and rename it to have a .ipa extension. For example:

```sh
cp -R build/ios/iphoneos/Runner.app Payload/
zip -r Payload.zip Payload
mv Payload.zip YourAppName.ipa
```

flutter build apk --release

flutter build apk --profile
