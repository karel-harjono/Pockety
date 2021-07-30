// import 'dart:ffi';

// import 'package:flutter/material.dart';

// void main() => runApp(Pockety());

// class Pockety extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Pockety',
//       theme: ThemeData(primaryColor: Colors.green[200]),
//       home: HomePage(),
//     );
//   }
// }

// class HomePage extends StatefulWidget {
//   HomePage({Key key, this.title}) : super(key: key);

//   final String title;

//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   // vars
//   bool _visibilityInput;

//   // methods
//   void _popInputBox() {
//     showDialog(
//         context: context,
//         builder: (context) {
//           return Dialog(
//             child: Text('this is myDialog'),
//           );
//         });
//     _visibilityInput = !_visibilityInput;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Pockety'),
//       ),
//       body: Builder(builder: (context) {
//         return Stack(
//           children: <Widget>[
//             Container(
//               color: Colors.green,
//             ),
//             Visibility(
//                 visible: !_visibilityInput,
//                 child: Container(
//                   margin: EdgeInsets.only(
//                       top: MediaQuery.of(context).size.height / 2 - 100),
//                   alignment: Alignment.center,
//                   height: MediaQuery.of(context).size.height -
//                       (MediaQuery.of(context).size.height / 2 - 100),
//                   color: Colors.red,
//                   child: Text('test'),
//                 )),
//           ],
//         );
//       }),
//       floatingActionButton: FloatingActionButton.extended(
//         tooltip: 'add_item',
//         icon: Icon(Icons.add),
//         label: Text('Add Item'),
//         onPressed: () {
//           setState(() => _popInputBox());
//         },
//       ),
//     );
//   }
// }

// // helper classes
