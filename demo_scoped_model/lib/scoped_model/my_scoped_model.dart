import 'package:scoped_model/scoped_model.dart';

class MyScopedModel extends Model {
  int value = 0;
  void incrementValue() {
    value = value + 1;
    notifyListeners();
  }

  void decrementValue() {
    value = value - 1;
    notifyListeners();
  }
}
