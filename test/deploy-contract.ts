const { assert } = require('chai');
const { Client, Provider, ProviderRegistry } = require('@blockstack/clarity');

describe("deploy contract test suite", () => {
  let poxLiteClient = new Client;
  let provider = new Provider;

  before(async () => {
    provider = await ProviderRegistry.createProvider();
    poxLiteClient = new Client("SP30JX68J79SMTTN0D2KXQAJBFVYY56BZJEYS3X0B.pox-lite", "pox-lite", provider);
  });

  it("should have a valid syntax", async () => {
    await poxLiteClient.checkContract();
  });

  it("should deploy", async () => {
    await poxLiteClient.deployContract();
  });

  after(async () => {
    await provider.close();
  });
});
