import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/back_close_appbar.dart';
import 'package:flutter_application_1/component/button/disable_toggle_button.dart';
import 'package:flutter_application_1/component/curved_widget.dart';
import 'package:flutter_application_1/component/header_style/jassy_gradient_color.dart';
import 'package:flutter_application_1/component/input_feilds/required_text_field_label.dart';
import 'package:flutter_application_1/theme/index.dart';
import 'package:get/utils.dart';

class SuspendedUsers extends StatefulWidget {
  const SuspendedUsers({Key? key}) : super(key: key);

  @override
  State<SuspendedUsers> createState() => _SuspendedUsersState();
}

class _SuspendedUsersState extends State<SuspendedUsers> {
  TextEditingController headerController = TextEditingController();
  TextEditingController detailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

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
      appBar: BackAndCloseAppBar(text: "SuspendedUsers".tr,),
      body: Form(
        key: _formKey,
        child: Column( 
          children: [
            const CurvedWidget(child: JassyGradientColor()),
            RequiredTextFieldLabel(textLabel: "RequestTitle".tr),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20.0),
              child: TextFormField(
                controller: headerController,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              hintText: "RequestTitle".tr,
                              hintStyle: const TextStyle(color: greyDark),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 15.0, horizontal: 10.0),
                              fillColor: textLight,
                              filled: true,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(40),
                                  borderSide: const BorderSide(
                                      color: textLight, width: 0.0)),
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
                controller: headerController,
                keyboardType: TextInputType.multiline,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: "RequestDetail".tr,
                  hintStyle: const TextStyle(color: greyDark),
                  contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                  fillColor: textLight,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40),
                    borderSide: const BorderSide(
                      color: textLight, width: 0.0)),
                  enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40.0),
                  borderSide:const BorderSide(color: textLight),),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40.0),
                          borderSide:
                          const BorderSide(color: textLight),
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
                press: () {
                  if (_formKey.currentState!.validate()) {
                    // Todo: confirm
                      //  _formKey.currentState!.save();
                      //  Navigator.pushNamed(context, Routes.RegisterLanguage,
                      //  arguments: [name, userInfo]);
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