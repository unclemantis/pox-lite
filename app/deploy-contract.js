"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.deployContract = void 0;
const transactions_1 = require("@stacks/transactions");
const network_1 = require("@stacks/network");
const fs = require('fs');
async function deployContract() {
    const network = new network_1.StacksTestnet();
    const txOptions = {
        contractName: "test-5",
        codeBody: fs.readFileSync("../contracts/pox-lite.clar").toString(),
        senderKey: "4974a88497db2c415e5d7b16c27b229b2e883fbde6f1d2352319d06399ed094801",
        network,
        postConditionMode: transactions_1.PostConditionMode.Allow,
    };
    var transaction = await transactions_1.makeContractDeploy(txOptions);
    const txid = await transactions_1.broadcastTransaction(transaction, network);
    console.log(txid);
}
exports.deployContract = deployContract;
;
deployContract();
//# sourceMappingURL=deploy-contract.js.map