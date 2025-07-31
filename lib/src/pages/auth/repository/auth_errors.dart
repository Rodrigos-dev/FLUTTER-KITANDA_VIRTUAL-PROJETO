
String authErrorsString(String? code){

  switch(code) {
    case 'INVALID_CREDENTIALS':
      return 'Email e/ou senha inválidos';

    case 'Invalid session token':
      return 'Token inválido';

    case 'Invalid FullName':
      return 'Nome inválido';

    case 'Invalid Phone':
      return 'Phone inválido';

    case 'Invalid Cpf':
      return 'Cpf inválido';
    
    default:
      return 'Um erro indefinido ocorreu';
  }
}