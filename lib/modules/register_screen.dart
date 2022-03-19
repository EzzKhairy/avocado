import 'package:avocado/shared/components.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
   RegisterScreen({Key? key}) : super(key: key);

  var name = TextEditingController();
  var phone = TextEditingController();
  var emailAddress = TextEditingController();
  var password = TextEditingController();
  var confirmPassword = TextEditingController();
  var signUpFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration:  BoxDecoration(
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
          // image: const DecorationImage(image: AssetImage("assets/images/VerticalLogo.png"),fit: BoxFit.cover),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(40.0),
              child: Form(
                key: signUpFormKey,
                child: Column(
                  children: [
                    defaultFormField(
                      controller: name,
                      type: TextInputType.name,
                      validate: (value)
                      {
                        if(value == null)
                        {
                          return('name is required');
                        }
                      },
                      label: 'Name',
                      prefix: Icons.person_outline,
                    ),
                    const SizedBox(height: 10,),
                    defaultFormField(
                      controller: phone,
                      type: TextInputType.phone,
                      validate: (value)
                      {
                        if(value == null)
                        {
                          return('phone is required');
                        }
                      },
                      label: 'Phone',
                      prefix: Icons.phone_outlined,
                    ),
                    const SizedBox(height: 10,),
                    defaultFormField(
                      controller: emailAddress,
                      type: TextInputType.emailAddress,
                      validate: (value)
                      {
                        if(value == null)
                        {
                          return('email address is required');
                        }
                      },
                      label: 'Email Address',
                      prefix: Icons.email_outlined,
                    ),
                    const SizedBox(height: 10,),
                    defaultFormField(
                      controller: password,
                      type: TextInputType.visiblePassword,
                      validate: (value)
                      {
                        if(value == null)
                        {
                          return('password is required');
                        }
                      },
                      label: 'Password',
                      prefix: Icons.lock_outline,
                      isPassword: true,
                      suffix: Icons.remove_red_eye_outlined,
                    ),
                    const SizedBox(height: 10,),
                    defaultFormField(
                      controller: confirmPassword,
                      type: TextInputType.visiblePassword,
                      validate: (value)
                      {
                        if(value == null)
                        {
                          return('password not match');
                        }
                      },
                      label: 'Confirm Password',
                      prefix: Icons.lock_outline,
                      isPassword: true,
                      suffix: Icons.remove_red_eye_outlined,
                    ),
                    const SizedBox(height: 40,),
                    defaultButton(text: 'Register',),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
