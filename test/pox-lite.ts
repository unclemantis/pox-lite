import fetch from 'cross-fetch';
import { Configuration, AccountsApi } from '@stacks/blockchain-api-client';
const { assert } = require('chai');
const { Client, Provider, ProviderRegistry, Result } = require('@blockstack/clarity');

describe("deploy contract test suite", () => {
  let poxLiteClient = Client;
  let provider = Provider;

  before(async () => {
    provider = await ProviderRegistry.createProvider();
    poxLiteClient = new Client("SP2FJ3GKA3KGTDZG27QGSFATKFVXQWQN01Z49W1Q7.pox-lite", "pox-lite", provider);
  });

  it("should have a valid syntax", async () => {
    await poxLiteClient.checkContract();
  });

  it("should deploy", async () => {
    await poxLiteClient.deployContract();
  });

  it("deposit function should return False", async () => {
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
    await tx.sign("SP2FJ3GKA3KGTDZG27QGSFATKFVXQWQN01Z49W1Q7")
    const receipt = await poxLiteClient.submitTransaction(tx);
    assert.isFalse(receipt.success);
  });

  after(async () => {
    await provider.close();
  });
});
