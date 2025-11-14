import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

Future<void> main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  await loadAppFonts();
}
