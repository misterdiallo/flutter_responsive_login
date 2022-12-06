import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:responsive_login/constants/app_colors.dart';
import 'package:responsive_login/constants/routes.dart';

import 'controller.dart';
import '../widget/design.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController firstnameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController password2Controller = TextEditingController();
  bool agree = false;

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    firstnameController.dispose();
    surnameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    passwordController.dispose();
    password2Controller.dispose();
    super.dispose();
  }

  Controller registrationController = Get.put(Controller());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var theme = Theme.of(context);

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
          backgroundColor: Colors.white,
          resizeToAvoidBottomInset: false,
          body: LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 600) {
                return _buildLargeScreen(size, registrationController, theme);
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
                      decoration: BoxDecoration(
                          color: AppColors.white.withOpacity(0.8)),
                      height: constraints.maxHeight,
                      width: constraints.maxWidth,
                    ),
                    _buildSmallScreen(size, registrationController, theme),
                  ],
                );
              }
            },
          )),
    );
  }

  /// For large screens
  Widget _buildLargeScreen(
      Size size, Controller registrationController, ThemeData theme) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          flex: 4,
          child: SizedBox(
            width: context.width * 0.04,
            height: context.height * 0.6,
            child: Lottie.asset('assets/lotties/login_code.json',
                fit: BoxFit.contain),
          ),
        ),
        SizedBox(width: size.width * 0.05),
        Expanded(
          flex: 5,
          child: _buildMainBody(size, registrationController, theme),
        ),
      ],
    );
  }

  /// For Small screens
  Widget _buildSmallScreen(
      Size size, Controller registrationController, ThemeData theme) {
    return Center(
      child: _buildMainBody(size, registrationController, theme),
    );
  }

  /// Main Body
  Widget _buildMainBody(
      Size size, Controller registrationController, ThemeData theme) {
    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: size.height),
        child: Padding(
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
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text(
                  'Inscription',
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
                padding: const EdgeInsets.only(left: 20.0, right: 20),
                child: Form(
                  key: _formKey,
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 420),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        /// firstname
                        TextFormField(
                          textCapitalization: TextCapitalization.none,
                          autofocus: true,
                          keyboardType: TextInputType.name,
                          autocorrect: false,
                          textInputAction: TextInputAction.next,
                          style: kTextFormFieldStyle(),
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.person),
                            hintText: "Prenom",
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                            ),
                          ),
                          controller: firstnameController,
                          validator: MultiValidator([
                            RequiredValidator(errorText: 'Entrez votre Prenom'),
                            MinLengthValidator(2, errorText: 'Prenom invalide'),
                          ]),
                        ),
                        SizedBox(
                          height: size.height * 0.02,
                        ),

                        /// lastname
                        TextFormField(
                          textCapitalization: TextCapitalization.none,
                          keyboardType: TextInputType.name,
                          autocorrect: false,
                          textInputAction: TextInputAction.next,
                          style: kTextFormFieldStyle(),
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.person),
                            hintText: "Nom de famille",
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                            ),
                          ),
                          controller: surnameController,
                          validator: MultiValidator([
                            RequiredValidator(
                                errorText: 'Entrez votre Nom de famille'),
                            MinLengthValidator(2,
                                errorText: 'Nom de famille incorrecte'),
                            MaxLengthValidator(15,
                                errorText: 'Nom de famille invalide'),
                          ]),
                        ),
                        SizedBox(
                          height: size.height * 0.02,
                        ),

                        /// phone
                        TextFormField(
                          textCapitalization: TextCapitalization.none,
                          keyboardType: TextInputType.phone,
                          autocorrect: false,
                          textInputAction: TextInputAction.next,
                          style: kTextFormFieldStyle(),
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.phone),
                            hintText: "Numero de Telephone",
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                            ),
                          ),
                          controller: phoneController,
                          validator: MultiValidator([
                            RequiredValidator(
                                errorText: 'Entrez votre Numero de Telephone'),
                            PatternValidator(
                                r'^[\+]?[0-9]{3}?[0-9]{3}?[0-9]{3,9}$',
                                errorText: 'Numero de Telephone invalide'),
                          ]),
                        ),
                        SizedBox(
                          height: size.height * 0.02,
                        ),

                        /// email
                        TextFormField(
                          textCapitalization: TextCapitalization.none,
                          keyboardType: TextInputType.emailAddress,
                          autocorrect: false,
                          textInputAction: TextInputAction.next,
                          style: kTextFormFieldStyle(),
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.mail),
                            hintText: "Addresse email",
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                            ),
                          ),
                          controller: emailController,
                          validator: MultiValidator([
                            RequiredValidator(
                                errorText: 'Entrez votre Addresse email'),
                            EmailValidator(errorText: "Addresse email invalide")
                          ]),
                        ),
                        SizedBox(
                          height: size.height * 0.02,
                        ),

                        /// password
                        Obx(
                          () => TextFormField(
                            textCapitalization: TextCapitalization.none,
                            keyboardType: TextInputType.visiblePassword,
                            autocorrect: false,
                            textInputAction: TextInputAction.next,
                            style: kTextFormFieldStyle(),
                            controller: passwordController,
                            obscureText: registrationController.isObscure.value,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.lock_open),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  registrationController.isObscure.value
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                                onPressed: () {
                                  registrationController.isObscureActive();
                                },
                              ),
                              hintText: 'Mot de passe',
                              border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                              ),
                            ),
                            // The validator receives the text that the user has entered.
                            validator: MultiValidator([
                              RequiredValidator(
                                  errorText: 'Entrez votre mot de passe'),
                              MinLengthValidator(6,
                                  errorText: 'Minimum 6 caracteres'),
                              PatternValidator(
                                  r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$ %^&*-]).{8,}$',
                                  errorText:
                                      'Doit contenir des lettres, chiffres, et caracteres speciaux')
                            ]),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.02,
                        ),

                        /// password
                        Obx(
                          () => TextFormField(
                            textCapitalization: TextCapitalization.none,
                            keyboardType: TextInputType.visiblePassword,
                            autocorrect: false,
                            textInputAction: TextInputAction.next,
                            style: kTextFormFieldStyle(),
                            controller: password2Controller,
                            obscureText: registrationController.isObscure.value,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.lock_open),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  registrationController.isObscure.value
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                                onPressed: () {
                                  registrationController.isObscureActive();
                                },
                              ),
                              hintText: 'Confirmer le mot de passe',
                              border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                              ),
                            ),
                            // The validator receives the text that the user has entered.
                            validator: MultiValidator([
                              RequiredValidator(
                                  errorText: 'Repetez le mot de passe'),
                              MinLengthValidator(6,
                                  errorText: 'Minimum 6 caracteres'),
                              PatternValidator(
                                  r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$ %^&*-]).{8,}$',
                                  errorText:
                                      'Doit contenir des lettres, chiffres, et caracteres speciaux'),
                              PatternValidator(passwordController.text,
                                  errorText:
                                      'Les 2 mot de passe doivent etre identique.')
                            ]),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        Row(
                          children: [
                            Material(
                              child: Obx(
                                () => Checkbox(
                                  activeColor: AppColors.indigoAccent,
                                  value: registrationController
                                      .agreeCondition.value,
                                  onChanged: (value) {
                                    registrationController.isAgreeCondition();
                                  },
                                ),
                              ),
                            ),
                            Flexible(
                              child: InkWell(
                                onTap: (() {
                                  registrationController.isAgreeCondition();
                                }),
                                child: Text(
                                  "J'ai lu et j'accepte les Conditions d'Utilisation, Confidentialitées et Je consens à recevoir des mise a jour.",
                                  style: kLoginTermsAndPrivacyStyle(size),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: size.height * 0.02,
                        ),

                        /// SignUp Button
                        signUpButton(theme),
                        SizedBox(
                          height: size.height * 0.03,
                        ),

                        /// Navigate To Login Screen
                        GestureDetector(
                          onTap: () {
                            firstnameController.clear();
                            surnameController.clear();
                            phoneController.clear();
                            emailController.clear();
                            passwordController.clear();
                            password2Controller.clear();
                            _formKey.currentState?.reset();
                            registrationController.isObscure.value = true;
                            registrationController.agreeCondition.value = false;

                            Get.offAndToNamed(Routes.login);
                          },
                          child: RichText(
                            text: TextSpan(
                              text: 'Vous avez déjà un compte ?',
                              style: kHaveAnAccountStyle(size),
                              children: [
                                TextSpan(
                                    text: " Connectez-vous",
                                    style: kLoginOrSignUpTextStyle(size)),
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
        ),
      ),
    );
  }

  // SignUp Button
  Widget signUpButton(ThemeData theme) {
    return Obx(() => SizedBox(
          width: double.infinity,
          height: 55,
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                  registrationController.agreeCondition.value == true
                      ? AppColors.indigoAccent
                      : AppColors.grey400),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            onPressed: () {
              // Validate returns true if the form is valid, or false otherwise.
              if (_formKey.currentState!.validate()) {
                if (registrationController.agreeCondition.isTrue) {
                  /// do sign up
                }
              }
            },
            child: const Text("S'inscrire"),
          ),
        ));
  }
}
