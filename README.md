Easy to use, http client class debugger & logger for multiple http client.
This package contains a set of high-level functions and classes that make it easy to log / debug HTTP activities on the fly. It's also depend on [Dio](https://pub.dev/packages/dio) and [Http](https://pub.dev/packages/http) package.

<table>
  <tr>
    <td>
        <img src="https://user-images.githubusercontent.com/27884014/156951215-7618a785-1d9a-490f-8045-689c8238538f.png" width="250px">
    </td>
    <td>
        <img src="https://user-images.githubusercontent.com/27884014/156951219-3ea77c62-c106-43ac-aa7f-ac8cd7034faf.png" width="250px">
    </td>
    <td>
        <img src="https://user-images.githubusercontent.com/27884014/156951223-51c86335-83ae-415f-8254-b8744ec20933.png" width="250px">
    </td>
    <td>
        <img src="https://user-images.githubusercontent.com/27884014/156951229-44befbf6-0ef0-47b1-a8f8-be6538ab4e63.png" width="250px">
    </td>
  </tr>
</table>


https://user-images.githubusercontent.com/27884014/156951569-539bf1b4-246a-446f-a01e-7abdfae2d28b.mp4

# Material 3 & Dark mode support 🆕
Now you can use your favorite material 3 theme and dark mode, starting from version `1.0.4`
<table>
  <tr>
    <td>
        <img src="https://user-images.githubusercontent.com/27884014/215930054-fb788a1f-6cbe-47c8-8422-87fd9280c045.png" height="250px">
    </td>
    <td>
        <img src="https://user-images.githubusercontent.com/27884014/215930065-7fbcd2fb-e886-4650-9b6e-921f495fa637.png" height="250px">
    </td>
    <td>
        <img src="https://user-images.githubusercontent.com/27884014/215930067-62e9bcb9-28a8-442d-b2b4-90c003a17334.png" height="250px">
    </td>
    <td>
        <img src="https://user-images.githubusercontent.com/27884014/215930075-6a6ea153-3db4-471c-86ca-31724e2e78c5.png" height="250px">
    </td>
  </tr>
</table>

# Get Started
add dependency
```yaml
dependencies:
  network_inspector: ^1.0.0
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
1. Add interceptor class `DioInterceptor` for dio client.
2. Create another Network Inspector class to used on the `DioInterceptor` constructor.
3. Use `onHttpFinish` as a callback when http activities is finish (Can be success/error)
```dart
/// Client Declaration
Dio get dioClient{
  final networkInspector = NewtworkInspector();
  final client = Dio()..interceptors.add(
    DioInterceptor(
      logIsAllowed: true, //Enable/Disable overall logging 
      isConsoleLogAllowed: true, //Enable/Disable only console logging
      networkInspector: networkInspector,
      onHttpFinish: (hashCode, title, message) {
        notifyActivity(
          title: title,
          message: message,
        );
      },
    ),
  );
  return client;
}

/// Use dio regularly
/// Every request, response & error will automatically fetched & stored by the network inspector.
/// And also if the properties of declared `DioInterceptor` is not empty, it will set every properties as default.
await dioClient.post('/test', data: {'id': 1, 'name': 'jhon folks'});
```

# Http Users
1. Add interceptor class `HttpInterceptor` for dio client.
2. Initialize `Client` to client class, then use `client` on the `HttpInterceptor` constructor
3. Create another Network Inspector class to used on the `DioInterceptor` constructor.
4. Use `onHttpFinish` as a callback when http activities is finish (Can be success/error)
```dart
HttpInterceptor get httpClient {
  final networkInspector = NewtworkInspector();
  final client = Client();
  final interceptor = HttpInterceptor(
    logIsAllowed: true, //Enable/Disable overall logging 
    isConsoleLogAllowed: true, //Enable/Disable only console logging
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
/// Use http client regularly
/// Every request, response & error will automatically fetched & stored by the network inspector.
/// And also if the properties of declared `HttpInterceptor` is not empty, it will set every properties as default.
await httpClient.post(url, body: {'name': 'doodle', 'color': 'blue'});
```

# Acessing the UI
We can use regular `Navigator.push`, we decide to use `MaterialPageRoute` instead of named route to avoid tightly coupled.
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

# Entry point from notification tap action
If the entry point to http activity page is desired from notification tap action, create a class to store `GlobalKey<NavigatorState>` which we need to navigate to the http activity page, from anywhere add GlobalKey into the `MaterialApp` widget on the `navigatorKey` constructor. 
```dart
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Network inspector',
      theme: ThemeData(
          primarySwatch: Colors.blue,
      ),
      /// Put your navigation key into a class
      /// In this case we put navigator key on
      /// ```dart
      /// class NavigationService{
      ///    static var navigatorKey = GlobalKey<NavigatorState>();
      /// }
      /// ```
      navigatorKey: NavigationService.navigatorKey,
      initialRoute: MainPage.routeName,
      routes: NavigationService.routes,
    ),
  }
```

Then you can use the global key to get the context for `Navigator.push`
```dart
/// Get the current context
var context = NavigationService.navigatorKey.currentContext;
/// Call the `goToActivityPage` method and Supply the context
goToActivityPage(context);
```
