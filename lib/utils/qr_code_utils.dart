import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/material.dart';

class QRCodeUtils {
  static QrImage generateQRCode(String data) {
    return QrImage(
      data: data,
      version: QrVersions.auto,
      size: 200.0, // Define o tamanho da imagem
    );
  }
}
