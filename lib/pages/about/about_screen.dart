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
    // return ChangeNotifierProvider(
    //   create: (_) => AboutProvider(),
    //   child: Demo(),
    // );
    return MultiProvider(
      providers: [
        Provider<AboutProvider>(create: (_) => AboutProvider()),
      ],
      child: Demo(),
    );
    // return Demo();
  }
}

class Demo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AboutProvider provider = Provider.of(context);
    return Container(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text('${context.watch<AboutProvider>().count}'),
        FlatButton(
          onPressed: () {
            provider.add();
          },
          child: Text('+'),
        ),
      ],
    ));
  }
}
