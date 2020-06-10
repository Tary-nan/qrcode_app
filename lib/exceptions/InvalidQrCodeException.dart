
class InvalidQrCodeException implements Exception {
  @override
  String toString() {
    return "Le code Qr ne correspond pas";
  }
}