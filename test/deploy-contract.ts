const { assert } = require('chai');
const { Client, Provider, ProviderRegistry, Result } = require('@blockstack/clarity');

describe("deploy contract test suite", () => {
  var poxLiteClient = Client;
  var provider = Provider;

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

  it("map should set", async () => {
    const tx = poxLiteClient.createTransaction({
      method: { name: "deposit", args: ["u100", "'SP3GWX3NE58KXHESRYE4DYQ1S31PQJTCRXB3PE9SB", "none"] }
    });
    await tx.sign("SP3GWX3NE58KXHESRYE4DYQ1S31PQJTCRXB3PE9SB")
    const receipt = await poxLiteClient.submitTransaction(tx);
    assert.isTrue(receipt.success);
  });

  after(async () => {
    await provider.close();
  });
});
