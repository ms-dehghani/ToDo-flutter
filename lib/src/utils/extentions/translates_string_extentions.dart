
import 'package:kardone/translations.dart';

extension Translate on String {
  String get translate => Translations.instance().text(this);
}