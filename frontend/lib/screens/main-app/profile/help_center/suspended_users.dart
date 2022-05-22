import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/back_close_appbar.dart';
import 'package:flutter_application_1/component/button/disable_toggle_button.dart';
import 'package:flutter_application_1/component/curved_widget.dart';
import 'package:flutter_application_1/component/header_style/jassy_gradient_color.dart';
import 'package:flutter_application_1/component/input_feilds/required_text_field_label.dart';
import 'package:flutter_application_1/component/popup_page/popup_no_button/success_popup_no_button.dart';
import 'package:flutter_application_1/theme/index.dart';
import 'package:get/utils.dart';

class SuspendedUsers extends StatefulWidget {
  final user;
  const SuspendedUsers(this.user, {Key? key}) : super(key: key);

  @override
  State<SuspendedUsers> createState() => _SuspendedUsersState();
}

class _SuspendedUsersState extends State<SuspendedUsers> {
  TextEditingController headerController = TextEditingController();
  TextEditingController detailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String getHeader = '';
  String getDetail = '';

  saveRequest() async {
    CollectionReference suspended =
        FirebaseFirestore.instance.collection('SuspendedUser');
    DocumentReference docRef = await suspended.add({
      'requestHeader': getHeader,
      'requestDetail': getDetail,
      'requestBy': widget.user['uid'],
      'date': DateTime.now(),
    });
    await suspended.doc(docRef.id).update({
      'requestId': docRef.id,
    });
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    headerController.dispose();
    detailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: BackAndCloseAppBar(
        text: "SuspendedUsers".tr,
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            const CurvedWidget(child: JassyGradientColor()),
            RequiredTextFieldLabel(textLabel: "RequestTitle".tr),
            Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 5, horizontal: 20.0),
              child: TextFormField(
                controller: headerController,
                keyboardType: TextInputType.text,
                onChanged: (String header) {
                  header = headerController.text;
                  getHeader = header;
                },
                decoration: InputDecoration(
                  hintText: "RequestTitle".tr,
                  hintStyle: const TextStyle(color: greyDark),
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 15.0, horizontal: 10.0),
                  fillColor: textLight,
                  filled: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                      borderSide:
                          const BorderSide(color: textLight, width: 0.0)),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40.0),
                    borderSide: const BorderSide(color: textLight),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40.0),
                    borderSide: const BorderSide(color: textLight),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'InfoPleaseFill'.tr;
                  }
                  return null;
                },
                // onSaved: (String? firstname) {
                //   firstname = firstNameController.text;
                //   name.firstname = firstname;
                // },
              ),
            ),
            RequiredTextFieldLabel(textLabel: "RequestDetail".tr),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
              child: TextFormField(
                controller: detailController,
                keyboardType: TextInputType.multiline,
                maxLines: 8,
                onChanged: (String detail) {
                  detail = detailController.text;
                  getDetail = detail;
                },
                decoration: InputDecoration(
                  hintText: "RequestDetail".tr,
                  hintStyle: const TextStyle(color: greyDark),
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 15.0, horizontal: 10.0),
                  fillColor: textLight,
                  filled: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide:
                          const BorderSide(color: textLight, width: 0.0)),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: const BorderSide(color: textLight),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: const BorderSide(color: textLight),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'InfoPleaseFill'.tr;
                  }
                  return null;
                },
              ),
            ),
            const Spacer(),
            Center(
              child: DisableToggleButton(
                text: "Confirm".tr,
                minimumSize: Size(size.width * 0.8, size.height * 0.05),
                press: () async {
                  if (_formKey.currentState!.validate()) {
                    await saveRequest();
                    await Future.delayed(
                      const Duration(seconds: 2),
                      () => showDialog(
                          context: context,
                          builder: (context) {
                            return SuccessPopUpNoButton(
                              text: 'Success'.tr,
                            );
                          }),
                    );
                    Navigator.of(context).pop();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
