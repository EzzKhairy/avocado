import 'package:avocado/shared/constants.dart';
import 'package:avocado/translation/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';


class ModelInfoScreen extends StatelessWidget {
  String? pdf;
  ModelInfoScreen(this.pdf,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.black,
                elevation: 0,
                centerTitle: true,
                title: Text(
                  LocaleKeys.models.tr(),
                  style: TextStyle(
                    fontFamily: 'Nedian',
                    fontSize: 25.0,
                    color: gold,
                  ),
                ),
              ),
              body: Center(
                  child: const PDF().fromUrl(
                    pdf!,
                    placeholder: (progress) => Center(child: Text('$progress %')),
                    errorWidget: (error) => Center(child: Text('PDF ERROR''${error.toString()}')),
                  )
              )
          );
        }
  }

