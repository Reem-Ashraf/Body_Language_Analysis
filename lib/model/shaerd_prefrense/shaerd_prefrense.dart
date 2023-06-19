import 'package:shared_preferences/shared_preferences.dart';
class CacheHelper{

  static late SharedPreferences sharedPreferences;

  //Here The Initialize of cache .
  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static dynamic getData({
    required String key,
  }) {
    return sharedPreferences.get(key);
  }

  // this fun to put data in local data base using key
  static Future<bool?> saveData({
    required String key,
    required dynamic value,
  })async{
    // Obtain shared preferences.

    if (value is String) {return await sharedPreferences.setString(key, value);}
    else if (value is bool) {return await sharedPreferences.setBool(key, value);}
    else if (value is double) {return await  sharedPreferences.setDouble(key, value);}
    else{ return await sharedPreferences.setInt(key, value);}

  }


  // remove data using specific key
  static Future<bool> removeData({required key}) async {
    return await sharedPreferences.remove(key);
  }

//clear all data in the local data base
  static Future<bool> clearData() async {
    return await sharedPreferences.clear();
  }

}