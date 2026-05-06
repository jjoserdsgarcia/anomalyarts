import 'dart:convert';
import 'package:crypto/crypto.dart';

class Utils {
  static String gerarMD5(String texto) {
    var bytes = utf8.encode(texto);
    var digest = md5.convert(bytes);
    return digest.toString();
  }
}
