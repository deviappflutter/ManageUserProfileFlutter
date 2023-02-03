

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  List<ProfilePackage> profilePackage = [
    ProfilePackage(
        title: 'Order',
        id: '1',
        imageUrl: IconsSvg.pOrder,
        color: AbsColors.pYellow),
    ProfilePackage(
        title: 'Favourite',
        id: '2',
        imageUrl: IconsSvg.pHeart,
        color: AbsColors.pBlue),
    ProfilePackage(
        title: 'Address',
        id: '3',
        imageUrl: IconsSvg.pAddress,
        color: AbsColors.pBlue),
    ProfilePackage(
        title: 'Help',
        id: '4',
        imageUrl: IconsSvg.pHelp,
        color: AbsColors.pGreen),
    ProfilePackage(
        title: 'About Us',
        id: '5',
        imageUrl: IconsSvg.pPerson,
        color: AbsColors.pGreen),
  ];
  List<ProfilePackage> thirdPackage = [
    ProfilePackage(
        title: 'About Us',
        id: '1',
        imageUrl: IconsSvg.pHelp,
        color: AbsColors.pRed),
    ProfilePackage(
        title: 'Join Us',
        id: '2',
        imageUrl: IconsSvg.pPerson,
        color: AbsColors.pRed),
    ProfilePackage(
        title: 'Language',
        id: '1',
        imageUrl: IconsSvg.pLanguage,
        color: AbsColors.pYellow),
  ];
  List<ProfilePackage> secondPackage = [
    ProfilePackage(
        title: 'Rate Us',
        id: '1',
        imageUrl: IconsSvg.pRateUs,
        color: AbsColors.pRed),
    ProfilePackage(
        title: 'Rewards',
        id: '2',
        imageUrl: IconsSvg.pRewards,
        color: AbsColors.pRed),
    ProfilePackage(
        title: 'Send Feedback',
        id: '3',
        imageUrl: IconsSvg.pFeedback,
        color: AbsColors.pPurpel),
    ProfilePackage(
        title: 'Saved Cards',
        id: '4',
        imageUrl: IconsSvg.pSavedCards,
        color: AbsColors.pPurpel),
  ];
  final controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<ProfileController>(builder: (_) {
        String? imageurl = controller.userDetails
            ?.data()
            .data
            ?.attachment
            ?.attach
            ?.original
            ?.url ?? '';
        return SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(left: 20.w, right: 20.w),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AddSpace.vertical(50.h),
                      Padding(
                        padding: EdgeInsets.only(left: 3.w),
                        child: Text(
                          'GOOD FOOD GOOD HEALTH',
                          style: AbsTextStyle.base.copyWith(
                              color: AbsColors.smallTextColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 11.sp),
                        ),
                      ),
                      AddSpace.vertical(10.h),
                      Text(
                        AppString.myProfile,
                        style: AbsTextStyle.boldLargeTitle,
                      ),
                      AddSpace.vertical(10.h),
                      !controller.loading
                          ? GestureDetector(
                        onTap: () {
                          UserDetailsModel? userData =
                          controller.userDetails?.data();
                          controller.onEdit(false);
                          Get.toNamed('/EditProfilePage',
                              arguments: userData);
                        },
                        child: Container(
                          height: 67.h,
                          padding: EdgeInsets.only(
                              top: 7,
                              left: 20.w,
                              right: 20.w,
                              bottom: 7.h),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: AbsColors.smallTextColor
                                    .withOpacity(0.2),
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
                                height: 100.h,
                                child: ClipRRect(
                                    borderRadius:
                                    BorderRadius.circular(50.r),
                                    child: imageurl.isNotEmpty ? Image.network(
                                      imageurl, width: 50.r,
                                      loadingBuilder: ((context, child,
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
                                      ),) : Image.asset(
                                      ImagePng.userProfile,
                                    )),
                              ),
                              AddSpace.horizontal(10.w),
                              Column(
                                mainAxisAlignment:
                                MainAxisAlignment.center,
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${controller.userDetails
                                        ?.data()
                                        .data!
                                        .firstname} ${controller.userDetails
                                        ?.data()
                                        .data
                                        ?.lastname}',
                                    textAlign: TextAlign.left,
                                    style: AbsTextStyle.base
                                        .copyWith(fontSize: 21.sp),
                                  ),
                                  SizedBox(
                                    height: 6.h,
                                  ),
                                  Text(
                                    '${controller.userDetails
                                        ?.data()
                                        .data
                                        ?.email}',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color:
                                        AbsColors.mediumBoldTextColor,
                                        fontSize: 14.sp),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              Transform.rotate(
                                  angle: -89.5,
                                  child: SvgPicture.asset(
                                    IconsSvg.dropDown,
                                    height: 8.3.h,
                                    color: AbsColors.smallTextColor,
                                  ))
                            ],
                          ),
                        ),
                      )
                          : SizedBox(
                        height: 67.h,
                        child: const Center(
                            child: CircularProgressIndicator(
                                color: AbsColors.selectColor)),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          top: 12.h,
                        ),
                        padding:
                        EdgeInsets.only(left: 16.w, top: 15.h, bottom: 9.h),
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
                          separatorBuilder: (context, index) =>
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      AddSpace.horizontal(50.w),
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
                          itemCount: profilePackage.length,
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              onTap: () {
                                profilePackage[index].id == '1'
                                    ? Get.toNamed("/myOrder")
                                    : Container();
                                profilePackage[index].id == '3'
                                    ? Get.toNamed("/address")
                                    : Container();
                              },
                              child: Column(
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        height: 30.r,
                                        width: 30.r,
                                        padding: EdgeInsets.all(6.5.h),
                                        decoration: BoxDecoration(
                                            color: profilePackage[index].color,
                                            borderRadius:
                                            BorderRadius.circular(7.r)),
                                        child: SvgPicture.asset(
                                          profilePackage[index].imageUrl,
                                        ),
                                      ),
                                      AddSpace.horizontal(17.w),
                                      Text(
                                        profilePackage[index].title,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16.sp,
                                            color: AbsColors.profileTextColor),
                                      ),
                                      const Spacer(),
                                      Padding(
                                        padding: EdgeInsets.only(right: 14.w),
                                        child: Transform.rotate(
                                            angle: -89.5,
                                            child: SvgPicture.asset(
                                              IconsSvg.dropDown,
                                              height: 8.3.h,
                                              color: AbsColors.smallTextColor,
                                            )),
                                      )
                                    ],
                                  ),
                                  AddSpace.vertical(6.h),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      middelProfileWidget(),
                      lastWidget(),
                      AddSpace.vertical(14.h),
                      AbsButton(
                        height: 44.h,
                        radius: 7.r,
                        color: AbsColors.whiteColor,
                        textStyle: AbsTextStyle.base.copyWith(
                            fontSize: 15.sp, color: AbsColors.selectColor),
                        onPressed: () {
                          controller.logout().then((response) {
                            controller.isLoading(true);
                            if (response.isSuccess()) {
                              controller.isLoading(false);
                              AppPreference.clear();
                              Get.offAll(const LoginScreen());
                            } else {
                              controller.isLoading(false);
                              AbsIndicators.showErrorIndicator(
                                  context, response.error());
                            }
                          });
                        },
                        title: 'Sign Out',
                      ),
                      AddSpace.vertical(28.h),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      }),
    );
  }

  middelProfileWidget() {
    return Container(
      margin: EdgeInsets.only(
        top: 12.h,
      ),
      padding: EdgeInsets.only(left: 16.w, top: 15.h, bottom: 9.h),
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
        separatorBuilder: (context, index) =>
            Column(
              children: [
                Row(
                  children: [
                    AddSpace.horizontal(50.w),
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
        itemCount: secondPackage.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              profilePackage[index].id == '1'
                  ? Get.toNamed("/sendFeedBack")
                  : Container();
              profilePackage[index].id == '2'
                  ? Get.toNamed("/sendFeedBack")
                  : Container();
              profilePackage[index].id == '3'
                  ? Get.toNamed("/sendFeedBack")
                  : Container();
              profilePackage[index].id == '4'
                  ? Get.toNamed("/saveCard")
                  : Container();
            },
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: 30.r,
                      width: 30.r,
                      padding: EdgeInsets.all(6.5.h),
                      decoration: BoxDecoration(
                          color: secondPackage[index].color,
                          borderRadius: BorderRadius.circular(7.r)),
                      child: SvgPicture.asset(
                        secondPackage[index].imageUrl,
                      ),
                    ),
                    AddSpace.horizontal(17.w),
                    Text(
                      secondPackage[index].title,
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 16.sp,
                          color: AbsColors.profileTextColor),
                    ),
                    const Spacer(),
                    Padding(
                      padding: EdgeInsets.only(right: 14.w),
                      child: Transform.rotate(
                          angle: -89.5,
                          child: SvgPicture.asset(
                            IconsSvg.dropDown,
                            height: 8.3.h,
                            color: AbsColors.smallTextColor,
                          )),
                    )
                  ],
                ),
                AddSpace.vertical(6.h),
              ],
            ),
          );
        },
      ),
    );
  }

  lastWidget() {
    return Container(
      margin: EdgeInsets.only(top: 12.h),
      padding: EdgeInsets.only(left: 16.w, top: 15.h, bottom: 9.h),
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
        separatorBuilder: (context, index) =>
            Column(
              children: [
                Row(
                  children: [
                    AddSpace.horizontal(50.w),
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
        itemCount: thirdPackage.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              profilePackage[index].id == '1'
                  ? Get.toNamed("/sendFeedBack")
                  : Container();
              profilePackage[index].id == '2'
                  ? Get.toNamed("/sendFeedBack")
                  : Container();
              profilePackage[index].id == '3'
                  ? Get.toNamed("/sendFeedBack")
                  : Container();
            },
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: 30.r,
                      width: 30.r,
                      padding: EdgeInsets.all(6.5.h),
                      decoration: BoxDecoration(
                          color: thirdPackage[index].color,
                          borderRadius: BorderRadius.circular(7.r)),
                      child: SvgPicture.asset(
                        thirdPackage[index].imageUrl,
                      ),
                    ),
                    AddSpace.horizontal(17.w),
                    Text(
                      thirdPackage[index].title,
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 16.sp,
                          color: AbsColors.profileTextColor),
                    ),
                    const Spacer(),
                    Padding(
                      padding: EdgeInsets.only(right: 14.w),
                      child: Transform.rotate(
                          angle: -89.5,
                          child: SvgPicture.asset(
                            IconsSvg.dropDown,
                            height: 8.3.h,
                            color: AbsColors.smallTextColor,
                          )),
                    )
                  ],
                ),
                AddSpace.vertical(6.h),
              ],
            ),
          );
        },
      ),
    );
  }
}

class ProfilePackage {
  final String imageUrl;
  final String id;
  final String title;
  final Color color;

  ProfilePackage({required this.title,
    required this.id,
    required this.imageUrl,
    required this.color});
}
