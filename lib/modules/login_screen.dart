import 'package:avocado/cubit/loginCubit.dart';
import 'package:avocado/cubit/states.dart';
import 'package:avocado/modules/register_screen.dart';
import 'package:avocado/shared/components.dart';
import 'package:avocado/shared/styles/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

class LoginScreen extends StatelessWidget {

  var formKey = GlobalKey<FormState>();

  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    
    
    return BlocProvider(
      create: (BuildContext context) => AvocadoLoginCubit(),
      child: BlocConsumer<AvocadoLoginCubit, AvocadoStates>(
        listener: (context, state) => {},
        builder: (context, state) {
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
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Center(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 45.0,
                            ),
                            defaultFormField(
                              controller: emailController,
                              type: TextInputType.emailAddress,
                              validate: (String?value) {
                                if (value!.isEmpty) {
                                  return ('please enter email');
                                }
                              },
                              label: 'Email Address',
                              prefix: Icons.email_outlined,
                            ),
                            const SizedBox(
                              height: 15.0,
                            ),
                            defaultFormField(
                              controller: passwordController,
                              type: TextInputType.visiblePassword,
                              suffix: AvocadoLoginCubit.get(context).suffix,
                              isPassword: AvocadoLoginCubit.get(context).isPassword,
                              suffixPressed: () {
                                AvocadoLoginCubit.get(context).changePasswordVisibility();
                              },
                              validate: (String?value) {
                                if (value!.isEmpty) {
                                  return ('Password is too short');
                                }
                              },
                              label: 'Password',
                              prefix: Icons.lock_outline_rounded,
                            ),
                            const SizedBox(
                              height: 25.0,
                            ),
                            defaultButton(text: 'Login'),
                            const SizedBox(
                              height: 15.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Don't have an account?",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    navigateTo(context, const RegisterScreen());
                                  },
                                  child: Text(
                                    'REGISTER NOW',
                                    style: TextStyle(
                                      color: HexColor('D8C690'),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

