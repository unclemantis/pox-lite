"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.getDepositsByHeight = exports.deposit = void 0;
const transactions_1 = require("@stacks/transactions");
const cross_fetch_1 = require("cross-fetch");
const blockchain_api_client_1 = require("@stacks/blockchain-api-client");
const network_1 = require("@stacks/network");
const transactions_2 = require("@stacks/transactions");
const { StacksTestnet, } = require('@stacks/network');
const BigNum = require('bn.js');
async function deposit(n) {
    //        const apiConfig = new Configuration({
    //            fetchApi: fetch,
    //            basePath: 'https://stacks-node-api.mainnet.stacks.co',
    //        });
    const apiConfig = new blockchain_api_client_1.Configuration({
        fetchApi: cross_fetch_1.default,
        basePath: 'https://stacks-node-api.mainnet.stacks.co',
    });
    const accountsApi = new blockchain_api_client_1.AccountsApi(apiConfig);
    const txs = await accountsApi.getAccountInbound({
        principal: 'SPSB1D7MVRMWY8C521VWM6KY2J1FTNVASRG0DYR4',
    });
    const x = new BigNum(n + 10);
    const memo = transactions_1.bufferCVFromString(txs.results[n].memo);
    const address = txs.results[n].sender;
    const amount = transactions_2.uintCV(txs.results[n].amount);
    const height = transactions_2.uintCV(txs.results[n].block_height);
    const network = new network_1.StacksMocknet();
    const sender = transactions_2.standardPrincipalCVFromAddress(transactions_2.createAddress(address));
    const txOptions = {
        contractAddress: "ST2ZRX0K27GW0SP3GJCEMHD95TQGJMKB7G9Y0X1MH",
        contractName: 'test',
        functionName: 'deposit',
        functionArgs: [height, sender, amount, memo],
        nonce: x,
        senderKey: 'b8d99fd45da58038d630d9855d3ca2466e8e0f89d3894c4724f0efc9ff4b51f001',
        validateWithAbi: true,
        network,
        postConditionMode: transactions_2.PostConditionMode.Allow,
    };
    const transaction = await transactions_2.makeContractCall(txOptions);
    const txid = await transactions_2.broadcastTransaction(transaction, network);
    console.log(txid);
}
exports.deposit = deposit;
deposit(0);
deposit(1);
async function getDepositsByHeight(h) {
    const height = transactions_2.uintCV(h);
    const x = new BigNum(27);
    const network = new network_1.StacksMocknet();
    const sender = transactions_2.standardPrincipalCVFromAddress(transactions_2.createAddress("ST2ZRX0K27GW0SP3GJCEMHD95TQGJMKB7G9Y0X1MH"));
    const txOptions = {
        contractName: 'test',
        contractAddress: "ST2ZRX0K27GW0SP3GJCEMHD95TQGJMKB7G9Y0X1MH",
        functionName: 'get-deposits-by-height',
        functionArgs: [height],
        network: network,
        senderAddress: "ST2ZRX0K27GW0SP3GJCEMHD95TQGJMKB7G9Y0X1MH"
    };
    const txid = await transactions_1.callReadOnlyFunction(txOptions);
    console.log(txid);
}
exports.getDepositsByHeight = getDepositsByHeight;
getDepositsByHeight(4209);
//# sourceMappingURL=call-contract.js.map