import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:smart_grade_viewer/controller/auth/register_controller.dart';
import 'package:smart_grade_viewer/core/class/status_request.dart';
import 'package:smart_grade_viewer/core/constant/color.dart';
import 'package:smart_grade_viewer/core/constant/image_asset.dart';
import 'package:smart_grade_viewer/core/functions/show_message.dart';
import 'package:smart_grade_viewer/core/functions/valid_input.dart';
import 'package:smart_grade_viewer/view/widget/auth/custom_auth_textfield.dart';
import 'package:smart_grade_viewer/view/widget/auth/custom_login_register_button.dart';
import 'package:smart_grade_viewer/view/widget/scanner_overlay.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(RegisterController());
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        body: GetBuilder<RegisterController>(builder: (controller) {
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
                        height: MediaQuery.of(context).size.height * .18,
                        padding: const EdgeInsets.only(bottom: 16, left: 16),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Get.back();
                                    },
                                    child: Container(
                                        padding: const EdgeInsets.only(
                                            left: 5,
                                            top: 12,
                                            right: 10,
                                            bottom: 10),
                                        child: const Icon(
                                          Icons.arrow_back_ios,
                                          size: 24,
                                          color: Color.fromARGB(
                                              255, 209, 209, 209),
                                        )),
                                  ),
                                  const Spacer(),
                                  const Text(
                                    "Register",
                                    style: TextStyle(
                                        letterSpacing: 1,
                                        fontFamily: "Manrope",
                                        fontSize: 32,
                                        fontWeight: FontWeight.w900,
                                        color: Colors.white),
                                  ),
                                  const Text(
                                    "Create your Account",
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
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          controller.schoolID.value.isEmpty
                              ? const SizedBox()
                              : Container(
                                  padding: const EdgeInsets.only(right: 8),
                                  child: Text(
                                    controller.schoolID.value,
                                    style: const TextStyle(
                                      fontFamily: "Manrope",
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                      color: Colors.black54,
                                    ),
                                  )),
                          GestureDetector(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Dialog(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                      ),
                                      backgroundColor: Colors.white,
                                      child: Container(
                                        padding: const EdgeInsets.only(
                                            left: 20,
                                            bottom: 25,
                                            top: 16,
                                            right: 20),
                                        width: Get.width,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            const Text(
                                              "Place the QR Code in the area",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontFamily: "Manrope"),
                                            ),
                                            const SizedBox(
                                              height: 16,
                                            ),
                                            Container(
                                              height: 300,
                                              decoration: ShapeDecoration(
                                                shape: QrScannerOverlayShape(
                                                  borderColor: Colors.blue,
                                                  borderWidth: 12,
                                                  cutOutHeight: 300,
                                                  cutOutWidth: 300,
                                                ),
                                              ),
                                              child: SizedBox(
                                                width: 280,
                                                child: MobileScanner(
                                                  allowDuplicates: false,
                                                  fit: BoxFit.cover,
                                                  onDetect: (barcode, args) {
                                                    Get.back(result: true);
                                                    if (controller.validateID(
                                                        barcode.rawValue!)) {
                                                      controller
                                                              .schoolID.value =
                                                          barcode.rawValue!;
                                                      controller.update();
                                                    } else {
                                                      showErrorMessage(
                                                          "Invalid ID",
                                                          seconds: 1);
                                                    }
                                                  },
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: AppColor.login1,
                                  borderRadius: BorderRadius.circular(4)),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 8),
                              child: Row(
                                children: const [
                                  Icon(
                                    Icons.qr_code_scanner_rounded,
                                    size: 22,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    "Scan ID",
                                    style: TextStyle(
                                      fontFamily: "Manrope",
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      CustomAuthTextfield(
                        textEditingController: controller.firstName,
                        valid: (val) {
                          return validInput(val, "name");
                        },
                        iconColor: controller.firstNameIconColor,
                        hidePassword: false.obs,
                        labelText: "First Name",
                        hinText: "Enter first name",
                        icon: Icons.person,
                        textInputType: TextInputType.name,
                        textCapitalization: TextCapitalization.words,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      CustomAuthTextfield(
                        textEditingController: controller.lastName,
                        valid: (val) {
                          return validInput(val, "name");
                        },
                        iconColor: controller.lastNameIconColor,
                        hidePassword: false.obs,
                        labelText: "Last Name",
                        hinText: "Enter last name",
                        icon: Icons.person,
                        textInputType: TextInputType.name,
                        textCapitalization: TextCapitalization.words,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      CustomAuthTextfield(
                        textEditingController: controller.emailAddress,
                        valid: (val) {
                          if (val!.isEmpty) {
                            return "Enter required field";
                          } else if (!val.isEmail) {
                            return "Enter valid email";
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
                        textEditingController: controller.password,
                        valid: (val) {
                          if (val!.isEmpty) {
                            return "Enter required field";
                          } else if (val.length < 8) {
                            return "Password must be at least 8 characters long";
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
                      const SizedBox(
                        height: 16,
                      ),
                      CustomAuthTextfield(
                        textEditingController: controller.cpassword,
                        valid: (val) {
                          if (val!.isEmpty) {
                            return "Enter required field";
                          } else if (controller.password.text != val) {
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
                          text: "Register"),
                      const SizedBox(
                        height: 24,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Already have an account?",
                            style: TextStyle(
                                fontFamily: "Manrope",
                                fontSize: 16,
                                color: Colors.black87),
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: Container(
                                padding: const EdgeInsets.all(4),
                                color: Colors.transparent,
                                child: const Text(
                                  "Login",
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
