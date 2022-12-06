import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_login/constants/app_colors.dart';

import 'package:lottie/lottie.dart';
import 'package:responsive_login/constants/routes.dart';
import 'package:responsive_login/ui/widget/design.dart';

import 'controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Controller loginController = Get.put(Controller());
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth > 600) {
              return _buildLargeScreen(size, loginController);
            } else {
              return Stack(
                children: [
                  Container(
                    height: constraints.maxHeight,
                    width: constraints.maxWidth,
                    alignment: Alignment.center,
                    child: Lottie.asset(
                      "assets/lotties/bg_bounce.json",
                      animate: true,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Container(
                    decoration:
                        BoxDecoration(color: AppColors.white.withOpacity(0.8)),
                    height: constraints.maxHeight,
                    width: constraints.maxWidth,
                  ),
                  _buildSmallScreen(size, loginController),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  /// For large screens
  Widget _buildLargeScreen(
    Size size,
    Controller loginController,
  ) {
    return Row(
      children: [
        Expanded(
          flex: 4,
          child: Lottie.asset(
            'assets/lotties/login_man.json',
            width: double.infinity,
            fit: BoxFit.fill,
          ),
        ),
        SizedBox(width: size.width * 0.05),
        Expanded(
          flex: 5,
          child: _buildMainBody(
            size,
            loginController,
          ),
        )
      ],
    );
  }

  /// For Small screens
  Widget _buildSmallScreen(
    Size size,
    Controller loginController,
  ) {
    return Center(
      child: _buildMainBody(
        size,
        loginController,
      ),
    );
  }

  /// Main Body
  Widget _buildMainBody(
    Size size,
    Controller loginController,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: size.width < 600 ? size.width * 0.02 : 0,
          vertical: size.width < 600 ? size.height * 0.02 : 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: size.width > 600
            ? MainAxisAlignment.center
            : MainAxisAlignment.start,
        children: [
          size.width > 600
              ? const SizedBox.shrink()
              : Lottie.asset(
                  'assets/lotties/login_code.json',
                  height: size.height * 0.2,
                  width: size.width,
                  fit: BoxFit.contain,
                ),
          SizedBox(
            height: size.height * 0.03,
          ),
          // SizedBox(
          //   height: size.width < 600 ? size.height * 0.2 : 0.0,
          // ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Text(
              "Connexion",
              style: kLoginTitleStyle(size),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Text(
              'Gestion boutique, ventes, stock, clients et commandes',
              style: kLoginSubtitleStyle(size),
            ),
          ),
          SizedBox(
            height: size.height * 0.03,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: Form(
              key: _formKey,
              child: Container(
                constraints: const BoxConstraints(maxWidth: 420),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    /// username or Gmail
                    TextFormField(
                      style: kTextFormFieldStyle(),
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        hintText: "Identifiant",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                      ),
                      controller: nameController,
                      // The validator receives the text that the user has entered.
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Entrez votre identifiant';
                        } else if (value.length < 4) {
                          return 'Identifiant invalide';
                        } else if (value.length > 20) {
                          return 'Identifiant incorrect';
                        }
                        return null;
                      },
                    ),

                    SizedBox(
                      height: size.height * 0.02,
                    ),

                    /// password
                    Obx(
                      () => TextFormField(
                        style: kTextFormFieldStyle(),
                        controller: passwordController,
                        obscureText: loginController.isObscure.value,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.lock_open),
                          suffixIcon: IconButton(
                            icon: Icon(
                              loginController.isObscure.value
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              loginController.isObscureActive();
                            },
                          ),
                          hintText: 'Mot de passe',
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                        ),
                        // The validator receives the text that the user has entered.
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Entrez votre mot de passe';
                          } else if (value.length < 6) {
                            return 'Mot de passe invalide';
                          } else if (value.length > 20) {
                            return 'Mot de passe incorrecte';
                          }
                          return null;
                        },
                      ),
                    ),

                    SizedBox(
                      height: size.height * 0.02,
                    ),

                    /// Login Button
                    loginButton(),
                    SizedBox(
                      height: size.height * 0.03,
                    ),

                    /// Navigate To Login Screen
                    GestureDetector(
                      onTap: () {
                        nameController.clear();
                        emailController.clear();
                        passwordController.clear();
                        _formKey.currentState?.reset();
                        loginController.isObscure.value = true;
                        Get.toNamed(Routes.register);
                      },
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: "Vous n'avez pas encore de compte ?",
                          style: kHaveAnAccountStyle(size),
                          children: [
                            TextSpan(
                              text: " Inscrivez-vous gratuitement",
                              style: kLoginOrSignUpTextStyle(
                                size,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Login Button
  Widget loginButton() {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(AppColors.indigoAccent),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
        onPressed: () {
          // Validate returns true if the form is valid, or false otherwise.
          if (_formKey.currentState!.validate()) {
            // ... Navigate To your Home Page
          }
        },
        child: const Text('Se connecter'),
      ),
    );
  }
}
