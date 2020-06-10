

class BadRequestException implements Exception {
  @override
  String toString() {
    return 'Erreur de communication avec le serveur';
  }
}