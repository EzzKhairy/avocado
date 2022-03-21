import 'package:avocado/shared/constants.dart';
import 'package:avocado/shared/profile_components.dart';
import 'package:flutter/material.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';

class ChangePasswordScreen extends StatelessWidget {
   ChangePasswordScreen({Key? key}) : super(key: key);

  var currentPasswordController = TextEditingController();
  var newPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NewGradientAppBar(
          title: Text(
            'AVOCADO',
            style: TextStyle(
              fontFamily: 'Nedian',
              fontSize: 23.0,
              color: gold,
              fontWeight: FontWeight.bold,
            ),
          ),
        gradient: LinearGradient(
            colors: [
              Colors.black.withOpacity(0.70),
              Colors.black.withOpacity(0.75),
              Colors.black.withOpacity(0.60),
              Colors.black.withOpacity(0.65),
              Colors.black.withOpacity(0.70),
              Colors.black.withOpacity(0.95),
            ],
            begin: AlignmentDirectional.topEnd,
            end: AlignmentDirectional.bottomStart,
            stops: const [0.15,0.15,0.15,0.15,0.15,0.60]
        ),
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
