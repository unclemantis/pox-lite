const { assert } = require('chai');
const { Client, Provider, ProviderRegistry, Result } = require('@blockstack/clarity');
const { fs } = require('fs');

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

  it("get-deposit-id function should return 0", async () => {
    const tx = poxLiteClient.createTransaction({
      method: { name: "get-deposit-id", args: [] }
    });
    const receipt = await poxLiteClient.submitTransaction(tx);
    const result = Result.unwrap(receipt);
    assert.equal(result, '0');
  });

  it("increment-deposit-id function should return success", async () => {
    const tx = poxLiteClient.createTransaction({
      method: { name: "increment-deposit-id", args: [] }
    });
    const receipt = await poxLiteClient.submitTransaction(tx);
    assert.isTrue(receipt.success);
  });

  it("deposit function should return True", async () => {
    const tx = poxLiteClient.createTransaction({
      method: { name: "deposit", args: ["u100", "'SP2FJ3GKA3KGTDZG27QGSFATKFVXQWQN01Z49W1Q7", "\"memo\""] }
    });
    const receipt = await poxLiteClient.submitTransaction(tx);
    assert.isTrue(receipt.success);
  });

  after(async () => {
    await provider.close();
  });
});
