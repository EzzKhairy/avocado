import 'package:flutter/material.dart';

import '../../cubit/avocado_cubit.dart';
import '../constants.dart';
import '../profile_components.dart';

class EditInfoCard extends StatelessWidget {
  TextEditingController controller;
  IconData prefix;
  String title;
  IconData? suffix;
  VoidCallback? suffixPressed;

  EditInfoCard({
    required this.controller,
    required this.prefix,
    required this.title,
    this.suffix,
    this.suffixPressed,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Card(
        color: Colors.grey.shade200,
        margin: const EdgeInsets.all(8.0),
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 15,vertical: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children:[
              Row(
                children: [
                  SizedBox(width: 5,),
                  Icon(prefix,size: 15,color: gold,),
                  SizedBox(width: 5,),
                  Text(title,style: TextStyle(color: Colors.grey.shade500,)),
                ],
              ),
              profileFormField(
                  controller: controller,
                  validate: (value){
                    if(value!.isEmpty) {
                      return 'This field must not be Empty';
                    }
                    else if (value.contains('@') == false) {
                      return 'Email Formula is incorrect';
                    }
                    else if(value.compareTo(controller.text)!=0){
                      AvocadoCubit.get(context).toggleIsChanged();
                    }
                  },
                  type: TextInputType.text,
                suffix: suffix,
                suffixPressed: suffixPressed
              )
            ],
          ),
        ),
      ),
    );
  }
}
