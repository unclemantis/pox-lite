const { estimateContractDeploy, makeContractDeploy, broadcastTransaction, PostConditionMode } = require('@stacks/transactions');
const { StacksTestnet } = require ('@stacks/network');
import fs = require('fs');
import BigNum = require('bn.js');

const network = new StacksTestnet();

const txOptions = {
  contractName: 'pox-lite',
  codeBody: fs.readFileSync('./contracts/pox-lite.clar').toString(),
  senderKey: '4974a88497db2c415e5d7b16c27b229b2e883fbde6f1d2352319d06399ed094801',
  network,
  postConditionMode: PostConditionMode.Allow,
};

export async function deployContract() {
  const transaction = await makeContractDeploy(txOptions);
  const txid = await broadcastTransaction(transaction, network);
  console.log(txid);
};

deployContract();