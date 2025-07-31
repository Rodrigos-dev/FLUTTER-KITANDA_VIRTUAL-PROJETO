import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greengrocer/src/config/custom_colors.dart';
import 'package:greengrocer/src/pages/auth/controller/auth_controller.dart';
import 'package:greengrocer/src/services/validators.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../components_geral_apk/custom_text_field.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);

  final cpfFormater = MaskTextInputFormatter(
    mask: '###.###.###-##',
    filter: { '#' : RegExp(r'[0-9]')},
  );

  final foneFormater = MaskTextInputFormatter(
    mask: '## # ####-####',
    filter: { '#' : RegExp(r'[0-9]')},
  );

  final _formKey = GlobalKey<FormState>();
  final authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    final sizeTela = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: CustomColors.customSwatchColor,
      body: SingleChildScrollView(
        child: SizedBox(
          height: sizeTela.height,
          width: sizeTela.width,
          child: Stack(
            children: [
              Column(
                children: [
                  //TITULO DA TELA
                  const Expanded(
                    child: Center(
                      child: Text(
                        'Cadastro',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 35,
                        ),
                      ),
                    ),
                  ),               
      
                  //CONTAINER FORMULARIO
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 40,
                    ),
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(45),
                        )),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                           CustomTextField(
                            icon: Icons.email,
                            label: 'Email',
                            textInputType: TextInputType.emailAddress,
                            validator: emailValidator,
      
                            onSaved: (value) {
                              authController.user.email = value;
                            },
                          ),
                           CustomTextField(
                            icon: Icons.lock,
                            label: 'Senha',
                            isSecret: true,
                            validator: passwordValidator,
      
                            onSaved: (value) {
                              authController.user.password = value;
                            },
                          ),
                           CustomTextField(
                            icon: Icons.person,
                            label: 'Nome',
                            validator: nameValidator,
      
                            onSaved: (value) {
                              authController.user.name = value;
                            },
                          ),
                          CustomTextField(
                            icon: Icons.phone,
                            label: 'Celular',
                            inputFormatters: [foneFormater],
                            textInputType: TextInputType.phone,
                            validator: phoneValidator,
      
                            onSaved: (value) {
                              authController.user.phone = value;
                            },
                          ),
                          CustomTextField(
                            icon: Icons.file_copy,
                            label: 'CPF',
                            inputFormatters: [cpfFormater],
                            textInputType: TextInputType.number,
                            validator: cpfValidator,
      
                            onSaved: (value) {
                              authController.user.cpf = value;
                            },
                          ),
                          SizedBox(
                            height: 50,
                            child: Obx(() {
                              return ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(18))),
                                onPressed: authController.isLoading.value 
                                ? null 
                                :() {

                                  FocusScope.of(context).unfocus();
      
                                  if(_formKey.currentState!.validate()){
                                    _formKey.currentState!.save();
      
                                    print(authController.user);

                                    authController.signUp();
      
                                  };
      
                                  print(authController.user);
                                },
                                child: authController.isLoading.value 
                                ? const CircularProgressIndicator() 
                                : const Text(
                                  'Cadastrar Usuário',
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ));
                            }),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),   
      
              //Seta para voltar para o login
              Positioned(
                  top: 10,
                  left: 10,
                  child: SafeArea(
                    child: IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                    ),
                  )),         
            ],
          ),
        ),
      ),
    );
  }
}
