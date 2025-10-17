import 'package:flutter/cupertino.dart';
import 'package:my_notesflutter/repository/repository.dart';

class DataWidget extends InheritedWidget {
  final IAuthRepository authRepo;

  const DataWidget({
    required this.authRepo,
    required super.child,
    super.key
  });

  static DataWidget of(BuildContext context) {
    final DataWidget? result = context
        .dependOnInheritedWidgetOfExactType<DataWidget>();
    assert(result != null, 'No DataWidget found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(covariant DataWidget oldWidget) {
    return oldWidget.authRepo != authRepo;
  }
}
