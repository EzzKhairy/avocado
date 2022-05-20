import 'package:avocado/Layout/app_layout.dart';
import 'package:avocado/cubit/avocado_cubit.dart';
import 'package:avocado/cubit/register_cubit.dart';
import 'package:avocado/cubit/states.dart';
import 'package:avocado/modules/login_screen.dart';
import 'package:avocado/remoteNetwork/cache_helper.dart';
import 'package:avocado/shared/components.dart';
import 'package:avocado/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    return Builder(
        builder: (context) {
          return BlocProvider(
            create: (context) => RegisterCubit(),
            child: BlocConsumer<RegisterCubit, AvocadoStates>(
              listener: (context, state) {
                if (state is LawyerRegisterSuccessful) {
                  if(state.model.status == 'true') {
                    showToast(context: context, msg: state.model.message,backgroundColor: Colors.green);
                    CacheHelper.saveData(key: 'token', value: state.model.accessToken);
                  CacheHelper.saveData(key: 'id', value: state.model.lawyersData?.id);
                  AvocadoCubit.get(context).getLawyerProfile(lawyerId);
                  navigateTo(context, const AppLayout());
              }
                  else{
                    showToast(context: context, msg: state.model.message,backgroundColor: Colors.red);

                  }
            }
              },
              builder: (context, state) {
                RegisterCubit cubit = RegisterCubit.get(context);
                return Scaffold(
                  body: Container(
                    decoration: BoxDecoration(
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
                          stops: const [0.15, 0.15, 0.15, 0.15, 0.15, 0.60]
                      ),
                      // image: const DecorationImage(image: AssetImage("assets/images/VerticalLogo.png"),fit: BoxFit.cover),
                    ),
                    child: Center(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            const SizedBox(height: 50,),
                            Stack(
                              alignment: AlignmentDirectional.topCenter,
                              children: [
                                const Image(image: AssetImage(
                                    "assets/images/VerticalLogo2.png"),
                                  fit: BoxFit.cover, width: 250, height: 250,),
                                SizedBox(
                                  height: MediaQuery
                                      .of(context)
                                      .size
                                      .height,
                                  child: Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Form(
                                      key: signUpFormKey,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment
                                            .center,
                                        children: [
                                          const SizedBox(height: 150,),
                                          defaultFormField(
                                            controller: name,
                                            type: TextInputType.name,
                                            validate: (value) {
                                              if (value == null) {
                                                return ('name is required');
                                              }
                                            },
                                            label: 'Name',
                                            prefix: Icons.person_outline,
                                          ),
                                          const SizedBox(height: 10,),
                                          defaultFormField(
                                            controller: phone,
                                            type: TextInputType.phone,
                                            validate: (value) {
                                              if (value == null) {
                                                return ('phone is required');
                                              }
                                            },
                                            label: 'Phone',
                                            prefix: Icons.phone_outlined,
                                          ),
                                          const SizedBox(height: 10,),
                                          defaultFormField(
                                            controller: emailAddress,
                                            type: TextInputType.emailAddress,
                                            validate: (value) {
                                              if (value == null) {
                                                return ('email address is required');
                                              }
                                            },
                                            label: 'Email Address',
                                            prefix: Icons.email_outlined,
                                          ),
                                          const SizedBox(height: 10,),
                                          defaultFormField(
                                            controller: password,
                                            type: TextInputType.visiblePassword,
                                            validate: (value) {
                                              if (value == null) {
                                                return ('password is required');
                                              }
                                            },
                                            label: 'Password',
                                            prefix: Icons.lock_outline,
                                            isPassword: true,
                                            suffix: Icons
                                                .remove_red_eye_outlined,
                                              suffixPressed: (){
                                                RegisterCubit.get(context).changePasswordVisibility();
                                              }
                                          ),
                                          const SizedBox(height: 10,),
                                          defaultFormField(
                                            controller: confirmPassword,
                                            type: TextInputType.visiblePassword,
                                            validate: (value) {
                                              if (value == null) {
                                                return ('password not match');
                                              }
                                            },
                                            label: 'Confirm Password',
                                            prefix: Icons.lock_outline,
                                            isPassword: true,
                                            suffix: Icons
                                                .remove_red_eye_outlined,
                                            suffixPressed: (){
                                              RegisterCubit.get(context).changeConfirmPasswordVisibility();
                                            }
                                          ),
                                          const SizedBox(height: 40,),
                                          defaultButton(
                                              text: 'Register',
                                              function: () {
                                                if(signUpFormKey.currentState!.validate()) {
                                                cubit.lawyerRegister(
                                                    email: emailAddress.text,
                                                    password: password.text,
                                                    confirmPassword: confirmPassword.text,
                                                    lawyerNationalNumber: phone.text,
                                                    name: name.text
                                                );
                                            }
                                          }
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment
                                                .center,
                                            children: [
                                              const Text(
                                                "Already have an account?",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  navigateTo(
                                                      context, LoginScreen());
                                                },
                                                child: Text(
                                                  'Sign In',
                                                  style: TextStyle(
                                                    color: gold,
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
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        }
    );
  }
}
