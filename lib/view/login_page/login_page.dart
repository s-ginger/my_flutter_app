import 'package:flutter/material.dart';
import 'package:my_notesflutter/view/view.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {

  final _formKey = GlobalKey<FormState>();

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isObscure = true;

  void _login() async {
    if (_formKey.currentState!.validate()) {
      var authRepo = DataWidget.of(context).authRepo;

      final val = await authRepo.login(
          username: _usernameController.text,
          password: _passwordController.text
      );

      if (!mounted) return;

      if (val == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Регистрация успешна для ${authRepo.username}',
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
          )
        );
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Ошибка входа')));
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Вход'),
              IconButton(
                icon: const Icon(Icons.settings),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                      const RegisterPage(),
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
          )
      ),
      body: Padding(
          padding: const EdgeInsets.only(
            left: 16,
            top: 34,
            right: 16,
            bottom: 16
          ),
        child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _usernameController,
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
                    labelText: "Введите пароль",
                    border: const UnderlineInputBorder(),
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _isObscure = !_isObscure;
                          });
                        },
                        icon: Icon(
                          _isObscure ? Icons.visibility : Icons.visibility_off,
                        )
                    )
                  ),
                  validator: (value) =>
                  value == null || value.isEmpty ? "Введите имя" : null,
                ),

                const SizedBox(height: 26),

                ElevatedButton(
                    onPressed: _login,
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50)
                    ),
                    child: const Text("Войти"),
                ),
              ],
            )
        ),
      ),
    );
  }
}

