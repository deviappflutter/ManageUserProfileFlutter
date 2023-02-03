
class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {

  /////////////////////Init TextEditingController //////////////////////


  TextEditingController firstNameC = TextEditingController();
  TextEditingController lastNameC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController phoneC = TextEditingController();
  TextEditingController addressC = TextEditingController();
  TextEditingController descriptionC = TextEditingController();
  TextEditingController dobC = TextEditingController();
  TextEditingController fNameC = TextEditingController();
  TextEditingController? textConntroller;
  List<ProfileEditPackage> editProfileData = [
    ProfileEditPackage(name: 'First Name', title: 'Enter First Name', id: '0'),
    ProfileEditPackage(name: 'Last Name', title: 'Enter Last Name', id: '1'),
    ProfileEditPackage(name: 'Email ', title: 'Enter Email', id: '2'),
    ProfileEditPackage(name: 'Phone', title: 'Enter Phone', id: '3'),
    ProfileEditPackage(name: 'Location', title: 'Enter Location', id: '4'),
  ];
  List<ProfileEditPackage> editProfileData1 = [
    ProfileEditPackage(name: 'DOB', title: 'DD/MM/YY', id: '2'),
  ];
  
  final profileController = Get.find<ProfileController>();


  String initialValue = '';
  bool readOnly = false;
  TextInputType? inputType;
  late UserDetailsModel userDetailsModel;

  @override
  void initState() {
    userDetailsModel = Get.arguments;
    profileController.previousImagePath.value=userDetailsModel.data?.attachment?.attach?.original?.url ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 5.h, left: 20.w, right: 20.w),
                  child: SingleChildScrollView(
                    child: GetBuilder<ProfileController>(
                      builder: (controller) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              alignment: Alignment.bottomRight,
                              children: [
                                const AppBackWidget(
                                  backTitle: 'Profile',
                                  title: 'Edit Profile',
                                ),
                                GestureDetector(
                                  onTap: () {
                                    profileController.onEdit(profileController.editable =
                                    !profileController.editable);
                                  },
                                  child: Container(
                                    height: 23.h,
                                    width: 60.w,
                                    margin: EdgeInsets.only(bottom: 5.h),
                                    padding: EdgeInsets.symmetric(
                                        vertical: 5.h, horizontal: 13.w),
                                    decoration: BoxDecoration(
                                        color: AbsColors.appBackgroundColor,
                                        border: Border.all(
                                            width: 1.r,
                                            color: AbsColors.selectColor),
                                        borderRadius: BorderRadius.circular(8.r)),
                                    child: Center(
                                      child: Text(
                                        'Edit',
                                        style: AbsTextStyle.base.copyWith(
                                            fontSize: 12.sp,
                                            color: AbsColors.selectColor,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            AddSpace.vertical(9.h),
                            EditProfileWidget(),
                            editProfileDetail(),
                            AddSpace.vertical(12.h),
                            lastEditProfileWidget(),
                            SizedBox(height: 40.h),
                            profileController.editable?AbsButton(onPressed: (){
                              updateUser();
                              Navigator.pop(context);
                            },title: 'Update',height: 55.h,):Container()
                          ],
                        );
                      }
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }

  Container lastEditProfileWidget() {
    return Container(
      margin: EdgeInsets.only(
        top: 12.h,
      ),
      padding: EdgeInsets.only(left: 14.w, top: 15.h, bottom: 10.h),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: AbsColors.smallTextColor.withOpacity(0.2),
            spreadRadius: 0.2,
            blurRadius: 3,
          )
        ],
        color: AbsColors.whiteColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(12.0),
        ),
      ),
      alignment: Alignment.topLeft,
      child: GetBuilder<ProfileController>(
        builder: (controller) {
          return ListView.separated(
            separatorBuilder: (context, index) => Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 1,
                        height: 0.h,
                      ),
                    )
                  ],
                ),
                AddSpace.vertical(10.h),
              ],
            ),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            itemCount: editProfileData1.length,
            itemBuilder: (BuildContext context, int index) {
              switch (editProfileData1[index].id) {
                case '1':
                  inputType = TextInputType.text;
                  break;
                case '2':
                  inputType = TextInputType.datetime;
                  initialValue = userDetailsModel.data?.dob ?? '';
                  dobC.text = initialValue;
                  textConntroller = dobC;
                  break;
              }
              return GestureDetector(
                onTap: () {},
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          flex: 3,
                          child: SizedBox(
                            width: 90.w,
                            child: Text(
                              editProfileData1[index].name,
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16.sp,
                                  color: AbsColors.profileTextColor),
                            ),
                          ),
                        ),
                        Expanded(
                            flex: 7,
                            child: AbsTextFeild(
                                suffixIcon: profileController.editable?const Icon(Icons.edit,
                                    color: AbsColors.selectColor, size: 20):const Icon(Icons.edit,
                                    color: Colors.transparent),
                                controller: textConntroller,
                                keyboardType: inputType,
                                hintLebel: editProfileData1[index].title,
                                fillColor: Colors.white,
                                height: 30.h,
                                readOnly: profileController.readOnly,
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16.sp,
                                    color: AbsColors.profileTextColor),
                                focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide.none))
                           ),
                        AddSpace.horizontal(10.w),
                      ],
                    ),
                    AddSpace.vertical(6.h),
                  ],
                ),
              );
            },
          );
        }
      ),
    );
  }

  Widget editProfileDetail() {
    return GetBuilder<ProfileController>(builder: (controller) =>
        Container(
      margin: EdgeInsets.only(
        top: 12.h,
      ),
      padding: EdgeInsets.only(left: 14.w, top: 15.h, bottom: 10.h),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: AbsColors.smallTextColor.withOpacity(0.2),
            spreadRadius: 0.2,
            blurRadius: 3,
          )
        ],
        color: AbsColors.whiteColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(12.0),
        ),
      ),
      alignment: Alignment.topLeft,
      child: ListView.separated(
        separatorBuilder: (context, index) => Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Divider(
                    thickness: 1,
                    height: 0.h,
                  ),
                ),
              ],
            ),
            AddSpace.vertical(10.h),
          ],
        ),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        itemCount: editProfileData.length,
        itemBuilder: (BuildContext context, int index) {
          switch (editProfileData[index].id) {
            case '0':
              inputType = TextInputType.text;
              initialValue = userDetailsModel.data?.firstname ?? '';
              firstNameC.text = initialValue;
              textConntroller = firstNameC;
              readOnly = false;
              profileController.editable?profileController.onRead(false):profileController.onRead(true);
              break;
            case '1':
              inputType = TextInputType.text;
              initialValue = userDetailsModel.data?.lastname ?? '';
              lastNameC.text = initialValue;
              textConntroller = lastNameC;
              readOnly = false;
              profileController.editable?profileController.onRead(false):profileController.onRead(true);
              break;
            case '2':
              inputType = TextInputType.emailAddress;
              initialValue = userDetailsModel.data?.email ?? '';
              emailC.text = initialValue;
              textConntroller = emailC;
              readOnly = true;
              profileController.onRead(true);
              break;
            case '3':
              inputType = TextInputType.phone;
              initialValue = userDetailsModel.data?.phone ?? '';
              phoneC.text = initialValue;
              textConntroller = phoneC;
              readOnly = true;
              profileController.onRead(true);
              break;
            case '4':
              inputType = TextInputType.text;
              initialValue = userDetailsModel.data?.address ?? '';
              addressC.text = initialValue;
              textConntroller = addressC;
              readOnly = false;
              profileController.editable?profileController.onRead(false):profileController.onRead(true);
              break;
          }
          return GestureDetector(
            onTap: () {},
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      flex: 3,
                      child: SizedBox(
                        width: 90.w,
                        child: Text(
                          editProfileData[index].name,
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 16.sp,
                              color: AbsColors.profileTextColor),
                        ),
                      ),
                    ),
                    Expanded(
                        flex: 7,
                        child: AbsTextFeild(
                            controller: textConntroller,
                            suffixIcon: profileController.editable?
                            profileController.readOnly
                                ? const Icon(Icons.edit,
                                color: Colors.transparent)
                                : const Icon(Icons.edit,
                                color: AbsColors.selectColor, size: 20):const Icon(Icons.edit,
                                color: Colors.transparent),
                            keyboardType: inputType,
                            hintLebel: editProfileData[index].title,
                            fillColor: Colors.white,
                            height: 30.h,
                            readOnly: profileController.readOnly,
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 16.sp,
                                color: AbsColors.profileTextColor),
                            focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide.none))
                       ),
                    AddSpace.horizontal(10.w),
                  ],
                ),
                AddSpace.vertical(6.h),
              ],
            ),
          );
        },
      ),
    ));

  }

  void updateUser() {
    profileController.updateUser(context,
        firstNameC.text,
        lastNameC.text,
        emailC.text,
        addressC.text,
        phoneC.text,
        dobC.text,
        profileController.imgPath.value.toString());
    profileController.onEdit(false);
  }
}

class EditProfileWidget extends StatelessWidget {
  EditProfileWidget({
    Key? key,
  }) : super(key: key);

  final profileController = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      builder: (controller) {
        return Container(
          height: 67.h,
          padding: EdgeInsets.only(top: 7, left: 20.w, right: 20.w, bottom: 7.h),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: AbsColors.smallTextColor.withOpacity(0.2),
                spreadRadius: 0.2,
                blurRadius: 3,
              )
            ],
            color: AbsColors.whiteColor,
            borderRadius: const BorderRadius.all(
              Radius.circular(12.0),
            ),
          ),
          child: Row(
            children: [
              SizedBox(
                width: 50.r,
                height: 100.r,
                child: Obx(() =>  ClipRRect(
                    borderRadius: BorderRadius.circular(50.r),
                    child: profileController.previousImagePath.value.isEmpty?Obx(() =>
                    profileController.imgPath.value.isNotEmpty
                        ? Image.file(
                      File(profileController.imgPath.value ?? ''),
                    )
                        : Image.asset(ImagePng.userProfile)
                    ):Image.network(profileController.previousImagePath.value,loadingBuilder: ((context, child,
                        loadingProgress) {
                      if (loadingProgress == null) return child;
                      return SizedBox(
                          height: 40.r,
                          width: 40.r,
                          child: const Center(
                            child: CircularProgressIndicator(
                                color: AbsColors
                                    .selectColor),
                          ));
                    }
                    ))
                ),)
              ),
              AddSpace.horizontal(14.w),
              Text(
                'Profile Edit',
                textAlign: TextAlign.left,
                style: AbsTextStyle.base.copyWith(fontSize: 21.sp),
              ),
              const Spacer(),
               profileController.editable
                  ? GestureDetector(
                   onTap: (){
                     pickImage();
                   },
                   child: const Icon(Icons.edit, color: AbsColors.selectColor))
                  : const Icon(Icons.edit, color: Colors.transparent)
            ],
          ),
        );
      }
    );
  }

  Future<void> pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    profileController.imgPath.value = image?.path ?? '';
    profileController.previousImagePath.value='';
  }


}

class ProfileEditPackage {
  final String name;
  final String id;
  final String title;

  ProfileEditPackage({
    required this.name,
    required this.title,
    required this.id,
  });
}
