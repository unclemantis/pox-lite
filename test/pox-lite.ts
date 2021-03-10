import { providerWithInitialAllocations } from "./providerWithInitialAllocations";
import * as balances from "./balances.json"
const { assert } = require('chai');
const { Client, Provider, ProviderRegistry, Result } = require('@blockstack/clarity');

describe("Contract", () => {
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
    const tx = poxLiteClient.createTransaction({
      method: { name: "deposit", args: ["u100", "0x616e6f746865722074657374206d656d6f0000000000000000000000000000000000"] }
    });
    await tx.sign("SP30JX68J79SMTTN0D2KXQAJBFVYY56BZJEYS3X0B")
    const receipt = await poxLiteClient.submitTransaction(tx);
    assert.isTrue(receipt.success);
  });

  it("deposit function should return True", async () => {
    const tx = poxLiteClient.createTransaction({
      method: { name: "deposit", args: ["u200", "0x616e6f746865722074657374206d656d6f0000000000000000000000000000000000"] }
    });
    await tx.sign("SP30JX68J79SMTTN0D2KXQAJBFVYY56BZJEYS3X0B")
    const receipt = await poxLiteClient.submitTransaction(tx);
    assert.isTrue(receipt.success);
  });

  it("redeem-boost function should return True", async () => {
    const tx = poxLiteClient.createTransaction({
      method: { name: "redeem-boost", args: ["u100"] }
    });
    await tx.sign("SP30JX68J79SMTTN0D2KXQAJBFVYY56BZJEYS3X0B")
    const receipt = await poxLiteClient.submitTransaction(tx);
    assert.isTrue(receipt.success);
  });
    
  after(async () => {
    await provider.close();
  });
});
