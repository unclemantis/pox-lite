"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.deployContract = void 0;
const { estimateContractDeploy, makeContractDeploy, broadcastTransaction, PostConditionMode } = require('@stacks/transactions');
const { StacksTestnet } = require('@stacks/network');
const fs = require("fs");
const network = new StacksTestnet();
const txOptions = {
    contractName: 'pox-lite',
    codeBody: fs.readFileSync('./contracts/pox-lite.clar').toString(),
    senderKey: '4974a88497db2c415e5d7b16c27b229b2e883fbde6f1d2352319d06399ed094801',
    network,
    postConditionMode: PostConditionMode.Allow,
};
async function deployContract() {
    var transaction = await makeContractDeploy(txOptions);
    transaction.setFee = await estimateContractDeploy(transaction, network);
    const txid = await broadcastTransaction(transaction, network);
    console.log(txid);
}
exports.deployContract = deployContract;
;
deployContract();
//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoiZGVwbG95LWNvbnRyYWN0LmpzIiwic291cmNlUm9vdCI6IiIsInNvdXJjZXMiOlsiZGVwbG95LWNvbnRyYWN0LnRzIl0sIm5hbWVzIjpbXSwibWFwcGluZ3MiOiI7OztBQUFBLE1BQU0sRUFBRSxzQkFBc0IsRUFBRSxrQkFBa0IsRUFBRSxvQkFBb0IsRUFBRSxpQkFBaUIsRUFBRSxHQUFHLE9BQU8sQ0FBQyxzQkFBc0IsQ0FBQyxDQUFDO0FBQ2hJLE1BQU0sRUFBRSxhQUFhLEVBQUUsR0FBRyxPQUFPLENBQUUsaUJBQWlCLENBQUMsQ0FBQztBQUN0RCx5QkFBMEI7QUFJMUIsTUFBTSxPQUFPLEdBQUcsSUFBSSxhQUFhLEVBQUUsQ0FBQztBQUVwQyxNQUFNLFNBQVMsR0FBRztJQUNoQixZQUFZLEVBQUUsVUFBVTtJQUN4QixRQUFRLEVBQUUsRUFBRSxDQUFDLFlBQVksQ0FBQywyQkFBMkIsQ0FBQyxDQUFDLFFBQVEsRUFBRTtJQUNqRSxTQUFTLEVBQUUsb0VBQW9FO0lBQy9FLE9BQU87SUFDUCxpQkFBaUIsRUFBRSxpQkFBaUIsQ0FBQyxLQUFLO0NBQzNDLENBQUM7QUFFSyxLQUFLLFVBQVUsY0FBYztJQUNsQyxJQUFJLFdBQVcsR0FBRyxNQUFNLGtCQUFrQixDQUFDLFNBQVMsQ0FBQyxDQUFDO0lBQ3RELFdBQVcsQ0FBQyxNQUFNLEdBQUcsTUFBTSxzQkFBc0IsQ0FBQyxXQUFXLEVBQUUsT0FBTyxDQUFDLENBQUM7SUFDeEUsTUFBTSxJQUFJLEdBQUcsTUFBTSxvQkFBb0IsQ0FBQyxXQUFXLEVBQUUsT0FBTyxDQUFDLENBQUM7SUFDOUQsT0FBTyxDQUFDLEdBQUcsQ0FBQyxJQUFJLENBQUMsQ0FBQztBQUNwQixDQUFDO0FBTEQsd0NBS0M7QUFBQSxDQUFDO0FBRUYsY0FBYyxFQUFFLENBQUMifQ==