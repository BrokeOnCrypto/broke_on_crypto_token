import 'package:http/http.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:web3dart/web3dart.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity),
      home: MyHomePage(title: 'BrokeOnCryptoToken'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Client httpClient;
  Web3Client ethClient;
  bool data = false;
  final testAddress = "0x8717A44ec01bFd229B732EBBD048fAD2ceA67F8b";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Vx.gray300,
      body: ZStack([
        VxBox()
            .blue600
            .size(context.screenWidth, context.safePercentHeight * 30)
            .make(),
        VStack([
          (context.percentHeight * 10).heightBox,
          "\$BrokeOnCryptoToken".text.xl4.white.bold.makeCentered().py16(),
          (context.percentHeight * 5).heightBox,
          VxBox(
                  child: VStack([
            "Balance".text.gray700.xl2.semiBold.makeCentered(),
            10.heightBox,
            data
                ? "\$1".text.bold.xl6.makeCentered()
                : CircularProgressIndicator().centered(),
          ]))
              .p16
              .white
              .rounded
              .shadowXl
              .size(context.screenWidth, context.safePercentHeight * 18)
              .make()
              .p16(),
          30.heightBox,
          HStack([
            StyledTextButton(),
            StyledTextButton(),
            StyledTextButton(),

          ])
        ])
      ]),
    );
  }
}

class StyledTextButton extends StatelessWidget {
  const StyledTextButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
        onPressed: () {},
        style: TextButton.styleFrom(
          backgroundColor: Colors.blue,
        ),
        icon: Icon(
          Icons.refresh,
          color: Colors.white,
        ),
        label: "Refresh".text.white.make());
  }
}
