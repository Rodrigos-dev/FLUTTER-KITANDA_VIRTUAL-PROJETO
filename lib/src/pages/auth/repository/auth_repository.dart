import 'package:greengrocer/src/constants/endpoints.dart';
import 'package:greengrocer/src/models/user_model.dart';
import 'package:greengrocer/src/pages/auth/repository/auth_errors.dart' as authErrors;
import 'package:greengrocer/src/pages/auth/result/auth_result.dart';
import 'package:greengrocer/src/services/http_manager.dart';

class AuthRepository {

  final HttpManager _httpManager = HttpManager();

  AuthResult handleUserOrError(Map<dynamic, dynamic> result){
    if(result['result'] != null) {
      print ('Signin funcionou');   

      final user = UserModel.fromJson(result['result']);
      print('${result['result']}, h');

      return AuthResult.success(user);

      
    }else{
      print ('Signin não funcionou');
      print (result['error']);      

      return AuthResult.error(authErrors.authErrorsString(result['error']));
    }
  }


  Future<AuthResult> validateToken(String token) async {
    final result = await _httpManager.restRequest(
      url: Endpoints.validateToken, 
      method: HttpMethods.post,
      headers: {
        'X-Parse-Session-Token': token,
      }
    );

    return handleUserOrError(result);
  }


  Future<AuthResult> signIn({
    required String email, required String password
  }) async {

    final result = await _httpManager.restRequest(
      url: Endpoints.signin, 
      method: HttpMethods.post,
      body: {
        "email": email,
        "password": password,
      }
    );

    return handleUserOrError(result);    
  }


  Future<AuthResult> signUp(UserModel user) async {

    final result = await _httpManager.restRequest(
      url: Endpoints.signup, 
      method: HttpMethods.post,
      body: user.toJson()
    );

    return handleUserOrError(result);    
  }


  
  Future<void> resetPassword(String email) async {

    await _httpManager.restRequest(
      url: Endpoints.resetPassword, 
      method: HttpMethods.post,
      body: {'email': email},
    );      
  }
}