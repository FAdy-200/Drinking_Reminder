import 'package:shared_preferences/shared_preferences.dart';

class Cups{
  late SharedPreferences pref;

  Future<int> init() async {
    int counter = 0;
    pref = await SharedPreferences.getInstance();
    if(pref.containsKey('counter')){
      counter = pref.getInt('counter')!;
      return counter;
    }else{
      pref.setInt('counter', 0);
      return counter;
    }
  }

  int getCounter() {
    return pref.getInt('counter')!;
  }

  int incrementCounter() {
    int counter =  getCounter();
    counter++;
    pref.setInt('counter', counter);
    return counter;
  }

  void resetCounter(){
    pref.setInt('counter', 0);
  }

  int removeOne(){
    int counter =  getCounter();
    counter = (counter >0)?counter-1:0;
    pref.setInt('counter', counter);
    return counter;
  }

}

void notiIncrement() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  int counter = pref.getInt('counter')!;
  pref.setInt('counter', ++counter);
}