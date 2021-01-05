import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}
String lastTransactionHash;
class _MyHomePageState extends State<MyHomePage> {
  Client httpClient;
  Web3Client ethClient;


  @override
  void initState() {
    super.initState();
    lastTransactionHash = "";
    httpClient = new Client();
    ethClient = new Web3Client("http://127.0.0.1:7545", httpClient);
  }

  Future<DeployedContract> loadContract() async {
    String abiCode = await rootBundle.loadString("Assets/abi.json");
    String contractAddress = "0xB3EAA93Ac55a0A15f9688209836931C6aD1Ff9eD";

    final contract = DeployedContract(ContractAbi.fromJson(abiCode, "ConsumerData"),
        EthereumAddress.fromHex(contractAddress));
    return contract;
  }

  Future<String> submit(String functionName, List<dynamic> args) async {
    EthPrivateKey credentials = EthPrivateKey.fromHex(
        "148f42ce24eca534b979181506a9e31bd84a7935f714f736a5f6edb11769733e");

    DeployedContract contract = await loadContract();

    final ethFunction = contract.function(functionName);

    var result = await ethClient.sendTransaction(
      credentials,
      Transaction.callContract(
        contract: contract,
        function: ethFunction,
        parameters: args,
        maxGas: 1000000,
      ),
    );
    return result;
  }
  Future<String> sendCoind() async {
    var response = await submit("AddConsumer", [BigInt.one,"Karan",BigInt.two]);
    return response;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              child: Text("Make User Vaccinated"),
              onPressed: () async {
                var result = await sendCoind();
                setState(() {
                  lastTransactionHash = result;
                });
              },
            ),
            Text(lastTransactionHash)
          ],
        ),
      ),
    );
  }
}