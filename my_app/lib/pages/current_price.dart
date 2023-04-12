import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_app/services/functions.dart';
import 'package:web3dart/web3dart.dart';
import '../utils/constants.dart';

class GetCurrentPrice extends StatefulWidget {
  const GetCurrentPrice({super.key});

  @override
  State<GetCurrentPrice> createState() => _GetCurrentPriceState();
}

class _GetCurrentPriceState extends State<GetCurrentPrice> {
  Client? httpClient;
  Web3Client? ethClient;
  TextEditingController controller = TextEditingController();
  @override
  void initState() {
    httpClient = Client();
    ethClient = Web3Client(infura_url, httpClient!);
    super.initState();
  }

  Future<DeployedContract> loadContract() async {
    String abi = await rootBundle.loadString('assets/abi/abi.json');
    String contractAddress = contractAddress1;
    final contract = DeployedContract(
        ContractAbi.fromJson(abi, 'GetCurrentPrice'),
        EthereumAddress.fromHex(contractAddress));
    return contract;
  }

  Future<List<dynamic>> ask(String funcName, List<dynamic> args) async {
    final contract = await loadContract();
    final ethFunction = contract.function(funcName);
    final result = await ethClient!
        .call(contract: contract, function: ethFunction, params: []);
    return result;
  }

  Future<List<dynamic>> btcPrice() async {
    List<dynamic> result = await ask('getbtcLatestPrice', []);
    return result;
  }

  String res = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Get Current Price'),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
      ),
      body: Center(
        child: Container(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () async {
                  var res1 = await btcPrice();
                  BigInt bigint = res1[0];
                  setState(() {
                    res = '${bigint}';
                  });
                  //int res = await res1;
                  // Future<List<dynamic>> res = btcPrice(ethClient!);

                  // FutureBuilder<List>(
                  //     future: btcPrice(ethClient!),
                  //     builder: (context, snapshot) {
                  //       if (snapshot.connectionState ==
                  //           ConnectionState.waiting) {
                  //         return Center(
                  //           child: CircularProgressIndicator(),
                  //         );
                  //       }

                  //       return Text(snapshot.data.toString());
                  //     });
                },
                child: const Text("Bitcoin Price")),
            const SizedBox(height: 10),
            Text(res),
            const SizedBox(height: 30),
            ElevatedButton(
                onPressed: () => (context),
                child: const Text("Ethereum Price")),
          ],
        )),
      ),
    );
  }
}
