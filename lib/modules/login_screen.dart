import 'package:avocado/Layout/app_layout.dart';
import 'package:avocado/cubit/login_cubit.dart';
import 'package:avocado/cubit/states.dart';
import 'package:avocado/modules/register_screen.dart';
import 'package:avocado/remoteNetwork/cache_helper.dart';
import 'package:avocado/shared/components.dart';
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
        listener: (context, state) => {
          if(state is LawyerLoginSuccessful)
            {
              if(state.model.status == 'true')
                {
                  CacheHelper.saveData(key: 'token', value: state.model.accessToken),
                  navigateTo(context, const AppLayout())
                }
            }
        },
        builder: (context, state) {
          return Scaffold(
            body:
            Container(
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
                //
                // image: const DecorationImage(image: AssetImage("assets/images/VerticalLogo.png"),fit: BoxFit.cover),
              ),
              child: Center(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      Stack(
                        alignment: AlignmentDirectional.topCenter,
                        children :[
                          const Image(image: AssetImage("assets/images/VerticalLogo2.png"),
                              fit: BoxFit.contain,width: 400,height: 400,),
                          SizedBox(
                          height: MediaQuery.of(context).size.height,
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Form(
                              key: formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const SizedBox(
                                    height: 200,
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
                                    height: 50.0,
                                  ),
                                  defaultButton(text: 'Login',
                                      function: (){
                                        AvocadoLoginCubit.get(context).lawyerLogin(
                                            email: emailController.text,
                                            password: passwordController.text
                                        );
                                      }
                                  ),
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
                                          navigateTo(context, RegisterScreen());
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
}

