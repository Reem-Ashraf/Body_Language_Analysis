import '../../../model/User_Model.dart';
import '../../../model/login_model/login_model.dart';
import '../../../model/shaerd_prefrense/shaerd_prefrense.dart';

const String baseUrl="http://127.0.0.1:5000";

LoginModel? user;

//Tokens
String accessToken = "token";
String? token =   CacheHelper.getData(key: accessTokenKey);
String accessTokenKey = "access_token";
final List<String> items = [
  'Item1',
  'Item2',
  'Item3',
  'Item4',
  'Item5',
  'Item6',
  'Item7',
  'Item8',
];
String? selectedValue;

// @override
// Widget build(BuildContext context) {
//   return Scaffold(
//     body: Center(
//       child: DropdownButtonHideUnderline(
//         child: DropdownButton2(
//           isExpanded: true,
//           hint: Row(
//             children: const [
//               Icon(
//                 Icons.list,
//                 size: 16,
//                 color: Colors.yellow,
//               ),
//               SizedBox(
//                 width: 4,
//               ),
//               Expanded(
//                 child: Text(
//                   'Select Item',
//                   style: TextStyle(
//                     fontSize: 14,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.yellow,
//                   ),
//                   overflow: TextOverflow.ellipsis,
//                 ),
//               ),
//             ],
//           ),
//           items: items
//               .map((item) => DropdownMenuItem<String>(
//             value: item,
//             child: Text(
//               item,
//               style: const TextStyle(
//                 fontSize: 14,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.white,
//               ),
//               overflow: TextOverflow.ellipsis,
//             ),
//           ))
//               .toList(),
//           value: selectedValue,
//           onChanged: (value) {
//             setState(() {
//               selectedValue = value as String;
//             });
//           },
//           buttonStyleData: ButtonStyleData(
//             height: 50,
//             width: 160,
//             padding: const EdgeInsets.only(left: 14, right: 14),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(14),
//               border: Border.all(
//                 color: Colors.black26,
//               ),
//               color: Colors.redAccent,
//             ),
//             elevation: 2,
//           ),
//           iconStyleData: const IconStyleData(
//             icon: Icon(
//               Icons.arrow_forward_ios_outlined,
//             ),
//             iconSize: 14,
//             iconEnabledColor: Colors.yellow,
//             iconDisabledColor: Colors.grey,
//           ),
//           dropdownStyleData: DropdownStyleData(
//               maxHeight: 200,
//               width: 200,
//               padding: null,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(14),
//                 color: Colors.redAccent,
//               ),
//               elevation: 8,
//               offset: const Offset(-20, 0),
//               scrollbarTheme: ScrollbarThemeData(
//                 radius: const Radius.circular(40),
//                 thickness: MaterialStateProperty.all(6),
//                 thumbVisibility: MaterialStateProperty.all(true),
//               )),
//           menuItemStyleData: const MenuItemStyleData(
//             height: 40,
//             padding: EdgeInsets.only(left: 14, right: 14),
//           ),
//         ),
//       ),
//     ),
//   );
// }
