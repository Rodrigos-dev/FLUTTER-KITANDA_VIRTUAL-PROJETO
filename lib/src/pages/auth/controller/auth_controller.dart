import 'package:get/get.dart';
import 'package:greengrocer/src/constants/storage_keys.dart';
import 'package:greengrocer/src/models/user_model.dart';
import 'package:greengrocer/src/pages/auth/repository/auth_repository.dart';
import 'package:greengrocer/src/pages/auth/result/auth_result.dart';
import 'package:greengrocer/src/pages/pages_routes/app_pages.dart';
import 'package:greengrocer/src/services/utils_services.dart';

class AuthController extends GetxController{//classe que erda a GetxController do pack getx

  RxBool isLoading = false.obs;//RxBool tipo bolleando do pak get que eh observable

  final authRepository = AuthRepository();

  final utilsServices = UtilsServices();

  UserModel user = UserModel();

  // @override
  // void onInit(){
  //   super.onInit();

  //   validateToken();
  // }

  Future<void> validateToken() async {
    // recuperar o token foi salvo localmente
    String? token = await utilsServices.getLocalData(key: StorageKeys.token);
    
    if(token == null){
      Get.offAllNamed(PagesRoutes.signinRoute);
      return;
    }

    AuthResult result = await authRepository.validateToken(token);
    //print('$result , 7777');
    result.when(
      success: (user) {
        this.user = user; 

        saveTokenAndProceedToBase();       
      }, 
      error: (message) {
        signOut();
      },
    );
  }

  Future<void> signOut()async {
    //zerar o user
    user = UserModel();

    //remover o token localmente
    await utilsServices.removeLocalData(key: StorageKeys.token);
  
    //Ir para tela de login
    Get.offAllNamed(PagesRoutes.signinRoute);
  
  }

  saveTokenAndProceedToBase(){
    print(user.token);
    print('wwwww');
   //Salvar o token
   utilsServices.saveLocalData(key: 'token', data: user.token!);   
  //Ir para tela base
  
  Get.offAllNamed(PagesRoutes.baseRoute);  
  }


  Future<void> signIn({required String email, required String password}) async {

    isLoading.value = true;

    AuthResult result = await authRepository.signIn(
      email: email, 
      password: password
    );

    isLoading.value = false;

    result.when(
      success: (user) { 
        print(user);

        this.user = user;

        saveTokenAndProceedToBase();

        //Get.offAllNamed(PagesRoutes.baseRoute);
      }, 
      error: (message) { 

        utilsServices.showToast(
          message: message,
          isError: true,
        );
        print(message);
      }
    );
  }


  Future<void> signUp() async {

    isLoading.value = true;

    AuthResult result = await authRepository.signUp(user);
  
    isLoading.value = false;

    result.when(
      success: (user){
        this.user = user;

        saveTokenAndProceedToBase();
      }, 
      error: (message) {
        utilsServices.showToast(
          message: message,
          isError: true,
        );
      },
    );
  }


  Future<void> resetPassword(String email) async {
    await authRepository.resetPassword(email);
  }

}