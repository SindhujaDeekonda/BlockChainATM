import 'package:flutter/services.dart';
import 'package:web3dart/web3dart.dart';
import '../utils/constants.dart';

Future<DeployedContract> loadContract() async {
  String abi = await rootBundle.loadString('assets/abi/cp_abi.json');
  String contractAddress = currentPriceAddress;
  final contract = DeployedContract(
      ContractAbi.fromJson(abi, 'GetCurrentPrice'),
      EthereumAddress.fromHex(contractAddress));
  return contract;
}

Future<String> callFunction(String funcName, List<dynamic> args,
    Web3Client ethClient, String privateKey) async {
  EthPrivateKey credentials = EthPrivateKey.fromHex(privateKey);
  DeployedContract contract = await loadContract();
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
