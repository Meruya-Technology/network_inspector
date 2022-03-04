This is example how to use network inspector on provider, it's also can be done in statefullwidget / or another state management.
```dart
class MainProvider extends ChangeNotifier {
    final BuildContext context;
    MainProvider({
        required this.context,
    }) {
        injectDependencies();
    }

    NotificationHelper? notificationHelper;
    NetworkInspector? networkInspector;

    Future<void> injectDependencies() async {
        notificationHelper = NotificationHelper();
        networkInspector = NetworkInspector();
    }

    /// this is for wraping inspector & interceptor into dioClient, 
    /// it's also contain an example for set default properties
    Dio get dioClient {
        return Dio(
        BaseOptions(
            baseUrl: 'http://192.168.1.6:8000/',
            connectTimeout: 10 * 1000, // 10 second
            headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer i109gh23j9u1h3811io2n391'
            },
        ),
        )..interceptors.add(
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
    }

    /// this is for wraping inspector & interceptor into Client (http package), 
    /// it's also contain an example for set default properties
    HttpInterceptor get httpClient {
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

    /// This method is a callback to call when the http activity logged
    Future<void> notifyActivity({
        required String title,
        required String message,
    }) async {
        await notificationHelper?.showNotification(
        classHashId: notificationHelper.hashCode,
        title: title,
        message: message,
        payload: 'networkInspector',
        );
    }

    /// Use dio regularly
    /// Every request, response & error will automatically fetched & stored by the network inspector.
    /// And also if the properties of declared `DioInterceptor` is not empty, it will set every properties as default.
    await dioClient.post('/test', data: {'id': 1, 'name': 'jhon folks'});

    /// Use http client regularly
    /// Every request, response & error will automatically fetched & stored by the network inspector.
    /// And also if the properties of declared `HttpInterceptor` is not empty, it will set every properties as default.
    await httpClient.post(url, body: {'name': 'doodle', 'color': 'blue'});
}
```