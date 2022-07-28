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
  var _counter;

  @override
  void initState() {
    super.initState();
    setParameters().then((value){
      setState((){
        _counter = value;
      });
    });
  }
  Future<int> setParameters() async {
    int counter;
    pref = await SharedPreferences.getInstance();
    if(pref.containsKey('counter')){
      counter =  pref.getInt("counter")!;
    }else{
      counter = 0;
      pref.setInt('counter', 0);
    }
    return counter;
  }
  void _incrementCounter()  {
    setState(() {
      _counter++;
      pref.setInt('counter', _counter);
    });
  }
  void _resetCounter(){
    setState(() {
      _counter = 0;
      pref.setInt('counter', 0);
    });
  }
  void _removeOne(){
    setState(() {
      _counter = (_counter >0)?_counter-1:0;
      pref.setInt('counter', _counter);
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
              '$_counter',
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
