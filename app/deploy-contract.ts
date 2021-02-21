import { makeContractDeploy, broadcastTransaction, PostConditionMode } from '@stacks/transactions';
import { StacksTestnet } from '@stacks/network';
const fs = require('fs');

export async function deployContract() {

  const network = new StacksTestnet();

  const txOptions = {
    contractName: "test-5",
    codeBody: fs.readFileSync("../contracts/pox-lite.clar").toString(),
    senderKey: "4974a88497db2c415e5d7b16c27b229b2e883fbde6f1d2352319d06399ed094801",
    network,
    postConditionMode: PostConditionMode.Allow,
  };
  var transaction = await makeContractDeploy(txOptions);
  const txid = await broadcastTransaction(transaction, network);
  console.log(txid);
};

deployContract();