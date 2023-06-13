import 'dart:math';

class UniqueID {
  String generateUniqueId() {
    const String characters =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    Random random = Random();
    String id = '';

    for (int i = 0; i < 5; i++) {
      int index = random.nextInt(characters.length);
      id += characters[index];
    }

    return id;
  }
}
