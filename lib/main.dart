import 'package:flutter/material.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'notification_handler.dart';
import 'cups.dart';
Cups handler = Cups();

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  initializeNotification();
  await handler.init();
  runApp(const MaterialApp(
    title: 'Drinking Reminder',
    home: MyHomePage(),
  ));
}


class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage> {
  var _counter;

  @override
  void initState() {
    super.initState();
    requestPermission();
    _counter = handler.getCounter();
    AwesomeNotifications().setListeners(
      onActionReceivedMethod: onActionReceivedMethod
    );
  }
  static Future <void> onActionReceivedMethod(ReceivedAction receivedAction) async {
    if(receivedAction.buttonKeyPressed == "drink"){
      await handler.init();
      handler.incrementCounter();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Drinking Reminder"),
        backgroundColor: const Color(0xffff748c),
        actions: [
          IconButton(
              onPressed: (){
                handler.resetCounter();
                setState(() {
                  _counter = 0;
                });
              },
              icon: const Icon(Icons.restart_alt)
          ),
          IconButton(
              onPressed: (){
                setState(() {
                  _counter = handler.removeOne();
                });
              },
              icon: const Icon(Icons.exposure_minus_1)
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Cups:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            const Image(
                image: AssetImage('assets/icons/cup.png')
            ),
            // TESTING NOTIFICATION MUST BE REMOVED LATER
            ElevatedButton(
                onPressed: () {
                    print(handler.getCounter());
                    showNotification(_counter);
                  },
                child: const Text("Show Notification")
            )
            // ---------------------
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
            setState(() {
              _counter = handler.incrementCounter();
            });
          },
        tooltip: 'Increment',
        backgroundColor: const Color(0xffff748c),
        child: const Icon(Icons.add),
      ),
    );
  }
}
