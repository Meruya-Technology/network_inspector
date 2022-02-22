Easy to use, http client class debugger & logger for multiple http client.
This package contains a set of high-level functions and classes that make it easy to log / debug HTTP activities on the fly. It's also depend on [Dio](https://pub.dev/packages/dio) and [Http](https://pub.dev/packages/http) package.

# Get Started
add dependency
```yaml
dependencies:
  dio: ^4.0.4
```

# Initialize
Initialize network inspector, call initialize method to init the local database `sqlite`. You can use `WidgetsFlutterBinding.ensureInitialized();` to makesure widget flutter binding initialized before initialize network inspector.
```dart
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  NetworkInspector.initialize();
  runApp(const ExampleApp());
}
```

# Dio Users
1. Add interceptor class `DioInterceptor` for dio client. Set `logIsAllowed`  to `true`, to turn the logger & debugger on. 
2. Create another Network Inspector class to used on the `DioInterceptor` constructor.
3. use `onHttpFinish` as a callback when http activities is finish (Can be success/error)
```dart
final networkInspector = NewtworkInspector();
Dio()..interceptors.add(
        DioInterceptor(
          logIsAllowed: true,
          networkInspector: networkInspector,
          onHttpFinish: (hashCode, title, message) {
            notifyActivity(
              title: title,
              message: message,
            );
          },
        ),
      );
```

# Http Users
1. Add interceptor class `HttpInterceptor` for dio client. Set `logIsAllowed`  to `true`, to turn the logger & debugger on. 
2. Initialize `Client` to client class, then use `client` on the `HttpInterceptor` constructor
2. Create another Network Inspector class to used on the `DioInterceptor` constructor.
3. use `onHttpFinish` as a callback when http activities is finish (Can be success/error)
```dart
HttpInterceptor get httpClient {
    final networkInspector = NewtworkInspector();
    final client = Client();
    final interceptor = HttpInterceptor(
      logIsAllowed: true,
      client: client,
      baseUrl: Uri.parse('http://192.168.1.3:8000/'),
      networkInspector: networkInspector,
      onHttpFinish: (hashCode, title, message) {
        notifyActivity(
          title: title,
          message: message,
        );
      },
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer WEKLSSS'
      },
    );
    return interceptor;
}
```

# Acessing the UI
We can use regular `Navigator.push`, we decide to use `MaterialPageRoute` instead of named route to keep package tightly coupled with your application.
```dart
/// Use this on floating button / notification handler.
void goToActivityPage(BuildContext context){
    await Navigator.push(
    context,
        MaterialPageRoute<void>(
            builder: (context) => ActivityPage(),
        ),
    );
}
```