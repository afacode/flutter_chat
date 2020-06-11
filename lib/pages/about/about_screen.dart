import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wechat_app/provider/about_provider.dart';

class AboutScreen extends StatefulWidget {
  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.red,);
    // Provider<AboutProvider>(
    //   create: (_) => AboutProvider(),
    //   child: Text(context.watch<AboutProvider>())
    // );
    //   child: Container(
    //     color: Colors.white,
    //     child: Column(
    //         mainAxisAlignment: MainAxisAlignment.center,
    //         crossAxisAlignment: CrossAxisAlignment.center,
    //         children: [
    //           Text(
    //             '${context.watch<AboutProvider>().count}',
    //             style: TextStyle(
    //                 fontSize: 42.0,
    //                 color: Colors.red,
    //                 fontWeight: FontWeight.bold),
    //           ),
    //           Add(),
    //         ]),
    //   ),
    // );
    
  }
}

// class Add extends StatelessWidget {
//   const Add({Key key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: FlatButton(
//           onPressed: () {
//             context.read<AboutProvider>().add();
//           },
//           textColor: Colors.white,
//           color: Colors.blue,
//           child: Text('+')),
//     );
//   }
// }