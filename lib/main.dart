import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  const MaterialApp(
      title: 'Drinking Reminder',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage> {
  late SharedPreferences pref;
  int  counter = 0;

  @override
  void initState() {
    super.initState();
    setParameters();
  }
  void setParameters() async {
    pref = await SharedPreferences.getInstance();
    if(pref.containsKey('counter')){
      counter =  pref.getInt("counter")!;
    }else{
      counter = 0;
      pref.setInt('counter', 0);
    }
  }
  void _incrementCounter()  {
    setState(() {
      counter++;
      pref.setInt('counter', counter);
    });
  }
  void _resetCounter(){
    setState(() {
      counter = 0;
      pref.setInt('counter', 0);
    });
  }
  void _removeOne(){
    setState(() {
      counter--;
      pref.setInt('counter', counter);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Drinking Reminder"),
        backgroundColor: const Color(0xffff748c),
        actions: [
          IconButton(
              onPressed: _resetCounter,
              icon: const Icon(Icons.restart_alt)
          ),
          IconButton(
              onPressed: _removeOne,
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
              '$counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            const Image(
                image: AssetImage('assets/icons/cup.png')
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        backgroundColor: const Color(0xffff748c),
        child: const Icon(Icons.add),
      ),
    );
  }
}
