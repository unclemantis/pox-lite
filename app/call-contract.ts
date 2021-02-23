import { bufferCV, bufferCVFromString, callReadOnlyFunction, cvToString, stringUtf8CV, tupleCV } from "@stacks/transactions";
import fetch from 'cross-fetch';
import { Configuration, AccountsApi } from '@stacks/blockchain-api-client';
import { StacksMocknet } from "@stacks/network";

import {
    makeContractCall,
    broadcastTransaction,
    standardPrincipalCVFromAddress,
    createAddress,
    uintCV,
    PostConditionMode,
} from "@stacks/transactions";

const {
    StacksTestnet,
} = require('@stacks/network');

const BigNum = require('bn.js')

export async function deposit(n: number) {
    
    //        const apiConfig = new Configuration({
    //            fetchApi: fetch,
    //            basePath: 'https://stacks-node-api.mainnet.stacks.co',
    //        });
    const apiConfig = new Configuration({
        fetchApi: fetch,
        basePath: 'https://stacks-node-api.mainnet.stacks.co',
    });

    const accountsApi = new AccountsApi(apiConfig);

    const txs = await accountsApi.getAccountInbound({
        principal: 'SPSB1D7MVRMWY8C521VWM6KY2J1FTNVASRG0DYR4',
    });
    const x = new BigNum(n+10);
    const memo = bufferCVFromString(txs.results[n].memo);
    const address = txs.results[n].sender;
    const amount = uintCV(txs.results[n].amount);
    const height = uintCV(txs.results[n].block_height);
    const network = new StacksMocknet();
    const sender = standardPrincipalCVFromAddress(createAddress(address));
    const txOptions = {
        contractAddress: "ST2ZRX0K27GW0SP3GJCEMHD95TQGJMKB7G9Y0X1MH",
        contractName: 'test',
        functionName: 'deposit',
        functionArgs: [amount, memo],
        nonce: x,
        senderKey: 'b8d99fd45da58038d630d9855d3ca2466e8e0f89d3894c4724f0efc9ff4b51f001',
        validateWithAbi: true,
        network,
        postConditionMode: PostConditionMode.Allow,
    };

    const transaction = await makeContractCall(txOptions);
    const txid = await broadcastTransaction(transaction, network);

    console.log(txid);
}

deposit(0);

export async function getDepositsByHeight(h: number) {
    const height = uintCV(h)
    const x = new BigNum(27);
    const network = new StacksMocknet();
    const sender = standardPrincipalCVFromAddress(createAddress("ST2ZRX0K27GW0SP3GJCEMHD95TQGJMKB7G9Y0X1MH"));
    const txOptions = {
        contractName: 'test',
        contractAddress: "ST2ZRX0K27GW0SP3GJCEMHD95TQGJMKB7G9Y0X1MH",
        functionName: 'get-deposits-by-height',
        functionArgs: [height],
        network: network,
        senderAddress: "ST2ZRX0K27GW0SP3GJCEMHD95TQGJMKB7G9Y0X1MH"
    };

    const txid = await callReadOnlyFunction(txOptions);
    console.log(cvToString(txid));
}

getDepositsByHeight(4209);