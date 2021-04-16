import 'package:broke_on_crypto_token/slider_widget.dart';
import 'package:flutter/services.dart';
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
  int theAmount = 0;
  var myData;
  final testAddress = "0x8717A44ec01bFd229B732EBBD048fAD2ceA67F8b";

  @override
  void initState() {
    super.initState();
    httpClient = Client();
    ethClient = Web3Client(
        "https://rinkeby.infura.io/v3/39c273ea50514253a5265950238a48d7",
        httpClient);
    getBalance(testAddress);
  }

  // Loads the Eth contract, that will be queried
  Future<DeployedContract> loadContract()async{
    String abi = await rootBundle.loadString("assets/abi.json");
    String contractAddress = "0xa2cA4DD471BffbAfda3b2B26f5a893456f2E0954";
    final contract = DeployedContract(ContractAbi.fromJson(abi, "BrokeOnCryptoToken"), EthereumAddress.fromHex(contractAddress));
    return contract;
  }

  // Queries the eth contract
  Future<List<dynamic>> query(String functionName, List<dynamic> args) async{
    final contract = await loadContract();
    final ethFunction = contract.function(functionName);
    final result = await ethClient.call(contract: contract, function: ethFunction, params: args);

    return result;
  }

  // retrieves balance of address
  Future<void> getBalance(String targetAddress) async{
    // EthereumAddress address = EthereumAddress.fromHex(targetAddress);
    List<dynamic> result = await query("getBalance", []);

    myData = result[0];
    data = true;
    setState(() {

    });
  }

  //UI
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
          SliderWidget(
            min: 0,
            max: 100,
            finalVal: (value) {
              theAmount = (value * 100).round();
              print("$theAmount");
            },
          ).centered(),
          HStack(
            [
              StyledTextButton(
                  passedText: "Refresh",
                  passedColor: Colors.blue,
                  passedIcon: Icons.refresh),
              StyledTextButton(
                passedText: "Deposit",
                passedColor: Colors.green,
                passedIcon: Icons.call_made_outlined,
              ),
              StyledTextButton(
                passedText: "Withdraw",
                passedColor: Colors.red,
                passedIcon: Icons.call_received_outlined,
              ),
            ],
            alignment: MainAxisAlignment.spaceAround,
            axisSize: MainAxisSize.max,
          ).p16()
        ])
      ]),
    );
  }
}

// Customized TextButton
class StyledTextButton extends StatelessWidget {
  final Color passedColor;
  final String passedText;
  final IconData passedIcon;
  final Function passedPadding;

  const StyledTextButton(
      {Key key,
      this.passedColor,
      this.passedText,
      this.passedIcon,
      this.passedPadding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
        onPressed: () {},
        style: TextButton.styleFrom(
          backgroundColor: this.passedColor,
        ),
        icon: Icon(
          passedIcon,
          color: Colors.white,
        ),
        label: this.passedText.text.white.makeCentered().h(50));
  }
}
