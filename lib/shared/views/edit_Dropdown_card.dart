  import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../cubit/avocado_cubit.dart';
import '../../translation/locale_keys.g.dart';
import '../constants.dart';
import '../profile_components.dart';

class EditDropdownCard extends StatelessWidget {
  IconData prefix;
  String title;

  DropdownButton dropdownButton;

  EditDropdownCard({
    required this.prefix,
    required this.title,
    required this.dropdownButton,
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
              SizedBox(
                width: double.infinity,
                child: dropdownButton
              ),
            ],
          ),
        ),
      ),
    );
  }
}
