import 'package:awesome_notifications/awesome_notifications.dart';


void initializeNotification(){
  AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
          channelGroupKey: 'basic_key',
          channelKey: 'basic',
          channelName: 'Basic notifications',
          channelDescription: 'Notification channel for drinking reminders',
          channelShowBadge: true,
          importance: NotificationImportance.High,
          enableVibration: true,
        ),
      ],
      debug: true
  );
}

void showNotification(int water){
  AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 1,
        channelKey: 'basic',
        title: 'Time to Drink',
        body: 'You drank $water cups today.',
        autoDismissible: true,
      ),
    actionButtons: [
      NotificationActionButton(
        key: "drink",
        label: "Drink",
        actionType: ActionType.SilentBackgroundAction,
      )
    ],
  );
}

void requestPermission(){
  AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
    if (!isAllowed) {
      AwesomeNotifications().requestPermissionToSendNotifications();
    }
  });
}
