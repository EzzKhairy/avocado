import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  final String title;
  final String body;
  final double width;

  const InfoCard({
    required this.title,
    required this.body,
    this.width = double.infinity,
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
          width: width,
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children:[
              Text(title,style: TextStyle(color: Colors.grey.shade600
              ),textAlign: TextAlign.left,),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  const SizedBox(width: 15,),
                  Expanded(child: Text(body,style: const TextStyle(fontSize: 18),maxLines: 3,)),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
