import 'package:avocado/cubit/avocado_cubit.dart';
import 'package:avocado/cubit/states.dart';
import 'package:avocado/models/payments_model.dart';
import 'package:avocado/shared/components.dart';
import 'package:avocado/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';

class PaymentsScreen extends StatelessWidget {
  final int? caseId;
  const PaymentsScreen(this.caseId,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        AvocadoCubit.get(context).getPayments(caseId: caseId);
        return BlocConsumer<AvocadoCubit,AvocadoStates>(
          listener: (context,state){},
          builder: (context,state) {
            List<PaymentsData>? paymentsData = AvocadoCubit.get(context).paymentsModel!.paymentsData;
            return Conditional.single(
              context: context,
              conditionBuilder: (context) => state is GetPaymentsDataSuccessful,
              widgetBuilder:(context) => Scaffold(
                appBar: NewGradientAppBar(
                  centerTitle: true,
                  title: Text(
                    'Payments'.toUpperCase(),
                    style: TextStyle(
                      fontFamily: 'Nedian',
                      fontSize: 25.0,
                      color: gold,
                    ),
                  ),
                  gradient: LinearGradient(
                      colors: [
                        Colors.black.withOpacity(0.842),
                        Colors.black.withOpacity(0.845),
                        Colors.black.withOpacity(0.89),
                      ],
                      begin: AlignmentDirectional.topEnd,
                      end: AlignmentDirectional.bottomStart,
                      stops: const [0.20, 0.17, 0.40]),
                ),
                body: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      searchBar(),
                      const SizedBox(height: 15,),
                      Conditional.single(
                      context: context,
                      conditionBuilder: (context)=> paymentsData!.isNotEmpty,
                      widgetBuilder:(context) => ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => buildPaymentsItem(paymentsData![index],context),
                        separatorBuilder: (context, index) => const SizedBox(height: 10,),
                        itemCount: paymentsData!.length,
                      ),
                      fallbackBuilder: (context) => const Center(child: Text(
                        'No Payments Included',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      ),
                      ),
                    ],
                  ),
                ),
              ),
              fallbackBuilder: (context) => scaleProgressIndicator(context)
            );
          },
        );
      }
    );
  }


  Widget buildPaymentsItem(PaymentsData? paymentsData,context)=> Card(
    clipBehavior: Clip.antiAliasWithSaveLayer,
    elevation: 5,
    margin: const EdgeInsetsDirectional.all(2.5),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    child: Container(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${paymentsData?.name}',
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 10,),
            Text(
              'amount : ${paymentsData?.amount}',
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
