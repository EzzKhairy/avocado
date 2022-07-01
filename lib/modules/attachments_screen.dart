
import 'package:avocado/cubit/avocado_cubit.dart';
import 'package:avocado/cubit/states.dart';
import 'package:avocado/translation/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';

import '../shared/constants.dart';

class PDFViewerScreen extends StatelessWidget {
  final String doc;

  const PDFViewerScreen({required this.doc, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AvocadoCubit, AvocadoStates>(
        listener: (context, state) {},
        builder: (context, state) {
          print(doc);
          return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.black,
                elevation: 0,
                centerTitle: true,
                title: Text(
                  LocaleKeys.attachments.tr(),
                  style: TextStyle(
                    fontFamily: 'Nedian',
                    fontSize: 25.0,
                    color: gold,
                  ),
                ),
              ),
              body: Center(
                child: const PDF().fromUrl(
                  doc,
                  placeholder: (progress) => Center(child: Text('$progress %')),
                  errorWidget: (error) => Center(child: Text('PDF ERROR''${error.toString()}')),
                )
              )
          );
        }
    );
  }
}