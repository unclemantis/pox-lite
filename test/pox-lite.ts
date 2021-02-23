import fetch from 'cross-fetch';
import { Configuration, AccountsApi } from '@stacks/blockchain-api-client';
import { providerWithInitialAllocations } from "./providerWithInitialAllocations";
import * as balances from "./balances.json"
const { assert } = require('chai');
const { Client, Provider, ProviderRegistry } = require('@blockstack/clarity');

describe("contract test suite", () => {
  let poxLiteClient = Client;
  let provider = Provider;

  before(async () => {
    ProviderRegistry.registerProvider(providerWithInitialAllocations(balances));
    provider = await ProviderRegistry.createProvider();
    poxLiteClient = new Client("SP2J6ZY48GV1EZ5V2V5RB9MP66SW86PYKKNRV9EJ7.pox-lite", "pox-lite", provider);
  });

  it("should have a valid syntax", async () => {
    await poxLiteClient.checkContract();
  });

  it("should deploy", async () => {
    await poxLiteClient.deployContract();
  });

  it("deposit function should return True", async () => {
    const apiConfig = new Configuration({
      fetchApi: fetch,
      basePath: 'https://stacks-node-api.mainnet.stacks.co',
    });

    const accountsApi = new AccountsApi(apiConfig);

    const txs = await accountsApi.getAccountInbound({
      principal: 'SPSB1D7MVRMWY8C521VWM6KY2J1FTNVASRG0DYR4',
    });

    const memo = txs.results[0].memo;
    const tx = poxLiteClient.createTransaction({
      method: { name: "deposit", args: ["u100", memo] }
    });
    await tx.sign("SP30JX68J79SMTTN0D2KXQAJBFVYY56BZJEYS3X0B")
    const receipt = await poxLiteClient.submitTransaction(tx);
    assert.isTrue(receipt.success);
  });

  after(async () => {
    await provider.close();
  });
});
