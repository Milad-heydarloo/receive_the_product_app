// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:receive_the_product/Getx/Drawer/DrawerController.dart';
// import 'package:receive_the_product/Getx/Drawer/MyDrawer.dart';
// // Import the updated controller
//
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:receive_the_product/Getx/PagesOrderProduct/orderproduct_b.dart';
//
// import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
//
// import 'package:get/get.dart';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp
//
//   ({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       title: 'کارشناسان خرید و فروش',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         fontFamily: 'vazir',
//         primarySwatch: Colors.blue,
//         primaryColor: Colors.blue,
//         hintColor: Colors.black,
//         scaffoldBackgroundColor: Colors.white,
//         appBarTheme: AppBarTheme(
//           color: Colors.blue,
//           titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
//         ),
//         buttonTheme: ButtonThemeData(
//           buttonColor: Colors.blue, // رنگ دکمه‌ها
//         ),
//         elevatedButtonTheme: ElevatedButtonThemeData(
//           style: ElevatedButton.styleFrom(
//             foregroundColor: Colors.white,
//             backgroundColor: Colors.blue,
//           ),
//         ),
//         textButtonTheme: TextButtonThemeData(
//           style: TextButton.styleFrom(
//             foregroundColor: Colors.blue, // رنگ دکمه‌های متنی
//           ),
//         ),
//         outlinedButtonTheme: OutlinedButtonThemeData(
//           style: OutlinedButton.styleFrom(
//             foregroundColor: Colors.blue, // رنگ دکمه‌های مرزی
//           ),
//         ),
//         floatingActionButtonTheme: FloatingActionButtonThemeData(
//           backgroundColor: Colors.blue,
//         ),
//         inputDecorationTheme: InputDecorationTheme(
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(8.0),
//             borderSide: BorderSide(
//               color: Colors.blue,
//             ),
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(8.0),
//             borderSide: BorderSide(
//               color: Colors.blue,
//             ),
//           ),
//           enabledBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(8.0),
//             borderSide: BorderSide(
//               color: Colors.blueAccent,
//             ),
//           ),
//         ),
//         // textTheme: TextTheme(
//         //   headline1: TextStyle(
//         //       fontSize: 32, fontWeight: FontWeight.bold, color: Colors.blue),
//         //   headline6: TextStyle(
//         //       fontSize: 18,
//         //       fontWeight: FontWeight.bold,
//         //       color: Colors.blueAccent),
//         //   bodyText2: TextStyle(fontSize: 14, color: Colors.black87),
//         // ),
//         cardTheme: CardTheme(
//           color: Colors.white,
//           shadowColor: Colors.blueAccent,
//           margin: EdgeInsets.all(8),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(8.0),
//           ),
//         ),
//       ),
//       home: FlutterSplashScreen.scale(
//         gradient: LinearGradient(
//           begin: Alignment.topCenter,
//           end: Alignment.bottomCenter,
//           colors: [
//             Colors.white,
//             Colors.white,
//           ],
//         ),
//         childWidget: SizedBox(
//           height: 800,
//           width: 800,
//           child: Image.asset("assets/satter.png"),
//         ),
//         duration: Duration(milliseconds: 1500),
//         animationDuration: Duration(milliseconds: 1000),
//         nextScreen: Directionality(
//           // textDirection: TextDirection.rtl, child: AuthenticationScreen()),
//           textDirection: TextDirection.rtl,
//           child: OrdersPages(),
//         ),
//       ),
//     );
//   }
// }
//
// class OrdersPages extends StatefulWidget {
//   const OrdersPages({Key? key}) : super(key: key);
//
//   @override
//   State<OrdersPages> createState() => _OrdersPagesState();
// }
//
// class _OrdersPagesState extends State<OrdersPages> {
//   final OrderController orderController = Get.put(OrderController());
//
//   String selectedJalaliDate = '';
//   String selectedGregorianDate = '';
//
//   final TextEditingController titleController = TextEditingController();
//   final TextEditingController addressController = TextEditingController();
//   final TextEditingController NiyazNumberController = TextEditingController();
//   final TextEditingController phonenumberitController = TextEditingController();
//   final TextEditingController callnumberController = TextEditingController();
//
//   @override
//   void dispose() {
//     titleController.dispose();
//     addressController.dispose();
//     NiyazNumberController.dispose();
//     phonenumberitController.dispose();
//     callnumberController.dispose();
//     super.dispose();
//   }
//
//   @override
//   void setState(VoidCallback fn) {
//     super.setState(fn);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.blue,
//         title: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Row(
//               children: [
//
//                 IconButton(
//                   tooltip: 'به روز رسانی',
//                   onPressed: () {
//                     orderController.fetchAllOrdersRefresh();
//                   },
//                   icon: Icon(Icons.refresh, color: Colors.white),
//                 ),
//
//                 PopupMenuButton<String>(
//                   tooltip: 'مرتب سازی بر اثاث روند سفارش',
//                   onSelected: (filter) {
//                     orderController.fetchAllOrdersFilter(filter: filter);
//                   },
//                   itemBuilder: (context) =>
//                   [
//                     PopupMenuItem(
//                       value: 'winner="0.25"',
//                       child: Text('استعلام اول'),
//                     ),
//                     PopupMenuItem(
//                       value: 'winner="0.5"',
//                       child: Text('ارسال پیش فاکتور'),
//                     ),
//                     PopupMenuItem(
//                       value: 'winner="0.75"',
//                       child: Text('سفارشات برنده'),
//                     ),
//                     PopupMenuItem(
//                       value: 'winner="1"',
//                       child: Text('استعلام دوم'),
//                     ),
//                     PopupMenuItem(
//                       value: '',
//                       child: Text('تمام سفارشات'),
//                     ),
//                   ],
//                   icon: Icon(Icons.alt_route_sharp, color: Colors.white),
//                 ),
//
//               ],
//             ),
//
//             Text(
//               'کارشناسان خرید و فروش',
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 18,
//               ),
//             ),
//           ],
//         ),
//       ),
//       body: Center(
//         child: GetBuilder<OrderController>(
//           init: orderController,
//           builder: (controller) {
//             if (controller.isLoading) {
//               return CircularProgressIndicator();
//             } else if (controller.allOrders.isEmpty) {
//               return Text(
//                 'هیچ سفارشی یافت نشد.',
//                 style: TextStyle(fontSize: 25),
//               );
//             } else {
//               return ListView.builder(
//                 itemCount: controller.allOrders.length,
//                 itemBuilder: (context, index) {
//                   ProductB order = controller.allOrders[index];
//                   return Directionality(
//                     textDirection: TextDirection.rtl,
//                     child: OrderCards(
//                       order: order,
//                       orderController: orderController,
//                       index: index + 1,
//                     ),
//                   );
//                 },
//               );
//             }
//           },
//         ),
//       ),
//     );
//   }
// }
//
// class OrderCards extends StatefulWidget {
//   final ProductB order;
//   final int index;
//   final OrderController orderController;
//
//   OrderCards({Key? key,
//     required this.order,
//     required this.index,
//     required this.orderController})
//       : super(key: key);
//
//   late double _progressValue;
//
//   @override
//   State<OrderCards> createState() => _OrderCardsState();
// }
//
// class _OrderCardsState extends State<OrderCards> {
//   final Map<String, bool> _expansionStateA = {};
//
//   @override
//   Widget build(BuildContext context) {
//     // widget._progressValue = double.parse(widget.order.winner);
//     DateTime endDate = DateTime.parse(widget.order.datead);
//     Duration timeRemaining = endDate.difference(DateTime.now());
//     // String gregorianDateString = widget.order.created;
//
//     // تبدیل رشته به DateTime
//   //  DateTime gregorianDate = DateTime.parse(gregorianDateString);
//
//     // تبدیل تاریخ میلادی به تاریخ شمسی
//     // Jalali jalaliDate = Jalali.fromDateTime(gregorianDate);
//
//     // نمایش تاریخ شمسی به صورت رشته
//     // String persianDateString = jalaliDate.formatFullDate();
//     bool isExpired = timeRemaining.isNegative;
//
//     return Card(
//       margin: const EdgeInsets.all(8),
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 Row(
//                   children: [
//                     Text(
//                       'شماره سفارش ${widget.index.toString()}',
//                       style: TextStyle(fontWeight: FontWeight.bold),
//                     )
//                   ],
//                 ),
//                 Spacer(),
//               ],
//             ),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//
//                 Row(
//                   children: [
//                     Text('نام ارگان : '),
//                     Text(
//                       widget.order.title,
//                       style: const TextStyle(
//                           fontSize: 18, fontWeight: FontWeight.bold),
//                     ),
//                   ],
//                 ),
//                 // const SizedBox(height: 3),
//                 // Row(
//                 //   children: [
//                 //     Text('شماره نیاز : '),
//                 //     Row(
//                 //       children: [
//                 //         Text(
//                 //           widget.order.niyaz,
//                 //           style: const TextStyle(
//                 //             fontSize: 18,
//                 //             fontWeight: FontWeight.bold,
//                 //           ),
//                 //         ),
//                 //         IconButton(
//                 //           icon: const Icon(Icons.copy),
//                 //           onPressed: () {
//                 //             Clipboard.setData(
//                 //                 ClipboardData(text: widget.order.niyaz));
//                 //             ScaffoldMessenger.of(context).showSnackBar(
//                 //               const SnackBar(
//                 //                   content: Text('شماره نیاز شما ' + 'کپی شد ')),
//                 //             );
//                 //           },
//                 //         ),
//                 //       ],
//                 //     )
//                 //   ],
//                 // ),
//                 const SizedBox(height: 3),
//                 Row(
//                   children: [
//                     Text('شماره تماس ثابت  : '),
//                     Text(
//                       widget.order.days,
//                       style: const TextStyle(
//                           fontSize: 18, fontWeight: FontWeight.bold),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 3),
//                 Row(
//                   children: [
//                     Text('شماره تماس همراه IT  : '),
//                     Text(
//                       widget.order.dataclearing,
//                       style: const TextStyle(
//                           fontSize: 18, fontWeight: FontWeight.bold),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 3),
//                 Row(
//                   children: [
//                     Text('آدرس  : '),
//                     Text(
//                       widget.order.datecreated,
//                       style: const TextStyle(
//                           fontSize: 18, fontWeight: FontWeight.bold),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 3),
//                 Row(
//                   children: [
//                     Text(' نوع سفارش : '),
//                     Text(
//                       widget.order.title,
//                       style: const TextStyle(
//                           fontSize: 18, fontWeight: FontWeight.bold),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 3),
//
//                 const SizedBox(height: 3),
//                 Row(
//                   children: [
//                     Text(' تاریخ اعتبار سفارش : '),
//                     Text(
//                       widget.order.number,
//                       style: const TextStyle(
//                           fontSize: 18, fontWeight: FontWeight.bold),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 20),
//                 Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     const SizedBox(height: 3),
//
//                     SizedBox(height: 20),
//                     LinearProgressIndicator(
//                       value: widget._progressValue,
//                       minHeight: 20,
//                       backgroundColor: Colors.grey[300],
//                       valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
//                     ),
//                     SizedBox(height: 10),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         buildStepLabel(0.25, 'استعلام اول'),
//                         buildStepLabel(0.50, 'ارسال پیش فاکتور'),
//                         buildStepLabel(0.75, 'برنده شد'),
//                         buildStepLabel(1.0, 'استعلام دوم'),
//                       ],
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 16),
//               ],
//             ),
//             // ExpansionTileBorderItem(
//             //   textColor: Colors.black,
//             //   border: Border.all(
//             //     color: determineCollapsedBorderColor(widget.order.supplier),
//             //     // رنگ بوردر بر اساس محاسبات شما
//             //     width: 4, // ضخامت بوردر
//             //   ),
//             //   title: Column(
//             //     children: [
//             //       Text('محصولات'),
//             //     ],
//             //   ),
//             //   children: [
//             //     // ExpansionTileGroup(
//             //     //   spaceBetweenItem: 14,
//             //     //   toggleType: ToggleType.expandOnlyCurrent,
//             //     //   children: [
//             //     //     ...widget.order.listProductA.map((productA) {
//             //     //       int totalQuantityB = widget.order.listProductB
//             //     //           .where((productB) => productB.title == productA.title)
//             //     //           .fold(
//             //     //           0,
//             //     //               (sum, productB) =>
//             //     //           sum + int.parse(productB.number));
//             //     //
//             //     //       Color borderColor;
//             //     //       if (totalQuantityB > int.parse(productA.number)) {
//             //     //         borderColor = Colors.purple;
//             //     //       } else if (totalQuantityB < int.parse(productA.number)) {
//             //     //         borderColor = Colors.orange;
//             //     //       } else {
//             //     //         borderColor = Colors.green;
//             //     //       }
//             //     //
//             //     //       return ExpansionTileBorderItem(
//             //     //         textColor: Colors.black,
//             //     //         collapsedBackgroundColor: productA.unavailable
//             //     //             ? Colors.green[200]
//             //     //             : Colors.orange[200],
//             //     //         backgroundColor: productA.unavailable
//             //     //             ? Colors.green[200]
//             //     //             : Colors.orange[200],
//             //     //         expendedBorderColor: borderColor,
//             //     //         collapsedBorderColor: borderColor,
//             //     //         border: Border.all(
//             //     //           color: borderColor, // رنگ بوردر بر اساس محاسبات شما
//             //     //           width: 4, // ضخامت بوردر
//             //     //         ),
//             //     //         key: Key(productA.id),
//             //     //         initiallyExpanded:
//             //     //         _expansionStateA[productA.id] ?? false,
//             //     //         onExpansionChanged: (bool expanded) {
//             //     //           setState(() {
//             //     //             _expansionStateA[productA.id] = expanded;
//             //     //           });
//             //     //         },
//             //     //         title: Column(
//             //     //           crossAxisAlignment: CrossAxisAlignment.start,
//             //     //           children: [
//             //     //             Row(
//             //     //               children: [
//             //     //                 Row(
//             //     //                   mainAxisSize: MainAxisSize.max,
//             //     //                   mainAxisAlignment: MainAxisAlignment.start,
//             //     //                   children: [
//             //     //                     Card(
//             //     //                       child: Column(children: [
//             //     //                         IconButton(
//             //     //                           icon: const Icon(Icons.add),
//             //     //                           onPressed: () {
//             //     //                             widget.orderController
//             //     //                                 .fetchAllSuppliers();
//             //     //                             bool rezerv = false;
//             //     //                             _showAddProductDialogB(
//             //     //                                 context,
//             //     //                                 widget.order,
//             //     //                                 'B',
//             //     //                                 productA,
//             //     //                                 rezerv,
//             //     //                                 widget.orderController);
//             //     //                           },
//             //     //                         ),
//             //     //                       ]),
//             //     //                     ),
//             //     //                   ],
//             //     //                 ),
//             //     //                 Text(productA.title),
//             //     //               ],
//             //     //             ),
//             //     //             Row(
//             //     //               children: [
//             //     //                 Text(' گارانتی :  '),
//             //     //                 MultiSelectContainer(
//             //     //                   prefix: MultiSelectPrefix(
//             //     //                     selectedPrefix: const Padding(
//             //     //                       padding: EdgeInsets.only(right: 5),
//             //     //                       child: Icon(
//             //     //                         Icons.check,
//             //     //                         color: Colors.blue,
//             //     //                         size: 14,
//             //     //                       ),
//             //     //                     ),
//             //     //                     disabledPrefix: const Padding(
//             //     //                       padding: EdgeInsets.only(right: 5),
//             //     //                       child: Icon(
//             //     //                         Icons.do_disturb_alt_sharp,
//             //     //                         size: 14,
//             //     //                       ),
//             //     //                     ),
//             //     //                   ),
//             //     //                   items: productA.garranty.map((item) {
//             //     //                     return MultiSelectCard(
//             //     //                       value: item,
//             //     //                       label: item,
//             //     //                     );
//             //     //                   }).toList(),
//             //     //                   onChange: (allSelectedItems, selectedItem) {
//             //     //                     // handleSelectionChange(allSelectedItems, selectedItem);
//             //     //                   },
//             //     //                 ),
//             //     //               ],
//             //     //             ),
//             //     //             Row(
//             //     //               children: [
//             //     //                 const Text('تعداد: '),
//             //     //                 Text(productA.number),
//             //     //                 Spacer(),
//             //     //                 Text('عدم موجودی'),
//             //     //                 Switch(
//             //     //                   value: productA.unavailable,
//             //     //                   onChanged: (bool value) {
//             //     //                     if (value == true) {
//             //     //                       bool un = value;
//             //     //                       widget.orderController
//             //     //                           .updateProductADiscription(
//             //     //                           productA.id,
//             //     //                           productA.description,
//             //     //                           un);
//             //     //                     } else {
//             //     //                       showDialog(
//             //     //                         context: context,
//             //     //                         builder: (BuildContext context) {
//             //     //                           bool un = value;
//             //     //                           TextEditingController noteController =
//             //     //                           TextEditingController(
//             //     //                               text: productA.description);
//             //     //                           return AlertDialog(
//             //     //                             title: const Text('توضیح محصول'),
//             //     //                             content: TextField(
//             //     //                               controller: noteController,
//             //     //                               maxLines: 5,
//             //     //                               decoration: const InputDecoration(
//             //     //                                 border: OutlineInputBorder(),
//             //     //                                 labelText: 'توضیحات',
//             //     //                               ),
//             //     //                             ),
//             //     //                             actions: [
//             //     //                               TextButton(
//             //     //                                 onPressed: () {
//             //     //                                   Navigator.of(context).pop();
//             //     //                                 },
//             //     //                                 child: const Text('کنسل'),
//             //     //                               ),
//             //     //                               TextButton(
//             //     //                                 onPressed: () {
//             //     //                                   widget.orderController
//             //     //                                       .updateProductADiscription(
//             //     //                                       productA.id,
//             //     //                                       noteController.text,
//             //     //                                       un);
//             //     //                                   Navigator.of(context).pop();
//             //     //                                 },
//             //     //                                 child: const Text('تایید'),
//             //     //                               ),
//             //     //                             ],
//             //     //                           );
//             //     //                         },
//             //     //                       );
//             //     //                     }
//             //     //                   },
//             //     //                 ),
//             //     //               ],
//             //     //             ),
//             //     //             const SizedBox(height: 5),
//             //     //             Row(
//             //     //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             //     //               children: [
//             //     //                 Expanded(
//             //     //                   child: TextField(
//             //     //                     controller: TextEditingController(
//             //     //                         text: productA.purchaseprice
//             //     //                             .convertToPrice()),
//             //     //                     decoration: const InputDecoration(
//             //     //                         labelText: 'قیمت خرید'),
//             //     //                     keyboardType: TextInputType.number,
//             //     //                     inputFormatters: [
//             //     //                       FilteringTextInputFormatter.allow(
//             //     //                           RegExp(r'[0-9۰-۹]')),
//             //     //                       TextInputFormatter.withFunction(
//             //     //                             (oldValue, newValue) {
//             //     //                           String newText =
//             //     //                           convertToEnglishNumbers(
//             //     //                               newValue.text);
//             //     //                           return TextEditingValue(
//             //     //                             text: newText,
//             //     //                             selection: TextSelection.collapsed(
//             //     //                                 offset: newText.length),
//             //     //                           );
//             //     //                         },
//             //     //                       ),
//             //     //                     ],
//             //     //                     onTap: () {
//             //     //                       showDialog(
//             //     //                         context: context,
//             //     //                         builder: (BuildContext context) {
//             //     //                           return Directionality(
//             //     //                               textDirection: TextDirection.rtl,
//             //     //                               child: AlertDialog(
//             //     //                                 title: const Text(
//             //     //                                     'قیمت محصول استعلام'),
//             //     //                                 content: Container(
//             //     //                                     child: TextField(
//             //     //                                       controller:
//             //     //                                       TextEditingController(
//             //     //                                           text: productA
//             //     //                                               .purchaseprice
//             //     //                                               .convertToPrice()),
//             //     //                                       decoration:
//             //     //                                       const InputDecoration(
//             //     //                                           labelText:
//             //     //                                           'قیمت خرید'),
//             //     //                                       keyboardType:
//             //     //                                       TextInputType.number,
//             //     //                                       inputFormatters: [
//             //     //                                         FilteringTextInputFormatter
//             //     //                                             .allow(RegExp(
//             //     //                                             r'[0-9۰-۹]')),
//             //     //                                         TextInputFormatter
//             //     //                                             .withFunction(
//             //     //                                               (oldValue,
//             //     //                                               newValue) {
//             //     //                                             String newText =
//             //     //                                             convertToEnglishNumbers(
//             //     //                                                 newValue
//             //     //                                                     .text
//             //     //                                                     .convertToPrice());
//             //     //                                             return TextEditingValue(
//             //     //                                               text: newText,
//             //     //                                               selection: TextSelection
//             //     //                                                   .collapsed(
//             //     //                                                   offset: newText
//             //     //                                                       .length),
//             //     //                                             );
//             //     //                                           },
//             //     //                                         ),
//             //     //                                       ],
//             //     //
//             //     //                                       onChanged: (value) {
//             //     //                                         widget.orderController
//             //     //                                             .updateProductBPricepurch(
//             //     //                                             productA.id,
//             //     //                                             value);
//             //     //                                       },
//             //     //                                     ),
//             //     //                                     width: 200),
//             //     //                               ));
//             //     //                         },
//             //     //                       );
//             //     //                     },
//             //     //                   ),
//             //     //                 ),
//             //     //                 SizedBox(width: 20),
//             //     //               ],
//             //     //             ),
//             //     //             const SizedBox(height: 10),
//             //     //             Text('قیمت به حروف : ' +
//             //     //                 '${productA.purchaseprice.toWord()} ' +
//             //     //                 ' ریال'),
//             //     //             const SizedBox(height: 10),
//             //     //             Text('توضیحات محصول: ' + '${productA.description}'),
//             //     //           ],
//             //     //         ),
//             //     //         children: widget.order.listProductB
//             //     //             .where(
//             //     //                 (productB) => productB.title == productA.title)
//             //     //             .map((productB) {
//             //     //           DateTime endDatepro = DateTime.parse(productB.datead);
//             //     //           Duration timeRemainingpro =
//             //     //           endDatepro.difference(DateTime.now());
//             //     //           bool isExpiredpro = timeRemainingpro.isNegative;
//             //     //           return Card(
//             //     //             margin: const EdgeInsets.symmetric(
//             //     //                 vertical: 4.0, horizontal: 16.0),
//             //     //             child: Container(
//             //     //               decoration: BoxDecoration(
//             //     //                 color: productB.okbuy
//             //     //                     ? Colors.green[100]
//             //     //                     : Colors.yellow[200],
//             //     //                 // تغییر رنگ پس‌زمینه بر اساس productB.okbuy
//             //     //                 border: Border.all(
//             //     //                   color: productB.hurry
//             //     //                       ? Colors.blue
//             //     //                       : Colors.grey,
//             //     //                   // تغییر رنگ بوردر بر اساس productB.hurry
//             //     //                   width: 4, // ضخامت بوردر
//             //     //                 ),
//             //     //                 borderRadius:
//             //     //                 BorderRadius.circular(8.0), // شکل گرد بوردر
//             //     //               ),
//             //     //               child: Padding(
//             //     //                 padding: const EdgeInsets.all(8.0),
//             //     //                 child: Column(
//             //     //                   crossAxisAlignment:
//             //     //                   CrossAxisAlignment.stretch,
//             //     //                   children: [
//             //     //                     Center(
//             //     //                       child: Directionality(
//             //     //                         textDirection: TextDirection.ltr,
//             //     //                         child: isExpiredpro
//             //     //                             ? Text(
//             //     //                           'اعتبار سفارش به اتمام رسید',
//             //     //                           style: TextStyle(
//             //     //                               fontSize: 20,
//             //     //                               fontWeight: FontWeight.bold,
//             //     //                               color: Colors.red),
//             //     //                         )
//             //     //                             : SlideCountdownSeparated(
//             //     //                           duration: timeRemainingpro,
//             //     //                           slideDirection:
//             //     //                           SlideDirection.down,
//             //     //                           durationTitle:
//             //     //                           DurationTitle.arShort(),
//             //     //                           separator: "<>",
//             //     //                           style: TextStyle(
//             //     //                               fontSize: 20,
//             //     //                               fontWeight:
//             //     //                               FontWeight.bold),
//             //     //                         ),
//             //     //                       ),
//             //     //                     ),
//             //     //                     Row(
//             //     //                       children: [
//             //     //                         Card(
//             //     //                           child: Column(children: [
//             //     //                             IconButton(
//             //     //                               icon: const Icon(Icons.mode_edit),
//             //     //                               onPressed: () async {
//             //     //                                 // نمایش پروگرس بار به مدت 1 ثانیه
//             //     //                                 showDialog(
//             //     //                                   context: context,
//             //     //                                   barrierDismissible: false,
//             //     //                                   builder: (context) {
//             //     //                                     return Center(
//             //     //                                       child: CircularProgressIndicator(),
//             //     //                                     );
//             //     //                                   },
//             //     //                                 );
//             //     //
//             //     //                                 // تاخیر یک ثانیه‌ای
//             //     //                                 await Future.delayed(Duration(seconds: 1));
//             //     //                                 await widget.orderController.fetchSupplierById(productB.supplier);
//             //     //
//             //     //                                 Navigator.of(context).pop(); // Close the progress indicator
//             //     //
//             //     //
//             //     //                                 showDialog(
//             //     //                                   context: context,
//             //     //                                   builder: (context) =>
//             //     //                                       ProductDetailsDialogB(
//             //     //                                         productType:
//             //     //                                         'رزرو محصول برای استعلام ',
//             //     //                                         productTitle:
//             //     //                                         productB.title,
//             //     //                                         productId:
//             //     //                                         productB.id,
//             //     //                                         productPrice: productB
//             //     //                                             .purchaseprice,
//             //     //                                         supplier:
//             //     //                                         productB.supplier,
//             //     //
//             //     //
//             //     //                                         supplierId:
//             //     //                                         productB.supplier,
//             //     //                                         days: productB.days,
//             //     //                                         dataclearing: productB
//             //     //                                             .dataclearing,
//             //     //                                         datecreated: productB
//             //     //                                             .datecreated,
//             //     //                                         number:
//             //     //                                         productB.number,
//             //     //                                         productB: productB,
//             //     //                                         controller: widget
//             //     //                                             .orderController,
//             //     //                                         listb: widget.order.listProductB,
//             //     //                                         proA: productA,
//             //     //
//             //     //                                       ),
//             //     //                                 );
//             //     //                               },
//             //     //                             ),
//             //     //                           ]),
//             //     //                         ),
//             //     //                         Text('${productB.title} '),
//             //     //                       ],
//             //     //                     ),
//             //     //                     Row(
//             //     //                       children: [
//             //     //                         const Text('تعداد: '),
//             //     //                         Text(productB.number),
//             //     //                         Spacer(),
//             //     //                         Text(productB.hurry
//             //     //                             ? 'فورس'
//             //     //                             : 'فروش خاموش'),
//             //     //                         Switch(
//             //     //                           value: productB.hurry,
//             //     //                           onChanged: (bool value) {
//             //     //                             widget.orderController.updateProductBhurry(
//             //     //                                 productB.id, value);
//             //     //                           },
//             //     //                         ),
//             //     //                         Text(productB.okbuy ? 'خرید' : 'رزرو'),
//             //     //                         Switch(
//             //     //                           value: productB.okbuy,
//             //     //                           onChanged: (bool value) {
//             //     //                             widget.orderController.updateProductBokbuy(
//             //     //                                 productB.id, value);
//             //     //                           },
//             //     //                         ),
//             //     //                       ],
//             //     //                     ),
//             //     //                     Column(
//             //     //                       children: [
//             //     //                         Row(
//             //     //                           children: [
//             //     //                             const SizedBox(width: 20),
//             //     //                             Expanded(
//             //     //                               child: TextField(
//             //     //                                 controller:
//             //     //                                 TextEditingController(
//             //     //                                     text: productB
//             //     //                                         .purchaseprice
//             //     //                                         .convertToPrice()),
//             //     //                                 decoration:
//             //     //                                 const InputDecoration(
//             //     //                                   border: OutlineInputBorder(),
//             //     //                                   labelText: 'قیمت خرید',
//             //     //                                 ),
//             //     //                               ),
//             //     //                             ),
//             //     //                           ],
//             //     //                         ),
//             //     //                         Row(
//             //     //                           children: [
//             //     //                             Expanded(
//             //     //                               child: Text('\n' +
//             //     //                                   ' جمع مبلغ کل به حروف : ' +
//             //     //                                   productB.purchaseprice
//             //     //                                       .toWord() +
//             //     //                                   ' ریال '),
//             //     //                             ),
//             //     //                           ],
//             //     //                         ),
//             //     //                         Row(
//             //     //                           children: [
//             //     //                             Spacer(),
//             //     //                             Row(
//             //     //                               children: [
//             //     //                                 Text('نوع سفارش : '),
//             //     //                                 Text(productB.official
//             //     //                                     ? 'رسمی'
//             //     //                                     : 'غیر رسمی'),
//             //     //                               ],
//             //     //                             )
//             //     //                           ],
//             //     //                         ),
//             //     //                       ],
//             //     //                     ),
//             //     //                   ],
//             //     //                 ),
//             //     //               ),
//             //     //             ),
//             //     //           );
//             //     //         }).toList(),
//             //     //       );
//             //     //     }).toList(),
//             //     //   ],
//             //     // ),
//             //   ],
//             // ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Color determineCollapsedBorderColor(List<ProductB> listProductA) {
//     // بررسی خالی بودن لیست
//     if (listProductA.isEmpty) {
//       return Colors.grey;
//     }
//
//     // بررسی محصولات برای داشتن قیمت خرید معتبر
//     for (var productA in listProductA) {
//       if (productA.purchaseprice == null ||
//           productA.purchaseprice.isEmpty ||
//           productA.purchaseprice == '0' ||
//           productA.purchaseprice == ' ' ||
//           productA.purchaseprice == 'N/A') {
//         return Colors.orange;
//       }
//     }
//
//     // اگر همه محصولات قیمت خرید معتبر داشتند، رنگ سبز برگردان
//     return Colors.green;
//   }
//
//   Widget buildStepIndicator(double value, String text, String winner,
//       String id) {
//     return Column(
//       children: [],
//     );
//   }
//
//   Widget buildStepLabel(double value, String text) {
//     return Column(
//       children: [
//         Icon(
//           Icons.circle_notifications,
//           color: widget._progressValue >= value ? Colors.green : Colors.grey,
//           size: 20,
//         ),
//         Text(
//           text,
//           style: TextStyle(fontSize: 12),
//         ),
//       ],
//     );
//   }
//
//   // void _showAddProductDialogB(BuildContext context,
//   //     ProductB order,
//   //     String productType,
//   //
//   //     bool rezerv,
//   //     OrderController orderController) {
//   //   late String futureDateGregorianString;
//   //   String searchValue = '';
//   //   bool official = false;
//   //   bool hurry = false;
//   //   Future<List<String>> _fetchSuggestions(String searchValue) async {
//   //     await Future.delayed(const Duration(milliseconds: 750));
//   //     return orderController.suppliers
//   //         .where((supplier) =>
//   //         supplier['companyname']!
//   //             .toLowerCase()
//   //             .contains(searchValue.toLowerCase()))
//   //         .map((supplier) => supplier['companyname']!)
//   //         .toList();
//   //   }
//   //
//   //   int storedDays = 0;
//   //   late String daysa;
//   //   Jalali currentDate = Jalali.now();
//   //   Jalali futureDate = currentDate.addDays(storedDays);
//   //
//   //   final TextEditingController productTitleController =
//   //   TextEditingController(text: productA.title);
//   //   final TextEditingController productPriceController = TextEditingController(
//   //       text: productA.purchaseprice
//   //           .convertToPrice()); // Use convertToPrice to display price with decimals
//   //   final TextEditingController productNumberController =
//   //   TextEditingController();
//   //   final TextEditingController controller =
//   //   TextEditingController(text: storedDays.toString());
//   //
//   //   // Define variables to hold supplier details
//   //   String selectedSupplierCompanyName = '';
//   //   String selectedSupplierPhoneNumber = '';
//   //   String selectedSupplierMobileNumber = '';
//   //   String selectedSupplierAddress = '';
//   //   String selectedSupplierLocation = '';
//   //   String selectedSupplierId = ''; // New variable for supplier id
//   //
//   //   showDialog(
//   //     context: context,
//   //     builder: (context) =>
//   //         StatefulBuilder(
//   //           builder: (context, setState) =>
//   //               AlertDialog(
//   //                 title: Row(children: [
//   //                   Text('${productA.title}'),
//   //                   Text(' رزرو محصول  '),
//   //                 ]),
//   //                 content: SingleChildScrollView(
//   //                   child: Column(
//   //                     mainAxisSize: MainAxisSize.min,
//   //                     children: [
//   //                       FutureBuilder<List<String>>(
//   //                         future: _fetchSuggestions(searchValue),
//   //                         builder: (context, snapshot) {
//   //                           if (snapshot.connectionState ==
//   //                               ConnectionState.waiting) {
//   //                             return const CircularProgressIndicator();
//   //                           }
//   //                           if (!snapshot.hasData || snapshot.data!.isEmpty) {
//   //                             return const Text('فروشنده ای یافت نشد');
//   //                           }
//   //                           return SearchField(
//   //                             suggestions: snapshot.data!
//   //                                 .map((e) => SearchFieldListItem(e))
//   //                                 .toList(),
//   //                             suggestionState: Suggestion.expand,
//   //                             textInputAction: TextInputAction.next,
//   //                             hint: 'جستجوی فروشنده',
//   //                             searchStyle: TextStyle(
//   //                               fontSize: 18,
//   //                               color: Colors.black.withOpacity(0.8),
//   //                             ),
//   //                             searchInputDecoration: InputDecoration(
//   //                               focusedBorder: OutlineInputBorder(
//   //                                 borderSide:
//   //                                 BorderSide(
//   //                                     color: Colors.black.withOpacity(0.8)),
//   //                               ),
//   //                               border: const OutlineInputBorder(
//   //                                 borderSide: BorderSide(color: Colors.red),
//   //                               ),
//   //                             ),
//   //                             maxSuggestionsInViewPort: 6,
//   //                             itemHeight: 50,
//   //                             onSuggestionTap: (x) {
//   //                               final supplier = orderController.suppliers
//   //                                   .firstWhere(
//   //                                       (element) =>
//   //                                   element['companyname'] == x.searchKey);
//   //
//   //                               // Update the supplier details
//   //                               setState(() {
//   //                                 selectedSupplierCompanyName =
//   //                                 supplier['companyname']!;
//   //                                 selectedSupplierPhoneNumber =
//   //                                 supplier['phonenumber']!;
//   //                                 selectedSupplierMobileNumber =
//   //                                 supplier['mobilenumber']!;
//   //                                 selectedSupplierAddress =
//   //                                 supplier['address']!;
//   //                                 selectedSupplierLocation =
//   //                                 supplier['location']!;
//   //                                 selectedSupplierId =
//   //                                 supplier['id']!; // Update supplier id
//   //                               });
//   //                             },
//   //                           );
//   //                         },
//   //                       ),
//   //                       TextFormField(
//   //                         readOnly: true,
//   //                         controller: productTitleController,
//   //                         decoration: const InputDecoration(
//   //                             labelText: 'نام محصول'),
//   //                       ),
//   //                       const SizedBox(height: 10),
//   //                       TextFormField(
//   //                         controller: productPriceController,
//   //                         decoration: const InputDecoration(
//   //                             labelText: 'قیمت خرید'),
//   //                         keyboardType: TextInputType.number,
//   //                         inputFormatters: [
//   //                           FilteringTextInputFormatter.digitsOnly,
//   //                           PriceInputFormatter(),
//   //                           // استفاده از فرمت‌کننده سفارشی
//   //                         ],
//   //                       ),
//   //                       const SizedBox(height: 10),
//   //                       TextFormField(
//   //                         controller: productNumberController,
//   //                         keyboardType: TextInputType.number,
//   //                         decoration: const InputDecoration(labelText: 'تعداد'),
//   //                       ),
//   //                       const SizedBox(height: 10),
//   //                       Column(
//   //                         mainAxisSize: MainAxisSize.min,
//   //                         children: [
//   //                           Row(
//   //                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//   //                             children: [
//   //                               const Text('امروز: '),
//   //                               Text(currentDate.formatCompactDateCustom()),
//   //                             ],
//   //                           ),
//   //                           TextField(
//   //                             controller: controller,
//   //                             keyboardType: TextInputType.number,
//   //                             decoration: const InputDecoration(
//   //                                 labelText: 'چند روز تا تسویه را وارد کنید'),
//   //                             onChanged: (value) {
//   //                               setState(() {
//   //                                 int days = int.tryParse(value) ?? storedDays;
//   //                                 futureDate = currentDate.addDays(days);
//   //
//   //                                 Jalali futureDatee = currentDate.addDays(
//   //                                     days);
//   //
//   //                                 // تبدیل تاریخ شمسی به میلادی
//   //                                 Gregorian futureDateGregorian =
//   //                                 futureDatee.toGregorian();
//   //
//   //                                 // ساخت DateTime میلادی با ساعت 23:59:59
//   //                                 DateTime futureDateTime = DateTime(
//   //                                   futureDateGregorian.year,
//   //                                   futureDateGregorian.month,
//   //                                   futureDateGregorian.day,
//   //                                   23,
//   //                                   59,
//   //                                   59,
//   //                                 );
//   //
//   //                                 // تبدیل به رشته برای نمایش به صورت ISO 8601
//   //                                 futureDateGregorianString =
//   //                                     futureDateTime.toIso8601String();
//   //
//   //                                 print('iiioooii');
//   //                                 print('${futureDate}');
//   //                                 daysa = days.toString();
//   //                               });
//   //                             },
//   //                           ),
//   //                           Row(
//   //                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//   //                             children: [
//   //                               const Text('تاریخ تسویه: '),
//   //                               Text(controller.text.isEmpty
//   //                                   ? 'چند روز تا تسویه را وارد کنید'
//   //                                   : '${futureDate.year}-${futureDate.month
//   //                                   .toString().padLeft(2, '0')}-${futureDate
//   //                                   .day.toString().padLeft(2, '0')}'),
//   //                             ],
//   //                           ),
//   //                         ],
//   //                       ),
//   //                       Row(
//   //                         children: [
//   //                           Text('رزرو و خرید'),
//   //                           Switch(
//   //                             value: rezerv,
//   //                             onChanged: (value) {
//   //                               setState(() {
//   //                                 rezerv = value;
//   //                               });
//   //                             },
//   //                           ),
//   //                           Spacer(),
//   //                           Text('رسمی و غیر رسمی'),
//   //                           Switch(
//   //                             value: official,
//   //                             onChanged: (value) {
//   //                               setState(() {
//   //                                 official = value;
//   //                               });
//   //                             },
//   //                           ),
//   //                           Spacer(),
//   //                           Text('عجله ای'),
//   //                           Switch(
//   //                             value: hurry,
//   //                             onChanged: (value) {
//   //                               setState(() {
//   //                                 hurry = value;
//   //                               });
//   //                             },
//   //                           )
//   //                         ],
//   //                       ),
//   //                       const SizedBox(height: 10),
//   //                       //      Text('Company id: $selectedSupplierId'),
//   //                       Text('نام فروشنده : $selectedSupplierCompanyName'),
//   //                       Text('ثابت فروشنده : $selectedSupplierPhoneNumber'),
//   //                       Text('موبایل فروشنده : $selectedSupplierMobileNumber'),
//   //                       Text('آدرس : $selectedSupplierAddress'),
//   //                       Text('لوکیشن : $selectedSupplierLocation'),
//   //                     ],
//   //                   ),
//   //                 ),
//   //                 actions: [
//   //                   TextButton(
//   //                     onPressed: () => Navigator.of(context).pop(),
//   //                     child: const Text('کنسل'),
//   //                   ),
//   //                   ElevatedButton(
//   //                     onPressed: () async {
//   //                       String productTitle = productTitleController.text;
//   //                       String productPrice = productPriceController.text
//   //                           .convertToPrice()
//   //                           .replaceAll(
//   //                           ',', ''); // Convert to integer without commas
//   //                       String productNumber = productNumberController.text;
//   //                       if (productTitle.isNotEmpty &&
//   //                           productPrice.isNotEmpty &&
//   //                           productNumber.isNotEmpty &&
//   //                           selectedSupplierId != '') {
//   //                         // نمایش Progress Indicator
//   //                         showDialog(
//   //                           context: context,
//   //                           barrierColor: Colors.transparent,
//   //                           builder: (BuildContext context) {
//   //                             return Center(child: CircularProgressIndicator());
//   //                           },
//   //                         );
//   //
//   //                         if (productType == 'B') {
//   //                           await orderController.addProductToB(
//   //                               order.id,
//   //                               productTitle,
//   //                               productPrice
//   //                                   .split('.')
//   //                                   .first,
//   //                               // Remove decimals before saving
//   //                               selectedSupplierId,
//   //                               daysa,
//   //                               '${currentDate.year}-${currentDate.month
//   //                                   .toString().padLeft(2, '0')}-${currentDate
//   //                                   .day.toString().padLeft(2, '0')}',
//   //                               '${futureDate.year}-${futureDate.month
//   //                                   .toString().padLeft(2, '0')}-${futureDate
//   //                                   .day.toString().padLeft(2, '0')}',
//   //                               productNumber,
//   //                               rezerv,
//   //                               official,
//   //                               hurry,
//   //                               futureDateGregorianString
//   //                               ,
//   //                               widget.order.listProductB,
//   //                               productA
//   //                           );
//   //                         }
//   //                         // بستن Progress Indicator
//   //                         Navigator.of(context).pop();
//   //                         Navigator.of(context).pop();
//   //
//   //                         ScaffoldMessenger.of(context).showSnackBar(
//   //                             const SnackBar(
//   //                               content: Text('محصول با موفقیت اضافه شد'),
//   //                             ));
//   //                       } else {
//   //                         ScaffoldMessenger.of(context).showSnackBar(
//   //                             const SnackBar(
//   //                               content: Text('لطفا اطلاعات رو کامل کنید'),
//   //                             ));
//   //                       }
//   //                     },
//   //                     child: const Text('ثبت سفارش محصول'),
//   //                   ),
//   //                   // ElevatedButton(
//   //                   //   onPressed: () {
//   //                   //     String productTitle = productTitleController.text;
//   //                   //     String productPrice = parsePrice(productPriceController.text);
//   //                   //     // Convert to integer without commas
//   //                   //     String productNumber = productNumberController.text;
//   //                   //     if (productTitle.isNotEmpty &&
//   //                   //         productPrice.isNotEmpty &&
//   //                   //         productNumber.isNotEmpty &&
//   //                   //         selectedSupplierId != '') {
//   //                   //       if (productType == 'B') {
//   //                   //         orderController.addProductToB(
//   //                   //             order.id,
//   //                   //             productTitle,
//   //                   //             productPrice.split('.').first,
//   //                   //             // Remove decimals before saving
//   //                   //             selectedSupplierId,
//   //                   //             daysa,
//   //                   //             '${currentDate.year}-${currentDate.month.toString().padLeft(2, '0')}-${currentDate.day.toString().padLeft(2, '0')}',
//   //                   //             '${futureDate.year}-${futureDate.month.toString().padLeft(2, '0')}-${futureDate.day.toString().padLeft(2, '0')}',
//   //                   //             productNumber,
//   //                   //             rezerv,
//   //                   //             official,
//   //                   //             hurry,
//   //                   //             futureDateGregorianString);
//   //                   //       }
//   //                   //       Navigator.of(context).pop();
//   //                   //     } else {
//   //                   //       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//   //                   //         content: Text('لطفا اطلاعات رو کامل کنید'),
//   //                   //       ));
//   //                   //     }
//   //                   //   },
//   //                   //   child: const Text('ثبت سفارش محصول'),
//   //                   // ),
//   //                 ],
//   //               ),
//   //         ),
//   //   );
//   // }
// }
// //
// // extension JalaliExtensionCustom on Jalali {
// //   String formatCompactDateCustom() {
// //     String month = this.month.toString().padLeft(2, '0');
// //     return '${this.year}/$month/${this.day.toString().padLeft(2, '0')}';
// //   }
// // }
// //
// // class ProductDetailsDialogB extends StatefulWidget {
// //   final String productId;
// //   final String productType;
// //   final String productTitle;
// //   final String productPrice;
// //   final String supplierId;
// //   final String supplier;
// //   final ProductA proA;
// //   final String days;
// //   final String dataclearing;
// //   final String datecreated;
// //   final String number;
// //   final ProductB productB;
// //   final OrderController controller;
// //   final List<ProductB> listb;
// //
// //   const ProductDetailsDialogB({
// //     Key? key,
// //     required this.productId,
// //     required this.productType,
// //     required this.productTitle,
// //     required this.productPrice,
// //     required this.supplierId,
// //     required this.supplier,
// //     required this.days,
// //     required this.proA,
// //     required this.dataclearing,
// //     required this.datecreated,
// //     required this.number,
// //     required this.listb,
// //     required this.productB, required this.controller,
// //   }) : super(key: key);
// //
// //   @override
// //   _ProductDetailsDialogBState createState() => _ProductDetailsDialogBState();
// // }
// //
// // class _ProductDetailsDialogBState extends State<ProductDetailsDialogB> {
// //   late TextEditingController titleController;
// //   late TextEditingController priceController;
// //   late TextEditingController numberController;
// //   late TextEditingController daysController;
// //   late TextEditingController dateCreatedController;
// //   late TextEditingController dateClearingController;
// //   String? currentDate;
// //   String? futureDate;
// //   late String futureDateGregorianStringg;
// //
// //   late bool rezerv;
// //   late bool official;
// //   late bool hurry;
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     titleController = TextEditingController(text: widget.productTitle);
// //     priceController =
// //         TextEditingController(text: widget.productPrice.convertToPrice());
// //     numberController = TextEditingController(text: widget.number);
// //     daysController = TextEditingController(text: widget.days);
// //     dateCreatedController = TextEditingController(text: widget.datecreated);
// //     dateClearingController = TextEditingController(text: widget.dataclearing);
// //     rezerv = widget.productB.okbuy;
// //     official = widget.productB.official;
// //     hurry = widget.productB.hurry;
// //     currentDate = widget.datecreated;
// //     futureDate = widget.dataclearing;
// //
// //     set(widget.days);
// //   }
// //
// //   @override
// //   void dispose() {
// //     titleController.dispose();
// //     priceController.dispose();
// //     numberController.dispose();
// //     daysController.dispose();
// //     dateCreatedController.dispose();
// //     dateClearingController.dispose();
// //     super.dispose();
// //   }
// //
// //   void set(String days) {
// //     int numDays = int.tryParse(days) ?? int.parse(widget.days);
// //     currentDate = _convertToPersian(DateTime.now());
// //     futureDate = _convertToPersian(DateTime.now().add(Duration(days: numDays)));
// //     dateCreatedController.text = currentDate!;
// //     dateClearingController.text = futureDate!;
// //     Jalali currentDatee = Jalali.now();
// //     Jalali futureDatee =
// //     currentDatee.addDays(int.tryParse(days) ?? int.parse(widget.days));
// //
// //     // تبدیل تاریخ شمسی به میلادی
// //     Gregorian futureDateGregorian = futureDatee.toGregorian();
// //
// //     // ساخت DateTime میلادی با ساعت 23:59:59
// //     DateTime futureDateTime = DateTime(
// //       futureDateGregorian.year,
// //       futureDateGregorian.month,
// //       futureDateGregorian.day,
// //       23,
// //       59,
// //       59,
// //     );
// //
// //     // تبدیل به رشته برای نمایش به صورت ISO 8601
// //     futureDateGregorianStringg = futureDateTime.toIso8601String();
// //   }
// //
// //   void _updateDates(String days) {
// //     setState(() {
// //       int numDays = int.tryParse(days) ?? int.parse(widget.days);
// //       currentDate = _convertToPersian(DateTime.now());
// //       futureDate =
// //           _convertToPersian(DateTime.now().add(Duration(days: numDays)));
// //       dateCreatedController.text = currentDate!;
// //       dateClearingController.text = futureDate!;
// //       Jalali currentDatee = Jalali.now();
// //       Jalali futureDatee =
// //       currentDatee.addDays(int.tryParse(days) ?? int.parse(widget.days));
// //
// //       // تبدیل تاریخ شمسی به میلادی
// //       Gregorian futureDateGregorian = futureDatee.toGregorian();
// //
// //       // ساخت DateTime میلادی با ساعت 23:59:59
// //       DateTime futureDateTime = DateTime(
// //         futureDateGregorian.year,
// //         futureDateGregorian.month,
// //         futureDateGregorian.day,
// //         23,
// //         59,
// //         59,
// //       );
// //
// //       // تبدیل به رشته برای نمایش به صورت ISO 8601
// //       futureDateGregorianStringg = futureDateTime.toIso8601String();
// //     });
// //   }
// //
// //   String _convertToPersian(DateTime dateTime) {
// //     final jalali = Jalali.fromDateTime(dateTime);
// //     // فرمت کردن ماه به صورت عدد با دو رقم و در صورت لزوم افزودن صفر به ابتدای عدد
// //     final formattedMonth = jalali.month.toString().padLeft(2, '0');
// //     return '${jalali.year}-$formattedMonth-${jalali.day}';
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     final supplier = widget.controller.supplierProduct;
// //
// //     if (supplier == null) {
// //       return AlertDialog(
// //         title: Text('خطا'),
// //         content: Text('اطلاعات فروشنده موجود نیست.'),
// //         actions: [
// //           TextButton(
// //             child: Text('بستن'),
// //             onPressed: () {
// //               Navigator.of(context).pop();
// //             },
// //           ),
// //         ],
// //       );
// //     }
// //     return Directionality(
// //         textDirection: TextDirection.rtl,
// //         child: AlertDialog(
// //           title: Text('ویرایش محصول : ' + titleController.text),
// //           content: SingleChildScrollView(
// //             child: Column(
// //               mainAxisSize: MainAxisSize.min,
// //               children: [
// //                 TextFormField(
// //                   readOnly: true,
// //                   controller: titleController,
// //                   decoration: const InputDecoration(labelText: 'نام محصول'),
// //                 ),
// //                 TextFormField(
// //                   controller: priceController,
// //                   decoration:
// //                   const InputDecoration(labelText: 'قیمت به ریال'),
// //                   keyboardType: TextInputType.number,
// //                   inputFormatters: [
// //                     FilteringTextInputFormatter.digitsOnly,
// //                     PriceInputFormatter(), // استفاده از فرمت‌کننده سفارشی
// //                   ],
// //                 ),
// //                 TextFormField(
// //                   controller: numberController,
// //                   decoration: const InputDecoration(labelText: 'تعداد'),
// //                 ),
// //                 TextFormField(
// //                   controller: dateCreatedController,
// //                   decoration: const InputDecoration(labelText: 'تاریخ ثبت'),
// //                   readOnly: true,
// //                 ),
// //                 TextFormField(
// //                   controller: TextEditingController(text: currentDate),
// //                   decoration: const InputDecoration(labelText: 'امروز'),
// //                   readOnly: true,
// //                 ),
// //                 TextField(
// //                   controller: daysController,
// //                   keyboardType: TextInputType.number,
// //                   decoration: const InputDecoration(
// //                       labelText: 'چند روز تا تسویه ؟'),
// //                   onChanged: _updateDates,
// //                 ),
// //                 TextFormField(
// //                   controller: dateClearingController,
// //                   decoration:
// //                   const InputDecoration(labelText: 'تاریخ تسویه'),
// //                   readOnly: true,
// //                 ),
// //                 Row(
// //                   children: [
// //                     Text(rezerv ? 'خرید' : 'رزرو'),
// //                     Switch(
// //                       value: rezerv,
// //                       onChanged: (value) {
// //                         setState(() {
// //                           rezerv = value;
// //                         });
// //                       },
// //                     ),
// //                     Spacer(),
// //                     Text(official ? 'رسمی' : 'غیر رسمی'),
// //                     Switch(
// //                       value: official,
// //                       onChanged: (value) {
// //                         setState(() {
// //                           official = value;
// //                         });
// //                       },
// //                     ),
// //                     Spacer(),
// //                     Text(hurry ? 'فورس' : 'فروش خاموش'),
// //                     Switch(
// //                       value: hurry,
// //                       onChanged: (value) {
// //                         setState(() {
// //                           hurry = value;
// //                         });
// //                       },
// //                     )
// //                   ],
// //                 ),
// //                 Text('برند فروشنده : ${supplier.companyname}'),
// //                 Text('ثابت فروشنده : ${supplier.phonenumber}'),
// //                 Text('موبایل فروشنده : ${supplier.mobilenumber}'),
// //                 Text('آدرس فروشنده : ${supplier.address}'),
// //                 Text('لوکیشن : ${supplier.location}'),
// //               ],
// //             ),
// //           ),
// //           actions: [
// //             TextButton(
// //               child: const Text('کنسل'),
// //               onPressed: () {
// //                 Navigator.of(context).pop();
// //               },
// //             ),
// //             TextButton(
// //               child: const Text('حذف', style: TextStyle(color: Colors.red)),
// //               onPressed: () async {
// //                 showDialog(
// //                   context: context,
// //                   barrierColor: Colors.transparent,
// //                   builder: (BuildContext context) {
// //                     return Center(child: CircularProgressIndicator());
// //                   },
// //                 );
// //
// //                 try {
// //                   await widget.controller.deleteProductB(widget.productId,widget.listb,widget.productB.title,widget.proA);
// //
// //                   Navigator.of(context).pop(); // Close the progress dialog
// //                   Navigator.of(context).pop(); // Close the current dialog
// //                   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
// //                     content: Text('محصول با موفقیت حذف شد'),
// //                   ));
// //                 } catch (error) {
// //                   Navigator.of(context).pop(); // Close the progress dialog
// //                   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
// //                     content: Text('خطا در حذف محصول: $error'),
// //                   ));
// //                 }
// //               },
// //             ),
// //             TextButton(
// //               child: const Text('به روز رسانی'),
// //               onPressed: () async {
// //                 showDialog(
// //                   context: context,
// //                   barrierColor: Colors.transparent,
// //                   builder: (BuildContext context) {
// //                     return Center(child: CircularProgressIndicator());
// //                   },
// //                 );
// //
// //                 final newTitle = titleController.text;
// //                 String newPrice =
// //                 convertToEnglishNumbers(priceController.text);
// //                 newPrice = parsePrice(
// //                     newPrice); // حذف جداکننده‌ها قبل از ذخیره‌سازی
// //                 final numberPrice =
// //                 convertToEnglishNumbers(numberController.text);
// //
// //                 if (newTitle.isNotEmpty &&
// //                     newPrice.isNotEmpty &&
// //                     daysController.text.isNotEmpty) {
// //                   try {
// //                     await widget.controller.updateProductB(
// //                         widget.productId,
// //                         newTitle,
// //                         newPrice,
// //                         daysController.text,
// //                         dateCreatedController.text,
// //                         dateClearingController.text,
// //                         numberPrice,
// //                         rezerv,
// //                         hurry,
// //                         official,
// //                         futureDateGregorianStringg,
// //                         widget.listb,
// //                         widget.proA
// //                     );
// //
// //                     Navigator.of(context)
// //                         .pop(); // Close the progress dialog
// //                     Navigator.of(context).pop(); // Close the current dialog
// //                     ScaffoldMessenger.of(context)
// //                         .showSnackBar(const SnackBar(
// //                       content: Text('محصول با موفقیت ویرایش شد'),
// //                     ));
// //                   } catch (error) {
// //                     Navigator.of(context)
// //                         .pop(); // Close the progress dialog
// //                     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
// //                       content: Text('خطا در به روز رسانی محصول: $error'),
// //                     ));
// //                   }
// //                 } else {
// //                   Navigator.of(context).pop(); // Close the progress dialog
// //                   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
// //                     content:
// //                     Text('لطفا تمام اطلاعات به شکل صحیح وارد کنید'),
// //                   ));
// //                 }
// //               },
// //             ),
// //           ],
// //         ));
// //   }
// // }

//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import 'package:receive_the_product/Getx/Drawer/MyDrawer.dart';
// import 'package:receive_the_product/Getx/PagesOrderProduct/orderproduct_b.dart';
//
// // سایر ایمپورت‌ها...
//
// class OrderPage extends StatefulWidget {
//   @override
//   _OrderPageState createState() => _OrderPageState();
// }
//
// class _OrderPageState extends State<OrderPage> {
//   final OrderControllerProduct _orderController = Get.put(OrderControllerProduct());
//
//   @override
//   void initState() {
//     super.initState();
//   ini();
//
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Orders'),
//         actions: [
//           IconButton(
//             tooltip: 'به روز رسانی',
//             onPressed: () {
//               _orderController.fetchAllOrdersRefresh();
//             },
//             icon: Icon(Icons.refresh, color: Colors.white),
//           ),
//           IconButton(
//             icon: Icon(Icons.filter_list),
//             onPressed: () async {
//               String? selectedFilter = await showDialog(
//                 context: context,
//                 builder: (context) {
//                   return FilterDialog(currentFilter: _orderController.currentFilter);
//                 },
//               );
//               if (selectedFilter != null) {
//                 _orderController.fetchAllOrdersFilter(filter: selectedFilter);
//               }
//             },
//           ),
//         ],
//       ),
//       body: GetBuilder<OrderControllerProduct>(
//         id: 'products', // Update ID to ensure only relevant parts are rebuilt
//         builder: (controller) {
//           if (controller.isLoading) {
//             return Center(child: CircularProgressIndicator());
//           }
//
//           // بررسی طول لیست Datasort
//           if (controller.Datasort.isEmpty) {
//             return Center(child: Text('No data available'));
//           }
//
//           return SingleChildScrollView(
//             child: Column(
//               children: [
//                 ...controller.Datasort.map((locationModel) {
//                   bool hasHurryProduct = locationModel.listPS
//                       .any((product) => product.hurry);
//                   return ExpansionTile(
//                     title: ListTile(
//                       leading: Icon(
//                         Icons.circle,
//                         color: hasHurryProduct ? Colors.blue : Colors.grey,
//                         size: 20,
//                       ),
//                       title: Text(
//                         locationModel.companyname,
//                         style: TextStyle(
//                             fontSize: 14,
//                             fontWeight: FontWeight.bold),
//                       ),
//                       subtitle: Text(locationModel.address),
//                       onTap: () {
//                         // _mapController.move(
//                         //     locationModel.position,
//                         //     15.0); // حرکت نقشه به موقعیت
//                       },
//                     ),
//                     children: locationModel.listPS.map((product) {
//                       return Card(
//                         margin: EdgeInsets.symmetric(
//                             horizontal: 16, vertical: 8),
//                         child: ListTile(
//                           title: Text(
//                             "نام کالا: ${product.title}",
//                             style: TextStyle(fontSize: 14),
//                           ),
//                           subtitle: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 "تعداد کالا جهت دریافت: ${product.number}",
//                                 style: TextStyle(fontSize: 14),
//                               ),
//                               Row(
//                                 children: [
//                                   Icon(Icons.circle,
//                                       color: product.hurry ? Colors.blue : Colors.grey),
//                                   SizedBox(width: 5),
//                                   Text(
//                                     "عجله دار",
//                                     style: TextStyle(
//                                         fontSize: 14,
//                                         color: product.hurry ? Colors.blue : Colors.grey),
//                                   ),
//                                 ],
//                               ),
//                               Row(
//                                 children: [
//                                   Icon(Icons.circle,
//                                       color: product.okbuy ? Colors.green : Colors.grey),
//                                   SizedBox(width: 5),
//                                   Text(
//                                     "رزرو شده جهت دریافت",
//                                     style: TextStyle(
//                                         fontSize: 14,
//                                         color: product.okbuy ? Colors.green : Colors.grey),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                       );
//                     }).toList(),
//                   );
//                 }).toList(),
//               ],
//             ),
//           );
//         },
//       ),
//       drawer: MyDrawer(),
//     );
//   }
//
//   void ini() async{
//    await _orderController.fetchAllOrders(); // فراخوانی متد برای دریافت سفارش‌ها
//     print("Datasort Length: ${await _orderController.Datasort.length}");
//     _orderController.Datasort.forEach((locationModel) {
//       print("Location Model: ${locationModel.companyname}");
//     });
//   }
// }
//
// class FilterDialog extends StatefulWidget {
//   final String currentFilter;
//
//   FilterDialog({required this.currentFilter});
//
//   @override
//   _FilterDialogState createState() => _FilterDialogState();
// }
//
// class _FilterDialogState extends State<FilterDialog> {
//   late TextEditingController _filterController;
//
//   @override
//   void initState() {
//     super.initState();
//     _filterController = TextEditingController(text: widget.currentFilter);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title: Text('Apply Filter'),
//       content: TextField(
//         controller: _filterController,
//         decoration: InputDecoration(labelText: 'Filter'),
//       ),
//       actions: [
//         TextButton(
//           onPressed: () => Navigator.of(context).pop(), // Close without saving
//           child: Text('Cancel'),
//         ),
//         TextButton(
//           onPressed: () {
//             Navigator.of(context).pop(_filterController.text); // Return the filter
//           },
//           child: Text('Apply'),
//         ),
//       ],
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:receive_the_product/Getx/Drawer/MyDrawer.dart';
import 'package:receive_the_product/Getx/PagesOrderProduct/orderproduct_b.dart';


// سایر ایمپورت‌ها...

class OrderPage extends StatefulWidget {
  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  final OrderControllerProduct _orderController = Get.put(OrderControllerProduct());

  @override
  void initState() {
    super.initState();
    ini();
  }

  @override
  Widget build(BuildContext context) {
    print('object');
    return Scaffold(
      appBar: AppBar(
        title: Text('مدیریت محصولات'),

        actions: [
          IconButton(
            tooltip: 'به روز رسانی',
            onPressed: () {
              _orderController.FetchProductsAndSupplier();
            },
            icon: Icon(Icons.refresh, color: Colors.white),
          ),
          PopupMenuButton<String>(
            tooltip: 'مرتب سازی بر اثاث روند محصول',
            onSelected: (filter) {
              _orderController.fetchAllProductsFilter(filter: filter);
            },
            itemBuilder: (context) =>
            [

              PopupMenuItem(
                value: 'expectation = false',
                child: Text('صف دریافت ها'),
              ),
              PopupMenuItem(
                value: 'expectation = true',
                child: Text('دریافت شده ها'),
              ),
              PopupMenuItem(
                value: 'receive = true',
                child: Text('تحویل شده به انبار'),
              ),
              PopupMenuItem(
                value: 'receive = false',
                child: Text('صف تحویل نشده انبار'),
              ),

            ],
            icon: Icon(Icons.alt_route_sharp, color: Colors.white),
          ),
        ],
      ),
      body: GetBuilder<OrderControllerProduct>(
        id: 'products', // Update ID to ensure only relevant parts are rebuilt
        builder: (controller) {
          if (controller.Datasort.isEmpty) {
            return Center(child: CircularProgressIndicator());
          }

          // بررسی طول لیست Datasort
          if (controller.Datasort.isEmpty) {
            return Center(child: Text('No data available'));
          }

          return SingleChildScrollView(
            child: Column(
              children: [
                ...controller.Datasort.map((locationModel) {
                  bool hasHurryProduct = locationModel.listPS
                      .any((product) => product.hurry);
                  return ExpansionTile(
                    title: ListTile(
                      leading: Icon(
                        Icons.circle,
                        color: hasHurryProduct ? Colors.blue : Colors.grey,
                        size: 20,
                      ),
                      title: Text(
                        locationModel.companyname,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(locationModel.address),
                      onTap: () {
                        // _mapController.move(
                        //     locationModel.position,
                        //     15.0); // حرکت نقشه به موقعیت
                      },
                    ),
                    children: locationModel.listPS.map((product) {
                      return Card(
                        margin: EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: ListTile(
                          title: Text(
                            "نام کالا: ${product.title}",
                            style: TextStyle(fontSize: 14),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "تعداد کالا جهت دریافت: ${product.number}",
                                style: TextStyle(fontSize: 14),
                              ),
                              Row(
                                children: [
                                  Icon(Icons.circle,
                                      color: product.hurry ? Colors.blue : Colors.grey),
                                  SizedBox(width: 5),
                                  Text(
                                    "عجله دار",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: product.hurry ? Colors.blue : Colors.grey),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(Icons.circle,
                                      color: product.okbuy ? Colors.green : Colors.grey),
                                  SizedBox(width: 5),
                                  Text(
                                    "رزرو شده جهت دریافت",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: product.okbuy ? Colors.green : Colors.grey),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  );
                }).toList(),
              ],
            ),
          );
        },
      ),
      drawer: MyDrawer(),
    );
  }

  void ini() async {
    await _orderController.FetchProductsAndSupplier();
    print("Datasort Length: ${_orderController.Datasort.length}");
    _orderController.Datasort.forEach((locationModel) {
      print("Location Model: ${locationModel.companyname}");
    });
  }
}

class FilterDialog extends StatefulWidget {
  final String currentFilter;

  FilterDialog({required this.currentFilter});

  @override
  _FilterDialogState createState() => _FilterDialogState();
}

class _FilterDialogState extends State<FilterDialog> {
  late TextEditingController _filterController;

  @override
  void initState() {
    super.initState();
    _filterController = TextEditingController(text: widget.currentFilter);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Apply Filter'),
      content: TextField(
        controller: _filterController,
        decoration: InputDecoration(labelText: 'Filter'),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(), // Close without saving
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(_filterController.text); // Return the filter
          },
          child: Text('Apply'),
        ),
      ],
    );
  }
}
