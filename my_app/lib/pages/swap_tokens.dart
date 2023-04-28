import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:web3dart/web3dart.dart';
import '../utils/constants.dart';
import 'package:external_app_launcher/external_app_launcher.dart';

class SwapTokens extends StatefulWidget {
  const SwapTokens({super.key});

  @override
  State<SwapTokens> createState() => _SwapTokensState();
}

class _SwapTokensState extends State<SwapTokens> {
  Client? httpClient;
  Web3Client? ethClient;
  @override
  void initState() {
    httpClient = Client();
    ethClient = Web3Client(infura_url, httpClient!);
    super.initState();
  }

  Future<DeployedContract> loadContract1() async {
    String abi = await rootBundle.loadString('assets/abi/st_abi.json');
    String contractAddress = swapTokenAddress;
    final contract = DeployedContract(ContractAbi.fromJson(abi, 'SwapTokens'),
        EthereumAddress.fromHex(contractAddress));
    return contract;
  }

  Future<String> callFunctionfromst(String funcName, List<dynamic> args,
      Web3Client ethClient, String privateKey) async {
    EthPrivateKey credentials = EthPrivateKey.fromHex(privateKey);
    DeployedContract contract = await loadContract1();
    final ethFunction = contract.function(funcName);
    final result = await ethClient.sendTransaction(
        credentials,
        Transaction.callContract(
            contract: contract, function: ethFunction, parameters: args),
        chainId: null,
        fetchChainIdFromNetworkId: true);

    return result;
  }

  Future<List<dynamic>> ask(
      String funcName, List<dynamic> args, Web3Client ethClient) async {
    final contract = await loadContract1();
    final ethFunction = contract.function(funcName);
    final result = await ethClient.call(
        contract: contract, function: ethFunction, params: args);
    return result;
  }

  late String acc1;
  late String acc2;
  late BigInt amount1;
  late BigInt amount2;
  String bal1 = '';

  Future<List<dynamic>> getBalance1(
      String funcName, String addr, Web3Client ethClient) async {
    List<dynamic> result =
        await ask(funcName, [EthereumAddress.fromHex(addr)], ethClient);
    return result;
  }

  void showSuccessMessage() {
    Fluttertoast.showToast(
        msg: "Swapped Tokens successfully!!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  // Future<List<dynamic>> getBalance2(Web3Client ethClient) async {
  //   List<dynamic> result = await ask(
  //       'show_balance2',
  //       [EthereumAddress.fromHex("0xB6C046343dF17e4B0296c59440abc9Fcb511c2fA")],
  //       ethClient);
  //   return result;
  // }

  TextEditingController mycontroller1 = TextEditingController();
  TextEditingController mycontroller2 = TextEditingController();
  TextEditingController mycontroller3 = TextEditingController();
  TextEditingController mycontroller4 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Swap Tokens"),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      child: const Text('Open Metamask'),
                      onPressed: () async => {
                        await LaunchApp.openApp(
                          androidPackageName: 'io.metamask',
                        )
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 100,
                      child: CupertinoButton(
                        padding: EdgeInsets.all(0),
                        borderRadius: BorderRadius.all(Radius.circular(25.0)),
                        color: Colors.white,
                        disabledColor: Colors.deepOrange,
                        onPressed: null,
                        child: Text(
                          "Account 1",
                          style: TextStyle(
                            fontSize: 15.5,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Flexible(
                      child: TextField(
                        controller: mycontroller1,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Enter Account 1 Address',
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 100,
                      child: CupertinoButton(
                        padding: EdgeInsets.all(0),
                        borderRadius: BorderRadius.all(Radius.circular(25.0)),
                        color: Colors.white,
                        disabledColor: Colors.deepOrange,
                        onPressed: null,
                        child: Text(
                          "Account 2",
                          style: TextStyle(
                            fontSize: 15.5,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Flexible(
                      child: TextField(
                        controller: mycontroller2,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Enter Account 2 Address',
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 100,
                      child: CupertinoButton(
                        padding: EdgeInsets.all(0),
                        borderRadius: BorderRadius.all(Radius.circular(25.0)),
                        color: Colors.white,
                        disabledColor: Colors.deepOrange,
                        onPressed: null,
                        child: Text(
                          "GOLD",
                          style: TextStyle(
                            fontSize: 15.5,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Flexible(
                      child: TextField(
                        controller: mycontroller3,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Enter no of GOLD tokens',
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 100,
                      child: CupertinoButton(
                        padding: EdgeInsets.all(0),
                        borderRadius: BorderRadius.all(Radius.circular(25.0)),
                        color: Colors.white,
                        disabledColor: Colors.deepOrange,
                        onPressed: null,
                        child: Text(
                          "SILVER",
                          style: TextStyle(
                            fontSize: 15.5,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Flexible(
                      child: TextField(
                        controller: mycontroller4,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Enter no of SILVER tokens',
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                ElevatedButton(
                  //style: Color,
                  child: const Text('Swap Tokens'),

                  style: ElevatedButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 17),
                    elevation: 3,
                    minimumSize: const Size(100, 40), //////// HERE
                  ),
                  onPressed: () async {
                    acc1 = mycontroller1.text;
                    acc2 = mycontroller2.text;
                    amount1 = BigInt.parse(mycontroller3.text) *
                        BigInt.from(pow(10, 18));
                    amount2 = BigInt.parse(mycontroller4.text) *
                        BigInt.from(pow(10, 18));
                    print(acc1);
                    print(acc2);
                    print(amount1);
                    print(amount2);
                    callFunctionfromst('swap', [amount1, amount2], ethClient!,
                        owner_private_key);
                    showSuccessMessage();
                  },
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        const Padding(padding: EdgeInsets.all(0)),
                        SizedBox(
                          width: 160,
                          child: CupertinoButton(
                            padding: EdgeInsets.all(10),
                            borderRadius:
                                BorderRadius.all(Radius.circular(25.0)),
                            color: Colors.deepOrange,

                            onPressed: () async {
                              acc1 = mycontroller1.text;
                              var res1 = await getBalance1(
                                  "show_balance1", acc1, ethClient!);
                              BigInt bigint = res1[0];
                              setState(() {
                                bal1 = '$bigint';
                              });
                            },
                            // async {
                            //   acc1 = mycontroller1.text,
                            //   print(acc1),
                            //   var _bal1 = await getBalance1("show_balance1", acc1, ethClient!),
                            //   BigInt bigint = _bal1[0];
                            //   setState((){
                            //     bal1 = '$_bal1';
                            //   })
                            // },
                            child: const Text(
                              "Account 1 balance",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 15.5,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(bal1),
                      ],
                    ),
                    Column(
                      children: [
                        Padding(padding: EdgeInsets.all(0)),
                        SizedBox(
                          width: 160,
                          child: CupertinoButton(
                            padding: EdgeInsets.all(10),
                            borderRadius:
                                BorderRadius.all(Radius.circular(25.0)),
                            color: Colors.deepOrange,
                            onPressed: () => {
                              acc2 = mycontroller2.text,
                              getBalance1("show_balance2", acc2, ethClient!)
                            },
                            child: Text(
                              "Account 2 balance",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 15.5,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text('balance'),
                      ],
                    )
                  ],
                ),
              ],
            )),
      ),
    );
  }
}
