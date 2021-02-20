import { stringUtf8CV } from "@stacks/transactions";
import fetch from 'cross-fetch';
import { Configuration, AccountsApi } from '@stacks/blockchain-api-client';

const {
    makeContractCall,
    broadcastTransaction,
    standardPrincipalCVFromAddress,
    createAddress,
    uintCV,
    PostConditionMode,
} = require('@stacks/transactions');

const {
    StacksTestnet,
} = require('@stacks/network');

export async function deposit(Amount: number, Address: string, Memo: string) {
        const apiConfig = new Configuration({
            fetchApi: fetch,
            basePath: 'https://stacks-node-api.mainnet.stacks.co',
        });

        const accountsApi = new AccountsApi(apiConfig);

        const txs = await accountsApi.getAccountInbound({
            principal: 'SPSB1D7MVRMWY8C521VWM6KY2J1FTNVASRG0DYR4',
        });

        const memo = stringUtf8CV(Buffer.from(txs.results[0].memo.substr(2), 'hex').toString('utf8'));
        const address = txs.results[0].sender;
        const amount = uintCV(txs.results[0].amount);
        const height = uintCV(txs.results[0].block_height);
        const network = new StacksTestnet();
        //const amount = uintCV(Amount);
        //const address = Address;
        //const memo = stringUtf8CV(Memo);
        const sender = standardPrincipalCVFromAddress(createAddress(address));
        const txOptions = {
            contractAddress: "ST1HR732F4P5GDVXPTVBEVXVYJC3C9AA9FARW541F",
            contractName: 'test-4',
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

deposit(1000000, "ST1HR732F4P5GDVXPTVBEVXVYJC3C9AA9FARW541F", "This is a another test deposit");