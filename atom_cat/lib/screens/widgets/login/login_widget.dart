import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:atom_cat/screens/utils.dart';
import 'package:atom_cat/screens/widgets/login/login_view_model.dart';

class AuthWidget extends StatelessWidget {
  const AuthWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 9, 14, 26),
      body: SingleChildScrollView(
        reverse: true,
        child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height,
            ),
            child: const Row(
              children: [
                Expanded(
                  flex: 3,
                  child: _LogoImage(),
                ),
                Expanded(
                  flex: 5,
                  child: _ListBodyFields(),
                )
              ],
            ) //const _ListBodyFields(),
            ),
      ),
    );
  }
}

class _ListBodyFields extends StatelessWidget {
  const _ListBodyFields({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(100),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _TitleInfo(),
          _LoginForm(),
          _LoginButton(),
          _IconLine(),
          //_RegisterForgot()
        ],
      ),
    );
  }
}

class _TitleInfo extends StatelessWidget {
  const _TitleInfo({Key? key}) : super(key: key);
// Это прошлый код, я его поменял на нижний
//   @override
//   Widget build(BuildContext context) {
//     return const Text(
//       //LocaleSwitcher.of(context)!.signintitle,
//       "Авторизация",
//       textAlign: TextAlign.center,
//       style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
//     );
//   }
// }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          vertical: 13), // Добавляем вертикальный отступ
      child: const Align(
        alignment: Alignment.bottomCenter,
        child: Text(
          "Авторизация",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 23,
              color: const Color.fromARGB(255, 255, 255, 255)),
        ),
      ),
    );
  }
}

class _LoginButton extends StatelessWidget {
  const _LoginButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<AuthViewModel>();
    final onPressed = model.canStartAuth ? () => model.auth(context) : null;
    final child = model.isAuthProgress
        ? const SizedBox(
            width: 15,
            height: 15,
            child: CircularProgressIndicator(strokeWidth: 2),
          )
        : const Text(
            "Войти",
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
          );
    return ElevatedButton(
        onPressed: onPressed,
        child: child,
        style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all(Color.fromARGB(255, 93, 62, 194))));
  }
}

class _IconLine extends StatelessWidget {
  const _IconLine({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundImage: AssetImage(
              'assets/icons/yandex.png',
            ),
            radius: 50,
          ),
          CircleAvatar(
            backgroundImage: AssetImage(
              'assets/icons/belka.png',
            ),
            radius: 50,
          ),
          CircleAvatar(
            backgroundImage: AssetImage(
              'assets/icons/deli.png',
            ),
            radius: 50,
          ),
        ],
      ),
    );
  }
}

class _LogoImage extends StatelessWidget {
  const _LogoImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Image.asset(
              "assets/icons/logo.jpeg",
              fit: BoxFit.contain, // чтобы картинка сохраняла свои пропорции
            ),
          ),
        ),
      ],
    );
  }
}

// class _RegisterForgot extends StatelessWidget {
//   const _RegisterForgot({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         TextButton(
//           onPressed: () {
//             Navigator.of(context).pushReplacementNamed('/forgot');
//           },
//           child: Text(LocaleSwitcher.of(context)!.forgot),
//         ),
//         TextButton(
//           onPressed: () {
//             Navigator.of(context).pushReplacementNamed('/register');
//           },
//           child: Text(LocaleSwitcher.of(context)!.signupbut),
//         ),
//       ],
//     );
//   }
// }

class _LoginForm extends StatelessWidget {
  const _LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.read<AuthViewModel>();
    return Column(children: [
      const _ErrorMessageWidget(),
      TextFormField(
        style: TextStyle(color: Colors.white),
        controller: model.emailTextInputController,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
            fillColor: Color.fromARGB(255, 43, 41, 59),
            filled: true,
            hintText: "Email",
            hintStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 23,
                color: Color.fromARGB(72, 230, 230, 230)),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.transparent),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.transparent),
            )),
        keyboardType: TextInputType.emailAddress,
        validator: (val) {
          if (val == null || val.isEmpty) {
            return "Пустое поле!";
          } else if (!validateEmail(val)) {
            return "Неверный email!";
          }
          return null;
        },
      ),
      const SizedBox(height: 15),
      TextFormField(
        controller: model.passwordTextInputController,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          fillColor: Color.fromARGB(255, 43, 41, 59),
          filled: true,
          hintText: "Пароль",
          hintStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 23,
              color: Color.fromARGB(72, 230, 230, 230)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.transparent),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.transparent),
          ),
        ),
        obscureText: true,
        validator: (val) {
          if (val == null || val.isEmpty) {
            return "Поле не может быть пустым!";
          } else if (!validatePassword(val)) {
            return "Некорректный формат пароля!";
          }
          return null;
        },
      )
    ]);
  }
}

class _ErrorMessageWidget extends StatelessWidget {
  const _ErrorMessageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final errorMessage = context.select((AuthViewModel m) => m.errorMessage);
    if (errorMessage == null) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Text(
        errorMessage,
        style: const TextStyle(
          fontSize: 17,
          color: Color.fromARGB(255, 255, 0, 0),
        ),
      ),
    );
  }
}
