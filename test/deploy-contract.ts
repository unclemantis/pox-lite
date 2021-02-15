import { assert } from "chai";
import { Client, Provider, ProviderRegistry } from "@blockstack/clarity";

describe("deploy contract test suite", () => {
  let poxLiteClient: Client;
  let provider: Provider;

  before(async () => {
    provider = await ProviderRegistry.createProvider();
    poxLiteClient = new Client("SP30JX68J79SMTTN0D2KXQAJBFVYY56BZJEYS3X0B.pox-lite", "pox-lite", provider);
  });

  it("should have a valid syntax", async () => {
    await poxLiteClient.checkContract();
  });

  it("should deploy", async () => {
    const receipt = await poxLiteClient.deployContract();
    assert.isTrue(receipt.success);
  });

  after(async () => {
    await provider.close();
  });
});
