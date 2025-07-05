import 'package:deu_cis/feature/home/subview/draweritems/userprofile/profile_view.dart';
import 'package:deu_cis/locator.dart';
import 'package:deu_cis/product/common/widget/cached_image.dart';
import 'package:deu_cis/product/constants/index.dart';
import 'package:deu_cis/product/vm/auth_view_model.dart';
import 'package:flutter/material.dart';

class DrawerHeaderWidget extends StatelessWidget {
  const DrawerHeaderWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          AppColors.gradientFirst,
          AppColors.gradientSecond,
          AppColors.gradientThird
        ]),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Foreground semi-transparent overlay
          Container(
            decoration: BoxDecoration(
              color: AppColors.black.withOpacity(0.3),
            ),
          ),
          // Text stays above the overlay
          Row(
            children: [
              SizedBox(
                width: 30,
              ),
              CachedImage(
                isProfile: true,
                imageUrl: locator<AuthViewModel>().user!.getImageURL(),
              ),
              SizedBox(
                width: 15,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    locator<AuthViewModel>().user!.firstName +
                        ' ' +
                        locator<AuthViewModel>().user!.lastName,
                    style: AppTextStyles.titleTextWhite,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) {
                          return MyProfileView();
                        },
                      ));
                    },
                    child: Row(
                      spacing: 5,
                      children: [
                        Icon(
                          size: 14,
                          Icons.edit,
                          color: AppColors.greyLight,
                        ),
                        Text(
                          StringConsts.editProfile,
                          style: AppTextStyles.textFieldTextLightGrey,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
