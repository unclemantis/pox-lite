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

  it("get-deposit-id function should return 0", async () => {
    const query = poxLiteClient.createQuery({
      method: { name: "get-deposit-id", args: [] }
    });
    const receipt = await poxLiteClient.submitQuery(query);
    const result = Result.unwrap(receipt);
    assert.equal(result, '0');
  });

  it("increment-deposit-id function should return success", async () => {
    const query = poxLiteClient.createQuery({
      method: { name: "increment-deposit-id", args: [] }
    });
    const receipt = await poxLiteClient.submitQuery(query);
    assert.isTrue(receipt.success);
  });

  it("deposit function should return True", async () => {
    const query = poxLiteClient.createQuery({
      method: { name: "deposit", args: ["u100", "'SP2FJ3GKA3KGTDZG27QGSFATKFVXQWQN01Z49W1Q7", "\"memo\""] }
    });
    const receipt = await poxLiteClient.submitQuery(query);
    assert.isTrue(receipt.success);
  });

  after(async () => {
    await provider.close();
  });
});
