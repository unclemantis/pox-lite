"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.deployContract = void 0;
const transactions_1 = require("@stacks/transactions");
const network_1 = require("@stacks/network");
const fs = require('fs');
async function deployContract() {
    const network = new network_1.StacksMocknet();
    const txOptions = {
        contractName: "test",
        codeBody: fs.readFileSync("../contracts/pox-lite.clar").toString(),
        senderKey: "b8d99fd45da58038d630d9855d3ca2466e8e0f89d3894c4724f0efc9ff4b51f001",
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