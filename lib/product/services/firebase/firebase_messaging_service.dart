import 'dart:convert';
import 'package:deu_cis/product/constants/index.dart';
import 'package:deu_cis/product/models/fcm_notification.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:http/http.dart' as http;
import 'package:deu_cis/firebase_options.dart';

class FirebaseNotificationService {
  static final FirebaseMessaging _firebaseMessaging =
      FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin _localNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static late AndroidNotificationChannel _channel;
  static String? accessToken;

  /// Firebase ve Local Notifications'ı başlat
  static Future<void> initialize() async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    // await requestForPermision();

    // Bildirim kanalını oluştur
    _channel = const AndroidNotificationChannel(
      ledColor: AppColors.themeColor,
      'high_importance_channel',
      'High Importance Notifications',
      description: 'This channel is used for important notifications.',
      importance: Importance.high,
    );

    // Android için bildirimleri ayarla
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings("@mipmap/ic_launcher");
    //"@mipmap/ic_launcher"

    // iOS için bildirimleri ayarla
    const DarwinInitializationSettings iosSettings =
        DarwinInitializationSettings();

    const InitializationSettings initializationSettings =
        InitializationSettings(android: androidSettings, iOS: iosSettings);

    await _localNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (NotificationResponse response) {
      print("Bildirim tıklandı: ${response.payload}");
    });

    await _localNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(_channel);

    // Firebase bildirimi dinleme
    FirebaseMessaging.onMessage.listen(_handleForegroundNotification);
    FirebaseMessaging.onBackgroundMessage(_handleBackgroundMessage);

    accessToken = await _getAccessToken();
  }

  static Future<void> requestForPermision() async {
    await _firebaseMessaging.requestPermission();
  }

  /// Foreground bildirimleri göster
  static void _handleForegroundNotification(RemoteMessage message) {
    print('Foreground Notification: ${message.notification?.title}');
    _showLocalNotification(message);
  }

  /// Background'da bildirimi al
  static Future<void> _handleBackgroundMessage(RemoteMessage message) async {
    print('Background Notification: ${message.notification?.title}');
  }

  /// Firebase token'ı al
  static Future<String?> getFCMToken() async {
    String? token = await _firebaseMessaging.getToken();
    print('FCM Token: $token');
    return token;
  }

  /// **Lokal bildirimleri göster**
  static void _showLocalNotification(RemoteMessage message) {
    final NotificationDetails details = NotificationDetails(
      android: AndroidNotificationDetails(
        _channel.id,
        _channel.name,
        channelDescription: _channel.description,
        importance: Importance.high,
        priority: Priority.high,
      ),
      iOS: const DarwinNotificationDetails(),
    );

    _localNotificationsPlugin.show(
      0,
      message.notification?.title,
      message.notification?.body,
      details,
      payload: jsonEncode(message.data),
    );
  }

  /// **Google FCM API ile Bildirim Gönderme**
  static Future<void> sendNotification(FcmNotification fcmNotification) async {
    // final String accessToken = await _getAccessToken();
    final String fcmUrl =
        'https://fcm.googleapis.com/v1/projects/aparturademo/messages:send';

    final response = await http.post(
      Uri.parse(fcmUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
      body: jsonEncode({
        'message': {
          'token': fcmNotification.token,
          'notification': {
            'title': fcmNotification.title,
            'body': fcmNotification.message
          },
          'data': {'click_action': 'FLUTTER_NOTIFICATION_CLICK'},
        },
      }),
    );

    if (response.statusCode == 200) {
      print('Notification sent successfully');
    } else {
      print('Failed to send notification: ${response.body}');
    }
  }

  /// **Google API Access Token Alma**
  static Future<String> _getAccessToken() async {
    final jsonString = await rootBundle.loadString(
      'assets/notifications_key/deu-cis-00b03cb78ce3.json',
    );

    final accountCredentials =
        auth.ServiceAccountCredentials.fromJson(jsonString);
    final scopes = ['https://www.googleapis.com/auth/firebase.messaging'];
    final client =
        await auth.clientViaServiceAccount(accountCredentials, scopes);

    return client.credentials.accessToken.data;
  }
}
