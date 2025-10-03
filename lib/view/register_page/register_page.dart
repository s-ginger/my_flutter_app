import 'package:flutter/material.dart';
import 'package:my_notesflutter/view/login_page/login_page.dart';
import '../view.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPage();
}

class _RegisterPage extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isObscure = true;

  void _register() async {
    if (_formKey.currentState!.validate()) {
      var authRepo = DataWidget.of(context).authRepo;

      final val = await authRepo.register(
        username: _usernameController.text,
        password: _passwordController.text,
      );

      if (!mounted) return;

      if (val == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Регистрация успешна для ${_usernameController.text}',
            ),
          ),
        );

        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const HomePage(title: "Home page"),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
                  return FadeTransition(opacity: animation, child: child);
                },
            transitionDuration: Duration(milliseconds: 500),
          ),
        );
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Ошибка регистрации')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween, // ← разнести по сторонам
          children: [
            const Text('Регистрация'),
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                    const LoginPage(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      return FadeTransition(opacity: animation, child: child);
                    },
                    transitionDuration: Duration(milliseconds: 500),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 16,
          top: 34,
          right: 16,
          bottom: 16,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _usernameController,
                obscureText: false,
                decoration: const InputDecoration(
                  labelText: "Введите имя",
                  border: UnderlineInputBorder(),
                ),
                validator: (value) =>
                    value == null || value.isEmpty ? "Введите имя" : null,
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _passwordController,
                obscureText: _isObscure,
                decoration: InputDecoration(
                  labelText: 'Введите пароль',
                  border: const UnderlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isObscure ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _isObscure = !_isObscure;
                      });
                    },
                  ),
                ),
                validator: (value) => value != null && value.length < 6
                    ? "Пароль должен быть не меньше 6 символов"
                    : null,
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _confirmPasswordController,
                obscureText: _isObscure,
                decoration: const InputDecoration(
                  labelText: "Подтвердите пароль",
                  border: UnderlineInputBorder(),
                ),
                validator: (value) => value != _passwordController.text
                    ? "Пароли не совпадают"
                    : null,
              ),
              const SizedBox(height: 24),

              ElevatedButton(
                onPressed: _register,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                ),
                child: const Text("Зарегистрироваться"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
