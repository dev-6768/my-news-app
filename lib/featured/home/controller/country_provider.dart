import 'package:flutter_riverpod/flutter_riverpod.dart';

final countryProvider = StateProvider<String>((ref) {
  return 'IN';
});