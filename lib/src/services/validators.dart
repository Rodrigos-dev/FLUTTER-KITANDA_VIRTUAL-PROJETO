import 'package:get/get.dart';

String? emailValidator(String? email) {
  if (email == null || email.isEmpty) {
    return 'Digite seu Email';
  }

  if (!email.isEmail) {
    return 'Digite um email válido';
  }

  return null;
}

String? passwordValidator(password) {
  if (password == null || password.isEmpty) {
    return 'Digite sua senha';
  }

  if (password.length < 7) {
    return 'Digite uma senha com pelo menos 7 caracteres.';
  }

  return null;
}

String? nameValidator(String? name) {
  if (name == null || name.isEmpty) {
    return 'Digite seu nome';
  }

  final names = name.split(' ');  //=> para exigir no minimo 2 nomes tipo o split(' ') quando ele encontrar um espaco ele add ele numa lista separados po virgula 

  if(names.length == 1) return 'Digite seu nome completo!'; //AKI VERIFICAMOS SE A LISTA TEM NO MINIMO 2 NOMES
  
  return null;
}


String? phoneValidator(String? phone) {
  if (phone == null || phone.isEmpty) {
    return 'Digite um celular';
  }

  if(phone.length < 14 || !phone.isPhoneNumber) return 'Digite um numero válido!'; //AKI VERIFICAMOS SE A LISTA TEM NO MINIMO 2 NOMES
  
  return null;
}


String? cpfValidator(String? cpf) {
  if (cpf == null || cpf.isEmpty) {
    return 'Digite um cpf';
  }

  if(!cpf.isCpf) return 'Digite um CPF válido!'; //AKI VERIFICAMOS SE A LISTA TEM NO MINIMO 2 NOMES
  
  return null;
}
