const { assert } = require('chai');
const { Client, Provider, ProviderRegistry } = require('@blockstack/clarity');

describe("deploy contract test suite", () => {
  let poxLiteClient = new Client;
  let provider = Provider;

  before(async () => {
    provider = await ProviderRegistry.createProvider();
    poxLiteClient = new Client("SP3GWX3NE58KXHESRYE4DYQ1S31PQJTCRXB3PE9SB.pox-lite", "pox-lite", provider);
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
