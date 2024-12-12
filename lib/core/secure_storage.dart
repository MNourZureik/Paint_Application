import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage{
  static final SecureStorage _storage = SecureStorage._internal();
  static const flutterSecureStorage = FlutterSecureStorage();
  factory SecureStorage(){
    return _storage;
  }
  SecureStorage._internal();


  Future<void> storeValue(String key , dynamic value)async{
    await flutterSecureStorage.write(key: key, value: value);
  }
  Future<String?> readValue(String key )async{
    return flutterSecureStorage.read(key: key);
  }
  Future<Map<String, String>> readAllValue( )async{
    return flutterSecureStorage.readAll();
  }

  Future<void> deleteValue(String key )async{
    return flutterSecureStorage.delete(key: key);
  }

}