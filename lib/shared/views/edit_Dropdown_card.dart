  import 'package:flutter/material.dart';

import '../../cubit/avocado_cubit.dart';
import '../constants.dart';
import '../profile_components.dart';

class EditDropdownCard extends StatelessWidget {
  IconData prefix;
  String title;
  String value;
  List<String> choice;
  void Function(String?)? onChange;

  EditDropdownCard({
    required this.prefix,
    required this.value,
    required this.title,
    required this.choice,
    required this.onChange,
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
                child: DropdownButton<String>(
                  alignment: AlignmentDirectional.centerEnd,
                  value: value,
                  icon: Expanded(
                    child: Row(
                      children: const[
                        Spacer(),
                         Icon(Icons.arrow_drop_down),
                      ],
                    ),
                  ),
                  elevation: 16,
                  style: const TextStyle(color: Colors.black,),
                  underline: Container(
                      height: 2,
                      color: gold
                  ),
                  onChanged: onChange,
                  items: choice.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
