import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_grade_viewer/controller/auth/login_controller.dart';
import 'package:smart_grade_viewer/core/class/status_request.dart';
import 'package:smart_grade_viewer/core/constant/color.dart';
import 'package:smart_grade_viewer/core/constant/image_asset.dart';
import 'package:smart_grade_viewer/core/constant/routes.dart';
import 'package:smart_grade_viewer/view/widget/auth/custom_auth_textfield.dart';
import 'package:smart_grade_viewer/view/widget/auth/custom_login_register_button.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(LoginController());
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        body: GetBuilder<LoginController>(builder: (controller) {
          return SingleChildScrollView(
            child: Form(
              key: controller.formstate,
              child: Column(
                children: [
                  Container(
                    color: AppColor.login3,
                    width: MediaQuery.of(context).size.width,
                    child: SafeArea(
                      child: Container(
                        height: MediaQuery.of(context).size.height * .2,
                        padding: const EdgeInsets.only(bottom: 16, left: 16),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    "Sign in to your\nAccount",
                                    style: TextStyle(
                                        letterSpacing: 1,
                                        fontFamily: "Manrope",
                                        fontSize: 32,
                                        fontWeight: FontWeight.w900,
                                        color: Colors.white),
                                  ),
                                  Text(
                                    "Sign in to your Account",
                                    style: TextStyle(
                                        fontFamily: "Manrope",
                                        fontSize: 14,
                                        color:
                                            Color.fromARGB(255, 189, 189, 189)),
                                  )
                                ],
                              ),
                            ),
                            Align(
                              alignment: Alignment.topRight,
                              child: Container(
                                padding:
                                    const EdgeInsets.only(top: 20, right: 20),
                                child: Image.asset(
                                  AppImageASset.schoolLogo,
                                  height: 80,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 16),
                    child: Column(children: [
                      CustomAuthTextfield(
                        isEnabled: !controller.changePassword.value,
                        textEditingController: controller.emailAddress,
                        valid: (val) {
                          if (val!.isEmpty) {
                            return "Enter required field";
                          } else {
                            return null;
                          }
                        },
                        iconColor: controller.emailIconColor,
                        hidePassword: false.obs,
                        labelText: "Email Address",
                        hinText: "Enter email address",
                        icon: Icons.email,
                        textInputType: TextInputType.emailAddress,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      CustomAuthTextfield(
                        isEnabled: !controller.changePassword.value,
                        textEditingController: controller.password,
                        valid: (val) {
                          if (val!.isEmpty) {
                            return "Enter required field";
                          } else {
                            return null;
                          }
                        },
                        iconColor: controller.passwordIconColor,
                        hidePassword: controller.hidePassword,
                        labelText: "Password",
                        hinText: "Enter password",
                        icon: Icons.lock,
                        isPassword: true,
                        textInputType: TextInputType.name,
                      ),
                      !controller.changePassword.value
                          ? const SizedBox()
                          : Column(
                              children: [
                                const SizedBox(
                                  height: 16,
                                ),
                                CustomAuthTextfield(
                                  textEditingController: controller.npassword,
                                  valid: (val) {
                                    if (val!.isEmpty) {
                                      return "Enter required field";
                                    } else if (val.length < 8) {
                                      return "Password must be at least 8 characters long";
                                    } else {
                                      return null;
                                    }
                                  },
                                  iconColor: controller.npasswordIconColor,
                                  hidePassword: controller.hideNPassword,
                                  labelText: "New Password",
                                  hinText: "Enter new password",
                                  icon: Icons.lock,
                                  isPassword: true,
                                  textInputType: TextInputType.name,
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                CustomAuthTextfield(
                                  textEditingController: controller.cpassword,
                                  valid: (val) {
                                    if (val!.isEmpty) {
                                      return "Enter required field";
                                    } else if (controller.npassword.text !=
                                        val) {
                                      return "Password doesn't match";
                                    } else {
                                      return null;
                                    }
                                  },
                                  iconColor: controller.cpasswordIconColor,
                                  hidePassword: controller.hideCPassword,
                                  labelText: "Confirm Password",
                                  hinText: "Enter confirm password",
                                  icon: Icons.lock,
                                  isPassword: true,
                                  textInputType: TextInputType.name,
                                ),
                              ],
                            ),
                      const SizedBox(
                        height: 24,
                      ),
                      const Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            "Forgot Password?",
                            style: TextStyle(
                                fontFamily: "Manrope",
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: AppColor.login1),
                          )),
                      const SizedBox(
                        height: 24,
                      ),
                      CustomLoginRegisterButton(
                          function:
                              controller.statusRequest == StatusRequest.loading
                                  ? () {}
                                  : () {
                                      controller.validateInput();
                                      FocusScope.of(context)
                                          .requestFocus(FocusNode());
                                    },
                          color: AppColor.login1,
                          size: MediaQuery.of(context).size.width,
                          text: "Login"),
                      const SizedBox(
                        height: 28,
                      ),
                      Row(
                        children: const [
                          Expanded(
                            child: Divider(
                              color: Colors.black54,
                              height: 1.0,
                            ),
                          ),
                          Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                'OR',
                                style: TextStyle(
                                    fontFamily: "Manrope",
                                    fontSize: 14,
                                    color: Colors.black45,
                                    fontWeight: FontWeight.w600),
                              )),
                          Expanded(
                            child: Divider(
                              color: Colors.black54,
                              height: 1.0,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: Colors.black38,
                              width: 1.0,
                            ),
                          ),
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Image.asset(
                                  AppImageASset.googleLogo,
                                  height: 20,
                                ),
                              ),
                              const Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "Login with Google",
                                  style: TextStyle(
                                      fontFamily: "Manrope",
                                      fontSize: 18,
                                      color: Colors.black45,
                                      fontWeight: FontWeight.w500),
                                ),
                              )
                            ],
                          )),
                      const SizedBox(
                        height: 24,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Don't have an account?",
                            style: TextStyle(
                                fontFamily: "Manrope",
                                fontSize: 16,
                                color: Colors.black87),
                          ),
                          GestureDetector(
                            onTap: () {
                              FocusScope.of(context).requestFocus(FocusNode());
                              Get.toNamed(AppRoute.registerPage);
                            },
                            child: Container(
                                padding: const EdgeInsets.all(4),
                                color: Colors.transparent,
                                child: const Text(
                                  "Register",
                                  style: TextStyle(
                                      fontFamily: "Manrope",
                                      fontSize: 16,
                                      color: AppColor.login1,
                                      fontWeight: FontWeight.w600),
                                )),
                          )
                        ],
                      )
                    ]),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
