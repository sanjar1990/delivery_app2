import 'package:foo_delivery/data/api/api_client.dart';
import 'package:foo_delivery/models/signup_body_model.dart';
import 'package:foo_delivery/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  AuthRepo({required this.apiClient, required this.sharedPreferences});
 Future<Response> registration(SignUpBody signUpBody)async{
     return await apiClient.postData(AppConstants.REGISTRATION_URI, signUpBody.toJson());
  }

  Future<Response> login(String email, String password)async{
    return await apiClient.postData(AppConstants.LOGIN_URI,
        {'email':email, 'password':password});
  }
  saveUserToken(String token) async {
   apiClient.token=token;
   apiClient.updateHeader(token);
 return await sharedPreferences.setString(AppConstants.TOKEN, token);
 }
  Future<void> saveUserNumberAndPassword(String phone, String password) async{
   try{
    await sharedPreferences.setString(AppConstants.PHONE, phone);
    await sharedPreferences.setString(AppConstants.PASSWORD, password);
   }catch(e){
     throw e;
   }
  }
  bool userLoggedIn(){
   return sharedPreferences.containsKey(AppConstants.TOKEN);
  }
 Future <String> getUserToken()async{
   return await sharedPreferences.getString(AppConstants.TOKEN)??"none";
  }

  bool clearSharedData(){
  sharedPreferences.remove(AppConstants.TOKEN);
  sharedPreferences.remove(AppConstants.PASSWORD);
  sharedPreferences.remove(AppConstants.PHONE);
  apiClient.token='';
  apiClient.updateHeader('');
  return true;
  }

}