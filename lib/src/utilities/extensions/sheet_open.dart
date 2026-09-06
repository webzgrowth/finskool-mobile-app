// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:hellow_fe/src/presentation/bloc/bottomsheet/bottomsheet_bloc.dart';

// ShowSheet(BuildContext context, Widget content,
//     {Color? bgcolor,
//     bool isDismissible = true,
//     bool isScrollControlled = true}) {
//   context.read<BottomsheetBloc>().add(BottomsheetEvent.openBottomSheet(true));
//   return showModalBottomSheet(
//       context: context,
//       builder: (context) => content,
//       isDismissible: isDismissible,
//       isScrollControlled: isScrollControlled,
//       backgroundColor: bgcolor ?? Colors.white,
//       shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.only(
//         topLeft: Radius.circular(16),
//         topRight: Radius.circular(16),
//       ))).whenComplete(() {
//     // Trigger the close bottom sheet event
//     context
//         .read<BottomsheetBloc>()
//         .add(BottomsheetEvent.openBottomSheet(false));
//   });
// }

// ShowToastSheet(BuildContext context, Widget content,
//     {Color? bgcolor, double? height}) {
//   context.read<BottomsheetBloc>().add(BottomsheetEvent.openBottomSheet(true));
//   return showModalBottomSheet(
//       context: context,
//       builder: (context) => ClipRRect(
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(16),
//             topRight: Radius.circular(16),
//           ),
//           child: SizedBox(
//               height: height ?? MediaQuery.of(context).size.height * 0.5,
//               child: Scaffold(body: content))),
//       isDismissible: true,
//       isScrollControlled: true,
//       backgroundColor: bgcolor ?? Colors.white,
//       shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.only(
//         topLeft: Radius.circular(16),
//         topRight: Radius.circular(16),
//       ))).whenComplete(() {
//     // Trigger the close bottom sheet event
//     context
//         .read<BottomsheetBloc>()
//         .add(BottomsheetEvent.openBottomSheet(false));
//   });
// }
