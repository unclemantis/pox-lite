"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.deposit = void 0;
const transactions_1 = require("@stacks/transactions");
const cross_fetch_1 = require("cross-fetch");
const blockchain_api_client_1 = require("@stacks/blockchain-api-client");
const { makeContractCall, broadcastTransaction, standardPrincipalCVFromAddress, createAddress, uintCV, PostConditionMode, } = require('@stacks/transactions');
const { StacksTestnet, } = require('@stacks/network');
async function deposit() {
    const apiConfig = new blockchain_api_client_1.Configuration({
        fetchApi: cross_fetch_1.default,
        basePath: 'https://stacks-node-api.mainnet.stacks.co',
    });
    const accountsApi = new blockchain_api_client_1.AccountsApi(apiConfig);
    const txs = await accountsApi.getAccountInbound({
        principal: 'SPSB1D7MVRMWY8C521VWM6KY2J1FTNVASRG0DYR4',
    });
    const memo = transactions_1.stringUtf8CV(Buffer.from(txs.results[0].memo.substr(2), 'hex').toString('utf8'));
    const address = txs.results[0].sender;
    const amount = uintCV(txs.results[0].amount);
    const height = uintCV(txs.results[0].block_height);
    const network = new StacksTestnet();
    const sender = standardPrincipalCVFromAddress(createAddress(address));
    const txOptions = {
        contractAddress: "ST1HR732F4P5GDVXPTVBEVXVYJC3C9AA9FARW541F",
        contractName: 'test-5',
        functionName: 'deposit',
        functionArgs: [amount, sender, memo, height],
        senderKey: '4974a88497db2c415e5d7b16c27b229b2e883fbde6f1d2352319d06399ed094801',
        validateWithAbi: true,
        network,
        postConditionMode: PostConditionMode.Allow,
    };
    const transaction = await makeContractCall(txOptions);
    const txid = await broadcastTransaction(transaction, network);
    console.log(txid);
}
exports.deposit = deposit;
deposit();
//# sourceMappingURL=call-contract.js.map