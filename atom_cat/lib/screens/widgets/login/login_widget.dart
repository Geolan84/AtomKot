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
            child: Row(
              children: [
                const Expanded(
                  flex: 5,
                  child: _LogoImage(),
                ),
                Expanded(
                    flex: 4,
                    child: Container(
                      width: 1000,
                      height: 1000,
                      color: const Color.fromRGBO(14, 20, 34, 1),
                      child: const _ListBodyFields(),
                    )),
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
      //padding: const EdgeInsets.symmetric(),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(height: 47),
          _TitleInfo(),
          SizedBox(height: 3),
          Text(
            "Рады видеть вас снова!",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w400,
              height: 1.1,
              letterSpacing: 0,
              color: Color.fromRGBO(255, 255, 255, 0.75),
            ),
          ),
          SizedBox(height: 30),
          _LoginForm(),
          SizedBox(height: 25),
          _LoginButton(),
          SizedBox(height: 15),
          Text(
            "войти c помощью",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                height: 1.1,
                letterSpacing: 0,
                color: Color.fromRGBO(255, 255, 255, 0.5)),
          ),
          SizedBox(height: 20),
          _IconLine(),
          SizedBox(height: 40),
          Text(
            "АтомКот 2023",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                height: 1.1,
                letterSpacing: 0,
                color: Color.fromRGBO(255, 255, 255, 0.5)),
          ),
          SizedBox(height: 32),
          //_RegisterForgot()
        ],
      ),
    );
  }
}

class _TitleInfo extends StatelessWidget {
  const _TitleInfo({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: const EdgeInsets.symmetric(
      //     vertical: 13), // Добавляем вертикальный отступ
      child: const Align(
        alignment: Alignment.bottomCenter,
        child: Text(
          "Войти в аккаунт",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 45,
              height: 1.1,
              letterSpacing: 0,
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

    return Column(
      children: [
        SizedBox(
          width: 420,
          height: 60,
          child: ElevatedButton(
            onPressed: onPressed,
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                  const Color.fromRGBO(0, 102, 255, 1)),
            ),
            child: child,
          ),
        ),
        const SizedBox(height: 5), // Добавляем небольшой отступ
        const SizedBox(
          width: 420,
          child: Text(
            "Зарегистрироваться",
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              height: 1.1,
              letterSpacing: 0,
              color: Color.fromRGBO(0, 102, 255, 1),
            ),
          ),
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}

class _IconLine extends StatelessWidget {
  const _IconLine({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          backgroundImage: AssetImage(
            'assets/icons/yandex.png',
          ),
          radius: 25,
        ),
        SizedBox(width: 10),
        CircleAvatar(
          backgroundImage: AssetImage(
            'assets/icons/belka.png',
          ),
          radius: 25,
        ),
        SizedBox(width: 10),
        CircleAvatar(
          backgroundImage: AssetImage(
            'assets/icons/deli.png',
          ),
          radius: 25,
        ),
      ],
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

class _LoginForm extends StatelessWidget {
  const _LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.read<AuthViewModel>();
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //const _ErrorMessageWidget(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Логин",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  height: 1.1,
                  letterSpacing: 0,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 5),
              SizedBox(
                width: 420,
                // height: 92,
                child: TextFormField(
                  style: TextStyle(color: Colors.white),
                  controller: model.emailTextInputController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    fillColor: const Color.fromRGBO(25, 32, 52, 1),
                    filled: true,
                    // hintText: "Email",
                    // hintStyle: const TextStyle(
                    //   fontWeight: FontWeight.bold,
                    //   fontSize: 23,
                    //   color: Color.fromARGB(72, 230, 230, 230),
                    // ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.transparent),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.transparent),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                          color: Color.fromRGBO(0, 102, 255,
                              1)), // Replace YOUR_CUSTOM_COLOR with your desired color
                    ),
                  ),
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
              ),
            ],
          ),
          const SizedBox(height: 30),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Пароль",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  height: 1.1,
                  letterSpacing: 0,
                  color: Colors.white,
                ),
              ),
              //const SizedBox(height: 5),
              SizedBox(
                width: 420,
                //height: 92,
                child: TextFormField(
                  controller: model.passwordTextInputController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    fillColor: const Color.fromRGBO(25, 32, 52, 1),
                    filled: true,
                    // hintText: "Пароль",
                    // hintStyle: const TextStyle(
                    //   fontWeight: FontWeight.bold,
                    //   fontSize: 23,
                    //   color: Color.fromARGB(72, 230, 230, 230),
                    // ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.transparent),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.transparent),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                          color: Color.fromRGBO(0, 102, 255,
                              1)), // Replace YOUR_CUSTOM_COLOR with your desired color
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
                ),
              ),
              const SizedBox(
                width: 420,
                //height: 92,
                child: Text(
                  "Забыли пароль?",
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    height: 1.1,
                    letterSpacing: 0,
                    color: Color.fromRGBO(0, 102, 255, 1),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
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
