import { makeContractDeploy, broadcastTransaction, PostConditionMode } from '@stacks/transactions';
import { StacksMocknet, StacksTestnet } from '@stacks/network';
const fs = require('fs');

export async function deployContract() {

  const network = new StacksMocknet();

  const txOptions = {
    contractName: "test-202103011433",
    codeBody: fs.readFileSync("../contracts/pox-lite.clar").toString(),
    senderKey: "b8d99fd45da58038d630d9855d3ca2466e8e0f89d3894c4724f0efc9ff4b51f001",
    network,
    postConditionMode: PostConditionMode.Allow,
  };
  var transaction = await makeContractDeploy(txOptions);
  const txid = await broadcastTransaction(transaction, network);
  console.log(txid);
};

deployContract();