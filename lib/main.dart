import 'package:flutter/material.dart';
import 'package:my_notesflutter/repository/repository.dart';
import 'package:my_notesflutter/view/view.dart';
import 'my_app.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


Future<void> main() async {
  await Supabase.initialize(
    url: 'https://hdirghcrryqfwbthjvoh.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImhkaXJnaGNycnlxZndidGhqdm9oIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTEzNjA2MjIsImV4cCI6MjA2NjkzNjYyMn0.2-01eItZxgqbosKks12IQgu4OIEUfWLqjz5l0iyOmQo',
  );

  runApp(
    DataWidget(
      authRepo: SupabaseRepository(client: Supabase.instance.client),
      child: const MyApp()
    )
  );
}


