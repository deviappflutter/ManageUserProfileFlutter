
import 'package:flutter/material.dart';
import 'package:food_delivery_app/data/api/api_models/user_details_model.dart';
import 'package:food_delivery_app/data/api/api_models/user_update_model.dart';
import 'package:food_delivery_app/data/api/api_requests/register_request.dart';
import 'package:food_delivery_app/data/api/api_response.dart';
import 'package:food_delivery_app/data/app/app_repository.dart';
import 'package:food_delivery_app/data/app/service_locator.dart';
import 'package:food_delivery_app/utils/abs_error_indicator.dart';
import 'package:food_delivery_app/utils/app_preferences.dart';
import 'package:food_delivery_app/utils/toasts.dart';
import 'package:get/get.dart';

import '../../data/api/api_models/login_model.dart';
import '../../utils/app_string.dart';

class ProfileController extends GetxController {

  var _loading = false;
  ApiResponse<UserDetailsModel>? userDetails;
  ApiResponse<UserUpdateModel>? userUpdate;
  var imgPath=''.obs;
  var previousImagePath=''.obs;
  bool editable=false;
  bool readOnly=true;
  get loading => _loading;


  void isLoading(bool value) {
    _loading = value;
    update();
  }

  void onEdit(bool value){
    editable=value;
    update();
  }

  void onRead(bool value){
    readOnly=value;
    // update();
  }

  @override
  void onInit() {
    super.onInit();
    getUserData();
  }

  Future<ApiResponse<UserDetailsModel>?> getUserData() async {
    isLoading(true);
    final token = AppPreference.getToken();
    final request = RegisterRequest(token: token);
    var response = await locator<AppRepository>().getUserDetails(request);
    if (response.isSuccess()) {
      userDetails = ApiResponse.success(response.data());
    } else {
      userDetails = ApiResponse.error(response.error());
    }
    isLoading(false);
    update();
    return null;
  }

  Future<ApiResponse<LoginModel>> logout() async {
    String? token = AppPreference.getString(AppString.token);
    var request = RegisterRequest(token: token);
    var response = await locator<AppRepository>().logout(request);
    if (response.isSuccess()) {
      return ApiResponse.success(response.data());
    } else {
      return ApiResponse.error(response.error());
    }
  }

  Future<ApiResponse<UserUpdateModel>?> updateUser(BuildContext context,
      String firstName, lastName, email, address, phone,dob,imgPath) async {
    isLoading(true);
    // final token = AppPreference.getToken();
    final request = RegisterRequest(
        firstname: firstName,
        lastname: lastName,
        email: email,
        address: address,
        phone: phone,
        dob: dob,
        imgPath: imgPath
    );
    var response = await locator<AppRepository>().updateUser(request);
    if (response.isSuccess()) {
      //if user is updated successfully hit get user Details Api again to update user
      getUserData();
      userUpdate = ApiResponse.success(response.data());
      AbsIndicators.showSuccessIndicator(context,'Update Successfully');
    } else {
      userUpdate = ApiResponse.error(response.error());
      AbsIndicators.showErrorIndicator(context,userUpdate!.error());
    }
    isLoading(false);
    // onEdit(false);
    // update();
    return null;
  }
}
