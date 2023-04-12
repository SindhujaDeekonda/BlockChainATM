import 'package:flutter/services.dart';
import 'package:web3dart/web3dart.dart';
import '../utils/constants.dart';
// // Import the necessary libraries
// import 'package:flutter/material.dart';
// import 'package:web3dart/web3dart.dart';

// // Define the smart contract ABI and contract address
// final String contractAbi =
//     rootBundle.loadString('assets/abi/abi.json'); // ABI of the smart contract
// final String contractAddress =
//     contractAddress1; // Address of the smart contract

// // Instantiate the Ethereum client
// final ethClient = Web3Client('https://goerli.infura.io/v3/e4d4dac13e754678a8578d4b7ed3856c');

// // Function to invoke the smart contract function and retrieve the integer result

// Future<int> callFunction(String funcName, Web3Client ethClient ) async {
//   // Decode the ABI
//   DeployedContract contract = await loadContract();

//   // Invoke the smart contract function and retrieve the result
//   final result = await ethClient.call(
//       contract: contract,
//       function: contract.function('function_name'),
//       params: []);

//   // Parse the hexadecimal result to integer
//   final intResult = result[0].toInt();

//   // Return the integer result
//   return intResult;
// }

// // Flutter widget to display the integer result in UI
// class IntegerResultWidget extends StatefulWidget {
//   @override
//   _IntegerResultWidgetState createState() => _IntegerResultWidgetState();
// }

// class _IntegerResultWidgetState extends State<IntegerResultWidget> {
//   int _result = 0;

//   @override
//   void initState() {
//     super.initState();
//     // Invoke the smart contract function and retrieve the integer result
//     getSmartContractResult().then((intResult) {
//       setState(() {
//         _result = intResult;
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Text(
//         'Smart Contract Result: $_result', // Display the integer result in UI
//         style: TextStyle(fontSize: 24.0),
//       ),
//     );
//   }
// }

// // Usage in a Flutter app
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Smart Contract Result',
//       home: Scaffold(
//         appBar: AppBar(title: Text('Smart Contract Result')),
//         body: IntegerResultWidget(), // Display the integer result in UI
//       ),
//     );
//   }
// }
// Future<DeployedContract> loadContract() async {
//   String abi = await rootBundle.loadString('assets/abi/abi.json');
//   String contractAddress = contractAddress1;
//   final contract = DeployedContract(
//       ContractAbi.fromJson(abi, 'GetCurrentPrice'),
//       EthereumAddress.fromHex(contractAddress));
//   return contract;
// }

// Future<String> callFunction(String funcName, List<dynamic> args,
//     Web3Client ethClient, String privateKey) async {
//   EthPrivateKey credentials = EthPrivateKey.fromHex(privateKey);
//   DeployedContract contract = await loadContract();
//   final ethFunction = contract.function(funcName);
//   final result = await ethClient.sendTransaction(
//       credentials,
//       Transaction.callContract(
//           contract: contract, function: ethFunction, parameters: args),
//       chainId: null,
//       fetchChainIdFromNetworkId: true);
//   return result;
// }

// // Future<List<dynamic>> ask(
// //     String funcName, List<dynamic> args, Web3Client ethClient) async {
// //   final contract = await loadContract();
// //   final ethFunction = contract.function(funcName);
// //   final result = await ethClient
// //       .call(contract: contract, function: ethFunction, params: []);
// //   return result;
// // }

// // Future<List<dynamic>> btcPrice(Web3Client ethClient) async {
// //   List<dynamic> result = await ask('getbtcLatestPrice', [], ethClient);
// //   return result;
// // }

// Future<List<dynamic>> ethPrice(Web3Client ethClient) async {
//   List<dynamic> result = await ask('getethLatestPrice', [], ethClient);
//   return result;
// }
