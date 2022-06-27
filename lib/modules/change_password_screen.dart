import 'package:avocado/shared/constants.dart';
import 'package:avocado/shared/profile_components.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../translation/locale_keys.g.dart';

class ChangePasswordScreen extends StatelessWidget {
   ChangePasswordScreen({Key? key}) : super(key: key);

  var currentPasswordController = TextEditingController();
  var newPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Change password',
          style: TextStyle(
            fontFamily: 'Nedian',
            fontSize: 20.0,
            color: gold,
          ),
        ),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30,),
            const Text(
              'Current Password',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17
              ),
            ),
            changePasswordFormField(
              controller: currentPasswordController,
              type: TextInputType.visiblePassword,
              hintText: 'Please enter your current password',
              suffix: Icons.remove_red_eye_outlined,
              suffixPressed: (){},
            ),
            const SizedBox(height: 40,),
            const Text(
              'New Password',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
              ),
            ),
            changePasswordFormField(
              controller: newPasswordController,
              type: TextInputType.visiblePassword,
              hintText: 'Please enter a new password',
              suffix: Icons.remove_red_eye_outlined,
              suffixPressed: (){},
            ),
          ],
        ),
      ),
      // body: ,
    );
  }
}
