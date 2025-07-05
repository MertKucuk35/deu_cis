import 'package:deu_cis/feature/home/home_view.dart';
import 'package:deu_cis/product/vm/auth_view_model.dart';
import 'package:deu_cis/feature/login/widget/text_field.dart';
import 'package:deu_cis/feature/login/widget/space_divide.dart';
import 'package:deu_cis/locator.dart';
import 'package:deu_cis/product/common/snackbar_result.dart';
import 'package:deu_cis/product/constants/index.dart';
import 'package:deu_cis/product/enums/image_constants.dart';

import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: PaddingConsts.pageHorizontal,
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 1,
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ResponsiveBreakpoints.of(context).isMobile
                      ? Image.asset(
                          ImageConstants.appLogo.toPng,
                          width: MediaQuery.of(context).size.width * 0.5,
                          height: MediaQuery.of(context).size.width * 0.5,
                        )
                      : Image.asset(
                          ImageConstants.appLogo.toPng,
                          width: MediaQuery.of(context).size.height * 0.5,
                          height: MediaQuery.of(context).size.height * 0.5,
                        ),
                  SpaceDivide(height: IntegerConsts.spaceNormal),
                  CustomTextField(
                    hint: StringConsts.email,
                    obscureText: false,
                    controller: emailController,
                  ),
                  SpaceDivide(height: IntegerConsts.spaceNormal),
                  CustomTextField(
                    hint: StringConsts.password,
                    obscureText: true,
                    isPassword: true,
                    controller: passwordController,
                  ),
                  Container(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        child: Text(StringConsts.forgetPassword),
                      )),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: ElevatedButton(
                        onPressed: () async {
                          bool result = await locator<AuthViewModel>()
                              .loginUser(context, emailController.text.trim(),
                                  passwordController.text.trim());
                          if (result) {
                            SnackBarResponse(context: context)
                                .showResponse(result, StringConsts.loginSucces);
                            Navigator.of(context)
                                .pushReplacement(MaterialPageRoute(
                              builder: (context) {
                                return HomeView();
                              },
                            ));
                          } else {
                            SnackBarResponse(context: context)
                                .showResponse(result, StringConsts.loginError);
                          }
                        },
                        child: Text(StringConsts.login)),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  // Text(StringConsts.other),
                  // TextButton(
                  //     onPressed: () {}, child: Text(StringConsts.register))
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }
}
