

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
  }

  @override
  void onInit() {
    super.onInit();
    getUserData();
  }

  /////////////////////Fetch User Details API//////////////////////

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

  /////////////////////Logout User API//////////////////////

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

    /////////////////////Update User Details API//////////////////////

  Future<ApiResponse<UserUpdateModel>?> updateUser(BuildContext context,
      String firstName, lastName, email, address, phone,dob,imgPath) async {
    isLoading(true);
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
      getUserData();
      userUpdate = ApiResponse.success(response.data());
      AbsIndicators.showSuccessIndicator(context,'Update Successfully');
    } else {
      userUpdate = ApiResponse.error(response.error());
      AbsIndicators.showErrorIndicator(context,userUpdate!.error());
    }
    isLoading(false);
    return null;
  }
}
