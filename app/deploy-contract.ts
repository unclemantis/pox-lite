import { makeContractDeploy, broadcastTransaction, PostConditionMode, estimateContractDeploy } from '@stacks/transactions';
import { StacksMocknet, StacksTestnet } from '@stacks/network';
const fs = require('fs');

export async function deployContract() {

  const network = new StacksTestnet();

  const txOptions = {
    contractName: "test-202103011433",
    codeBody: fs.readFileSync("../contracts/pox-lite.clar").toString(),
    senderKey: "a9e8cc8b2409f7b045183f41d38fcb943e54f74775098bcbdc1ba07011357c7a01",
    network,
    postConditionMode: PostConditionMode.Allow,
  };
  var transaction = await makeContractDeploy(txOptions);
  await estimateContractDeploy(transaction, network);
  const txid = await broadcastTransaction(transaction, network);
  console.log(txid);
};

deployContract();


//{
//  "mnemonic": "frog scene north know beach okay parent trouble loop thought coast paper know display nut buddy tent current joke monkey relax hip crumble crater",
//  "keyInfo": {
//    "privateKey": "a9e8cc8b2409f7b045183f41d38fcb943e54f74775098bcbdc1ba07011357c7a01",
///    "address": "ST1FZ7JENZT9B9NYFH7NGG6S9MXZWVJNGST39NWFR",
//    "btcAddress": "mpGJXzdQAUJaPmK4TC28xistR2SjkVSPrP",
//    "index": 0
//  }
//}