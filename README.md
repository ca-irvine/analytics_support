# analytics_support

Support your analytics life.

## Getting Started

Add `analytics_support` to dependencies in `pubspec.yaml`.

```yaml
dependencies:
  analytics_support:
```

Also, should override it.

```yaml
dependency_overrides:
  analytics_support:
    git:
      url: git@github.com:ca-irvine/analytics_support.git
```

## Usage

### Functions

```dart
AnalyticsSupport({required this.gaTrackingId});
```

- Get an instance of `AnalyticsSupport`.
- Should set google analytics tracking id. (e.g. `UA-123456789-1`)

```dart
Future<String?> get clientId;
```

- Get the client id of google analytics.

```dart
Future<void> startIosLogging();
Future<void> stopIosLogging();
```

- Can start or stop logging for iOS.

If you want to show the Android console log, you can run the following commands:

```bash
$ adb shell setprop log.tag.GoogleTagManager VERBOSE
$ adb shell setprop log.tag.GAv4 DEBUG
```

- Start logging

```bash
$ adb shell setprop log.tag.GoogleTagManager INFO
$ adb shell setprop log.tag.GAv4 INFO
```

- Stop logging.

### Settings

If you want to get the time stamp using `Function Call` of Google Tag Manager, set the following value in `Class Path`.

#### Android
```
com.cairvine.analytics_support.TimestampProvider
```

#### iOS
```
GoogleCustomTag
```

Android|iOS
-|-
![Android Class Path](https://user-images.githubusercontent.com/5707132/147319481-20578d81-3d46-4408-95f0-91699aeef098.png)|![iOS Class Path](https://user-images.githubusercontent.com/5707132/147319925-5c999b4d-7e86-471d-bb32-ab9be01dbc24.png)

## License

Playbook is released under the [BSD-3-Clause License](./LICENSE).
