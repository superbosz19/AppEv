import 'dart:convert';
import 'package:encrypt/encrypt.dart' as enc;
class EncryptUtil{
 // static final EncryptUtil instance = EncryptUtil();
  static final enc.Key key = enc.Key.fromUtf8('IYDH8TYURRA5E80FNC1Z37HILEUTXF7X');
  static final enc.Key b64key = enc.Key.fromBase64(base64Url.encode(key.bytes));
  static final fernet = enc.Fernet(b64key);
  static final encrypter = enc.Encrypter(fernet);

  static  String decrypt(String encrypt){
    return encrypter.decrypt(enc.Encrypted.fromBase64(encrypt));
  }

  static String encrypt(String data){
    return encrypter.encrypt(data).base64;
  }


}
/*

 final key = enc.Key.fromUtf8('IYDH8TYURRA5E80FNC1Z37HILEUTXF7X');
                       print(base64Url.encode(key.bytes));
                       //SVlESDhUWVVSUkE1RTgwRk5DMVozN0hJTEVVVFhGN1g=

                      String enc1 = 'gAAAAABg3fzMu9scoJIT6Ua651bjLseEDQcYS3u4Qrfz80SU0mFjhOFJ2o-4LXI9ArRNnfNLhd5bxXWZrAqq7XVRMA_O3B1CUdnd463xqyYVc94RT5UL9Hw=';

                      final b64key = enc.Key.fromBase64(base64Url.encode(key.bytes)); // enc.Key.fromUtf8(base64Url.encode(key.bytes));
                      // if you need to use the ttl feature, you'll need to use APIs in the algorithm itself
                      final fernet = enc.Fernet(b64key);
                      final encrypter = enc.Encrypter(fernet);
                       //final encrypted = encrypter.encrypt(xx);
                       final decrypted = encrypter.decrypt(enc.Encrypted.fromBase64(enc1));
 */