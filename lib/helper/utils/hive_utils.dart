import 'package:hive_flutter/hive_flutter.dart';




class HiveBox {

  String hiveBoxTitle = 'fuelogic';
  String hiveBoxTitle2 = 'fuelogic';

  Future<void> openBoxes() async {
    await Hive.initFlutter();
    await Hive.openBox(hiveBoxTitle);
    await Hive.openBox(hiveBoxTitle2);
  }

  setOnBoardingValue({required String key, required dynamic value}) async {
    var box = Hive.box(hiveBoxTitle2);
    await box.put(key, value);
  }

  getOnBoardingValue({required String key, dynamic defaultValue}) {
    var box = Hive.box(hiveBoxTitle2);
    return box.get(key, defaultValue: defaultValue);
  }


  setValue({required String key, required dynamic value}) async {
    var box = Hive.box(hiveBoxTitle);
    await box.put(key, value);
  }

  getValue({required String key, dynamic defaultValue}) {
    var box = Hive.box(hiveBoxTitle);
    return box.get(key, defaultValue: defaultValue);
  }

  deleteValue({required String key}) async {
    var box = Hive.box(hiveBoxTitle);
    await box.delete(key);
  }

  clearAppSession() async{
    var box = Hive.box(hiveBoxTitle);
    await box.clear();
  }



}
