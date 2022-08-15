import 'package:awesome_notifications/awesome_notifications.dart';

void showNotification(int water){
  AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 1,
        channelKey: 'basic',
        title: 'Time to Drink',
        body: 'You drank $water cups today.',
        autoDismissible: false,
      ),
  );
}
void requestPermission(){
  AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
    if (!isAllowed) {
      AwesomeNotifications().requestPermissionToSendNotifications();
    }
  });
}
