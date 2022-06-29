import 'dart:io';
import 'dart:convert';

import 'package:tab_manager/amplifyconfiguration.dart';
import 'package:barcode/barcode.dart';

Future<void> main() async {
  print("CONFIG Length: ${amplifyconfig.length}");
  final minified = json.encode(json.decode(amplifyconfig));
  print("MINIFIED Length: ${minified.length}");
  final compressed = GZipCodec().encode(utf8.encode(minified));
  print("COMPRESSED Length: ${compressed.length}");
  final encoded = base64.encode(compressed);
  print("ENCODED Length: ${encoded.length}");
  print("================= CONNECTION STRING:");
  print(encoded);

  void buildBarcode(
    Barcode bc,
    String data, {
    String? filename,
    double? width,
    double? height,
    double? fontHeight,
  }) {
    final svg = bc.toSvg(
      data,
      width: 1111,
      height: 1111,
      fontHeight: fontHeight,
    );

    filename ??= bc.name.replaceAll(RegExp(r'\s'), '-').toLowerCase();
    File('$filename.svg').writeAsStringSync(svg);
  }

  buildBarcode(
    Barcode.qrCode(),
    encoded,
  );

  print("================= QR CODE saved to: ` qr-code.svg ` ");
}
