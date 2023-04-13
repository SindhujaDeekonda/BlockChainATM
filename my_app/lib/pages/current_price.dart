import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    String abi = await rootBundle.loadString('assets/abi/cp_abi.json');
    String contractAddress = currentPriceAddress;
    final contract = DeployedContract(
        ContractAbi.fromJson(abi, 'GetCurrentPrice'),
        EthereumAddress.fromHex(contractAddress));
    return contract;
  }

  Future<List<dynamic>> ask(
      String funcName, List<dynamic> args, Web3Client ethClient) async {
    final contract = await loadContract();
    final ethFunction = contract.function(funcName);
    final result = await ethClient
        .call(contract: contract, function: ethFunction, params: []);
    return result;
  }

  Future<List<dynamic>> btcPrice(Web3Client ethClient) async {
    List<dynamic> result = await ask('getbtcLatestPrice', [], ethClient);
    return result;
  }

  Future<List<dynamic>> ethPrice(Web3Client ethClient) async {
    List<dynamic> result = await ask('getethLatestPrice', [], ethClient);
    return result;
  }

  String btcres = "";
  String ethres = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Get Current Price'),
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
                  var res1 = await btcPrice(ethClient!);
                  BigInt bigint = res1[0];
                  setState(() {
                    btcres = '$bigint';
                  });
                },
                child: const Text("Bitcoin Price")),
            const SizedBox(height: 10),
            Text("Current Price : $btcres"),
            const SizedBox(height: 30),
            ElevatedButton(
                onPressed: () async {
                  var res1 = await ethPrice(ethClient!);
                  BigInt bigint = res1[0];
                  setState(() {
                    ethres = '$bigint';
                  });
                },
                child: const Text("Ethereum Price")),
            const SizedBox(height: 10),
            Text("Current Price : $ethres"),
          ],
        )),
      ),
    );
  }
}
