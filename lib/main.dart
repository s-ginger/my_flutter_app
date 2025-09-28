import 'package:flutter/material.dart';
import 'package:my_notesflutter/repository/repository.dart';
import 'package:my_notesflutter/source/source.dart';
import 'package:my_notesflutter/view/view.dart';
import 'my_app.dart';

void main() {
  runApp(
    DataWidget(
      authRepo: AuthRepository(authSource: AuthSource()),
      child: const MyApp()
    )
  );
}
