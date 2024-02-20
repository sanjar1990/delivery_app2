import 'package:foo_delivery/data/repository/auth_repo.dart';
import 'package:foo_delivery/models/response_model.dart';
import 'package:foo_delivery/models/signup_body_model.dart';
import 'package:get/get.dart';

class AuthController extends GetxController implements GetxService{
  final AuthRepo authRepo;

  AuthController({required this.authRepo});
  bool _isLoading =false;

  bool get islLoading=>_isLoading;
  Future<ResponseModel> registration(SignUpBody signUpBody)async{
    _isLoading=true;
    update();
    late ResponseModel responseModel;
    Response response= await authRepo.registration(signUpBody);
    if(response.statusCode==200){
      authRepo.saveUserToken(response.body['message']);
      responseModel=ResponseModel(true, response.body['message']);

    }else{
        responseModel=ResponseModel(false, response.statusText!);
    }
    _isLoading=false;
    update();
    return responseModel;
  }
  Future<ResponseModel> login(String email, String password)async{
    _isLoading=true;
    update();
    late ResponseModel responseModel;
    Response response= await authRepo.login(email,password);
    if(response.statusCode==200){
      print(response.body);
      authRepo.saveUserToken(response.body['message']);
      responseModel=ResponseModel(true, response.body['message']);

    }else{
      responseModel=ResponseModel(false, response.statusText!);
    }
    _isLoading=false;
    update();
    return responseModel;
  }
  void saveUserNumberAndPassword(String phone, String password){
    authRepo.saveUserNumberAndPassword(phone, password);
  }
  bool userLoggedIn(){
    return authRepo.userLoggedIn();
  }
  bool clearSharedData(){
    return authRepo.clearSharedData();
  }

}