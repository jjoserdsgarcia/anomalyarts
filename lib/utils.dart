import 'dart:crypto';

class Utils {
  static String gerarMd5(String texto) {
    final bytes = utf8.encode(texto);
    final digest = md5.convert(bytes);
    return digest.toString();
  }
}
