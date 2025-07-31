import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greengrocer/src/config/custom_colors.dart';
import 'package:greengrocer/src/pages/auth/controller/auth_controller.dart';
import 'package:greengrocer/src/pages/auth/view/components/forgot_password.dart';
import 'package:greengrocer/src/pages/auth/view/sign_up_screen.dart';
import 'package:greengrocer/src/pages/components_geral_apk/app_name_widget.dart';
import 'package:greengrocer/src/pages/pages_routes/app_pages.dart';
import 'package:greengrocer/src/services/utils_services.dart';
import 'package:greengrocer/src/services/validators.dart';

import '../../base/base_screen.dart';
import '../../components_geral_apk/custom_text_field.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({Key? key}) : super(key: key);

  final _formkey = GlobalKey<FormState>();

  final emailControler = TextEditingController();
  final passwordController = TextEditingController();

  final utilsServices = UtilsServices();

  //controlador de campos input

  @override
  Widget build(BuildContext context) {
    final sizeTela = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: CustomColors.customSwatchColor,
      body: SizedBox(
        height: sizeTela.height,
        width: sizeTela.width,
        child: Column(children: [
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //Titulo do App
              const AppNameWidget(
                greenTitleColor: Colors.white,
                textSize: 40,
              ),

              //categorias
              SizedBox(
                height: 30,
                child: DefaultTextStyle(
                  style: const TextStyle(
                    fontSize: 25,
                  ),
                  child: AnimatedTextKit(
                      pause: Duration.zero,
                      repeatForever: true,
                      animatedTexts: [
                        FadeAnimatedText('Frutas'),
                        FadeAnimatedText('Verduras'),
                        FadeAnimatedText('Legumes'),
                        FadeAnimatedText('Carnes'),
                        FadeAnimatedText('Cereais'),
                        FadeAnimatedText('Laticinios'),
                      ]),
                ),
              )
            ],
          )),

          //Conainer debaixo - formulario
          Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 32,
                vertical: 40,
              ),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(45))),
              child: Form(
                key: _formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    //email
                    CustomTextField(
                      controller: emailControler,
                      icon: Icons.email,
                      label: 'Email',

                      validator: emailValidator,                      
                    ),

                    //senha
                    CustomTextField(
                        controller: passwordController,
                        icon: Icons.lock,
                        label: 'Senha',
                        isSecret: true,
                        validator: passwordValidator                        
                        ),

                    //Botao de entrar
                    SizedBox(
                      height: 50,
                      child: GetX<AuthController>(builder: (authController) {
                        return ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18)),
                            ),
                            onPressed: authController.isLoading.value
                                ? null
                                : () {
                                    FocusScope.of(context).unfocus();

                                    String email = emailControler.text;
                                    String password = passwordController.text;                                   

                                    authController.signIn(
                                        email: email, password: password);
                                    if (_formkey.currentState!.validate()) {
                                      String email = emailControler.text;
                                      String password = passwordController.text;
                                    } else {
                                      print('Campos não válidos');
                                    }

                                    //Get.offNamed(PagesRoutes.baseRoute);
                                  },
                            child: authController.isLoading.value
                                ? CircularProgressIndicator()
                                : const Text(
                                    'Entrar',
                                    style: TextStyle(fontSize: 18),
                                  ));
                      }),
                    ),

                    //espaco
                    const SizedBox(
                      height: 10,
                    ),

                    //botao esqueceu a senha
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                          onPressed: () async {
                            final bool? result = await showDialog(
                              context: context, 
                              builder: (_) {
                                return ForgotPasswordDialog(email: emailControler.text);
                              }
                            );

                            if(result ?? false) {
                              utilsServices.showToast(
                                message: 'Um link e recuperação foi enviado para seu email'
                              );
                            }
                          },
                          child: Text(
                            'Esqueceu a Senha?',
                            style: TextStyle(
                              color: CustomColors.customContrastColor,
                            ),
                          )),
                    ),

                    //divisor - linha do ou
                    Row(
                      children: [
                        Expanded(
                          child: Divider(
                            color: Colors.grey.withAlpha(99),
                            thickness: 2,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: Text('Ou'),
                        ),
                        Expanded(
                          child: Divider(
                            color: Colors.grey.withAlpha(99),
                            thickness: 2,
                          ),
                        ),
                      ],
                    ),

                    //espaco
                    SizedBox(
                      height: 15,
                    ),

                    //crfiar conta
                    SizedBox(
                      height: 50,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18)),
                            side: BorderSide(
                                width: 2,
                                color: CustomColors.customSwatchColor)),
                        onPressed: () {
                          Get.toNamed(PagesRoutes.signupRoute);
                        },
                        child: const Text(
                          'Criar conta',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ))
        ]),
      ),
    );
  }
}
