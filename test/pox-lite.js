"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const transactions_1 = require("@stacks/transactions");
const { assert } = require('chai');
const utf8 = require('utf8');
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
    it("deposit function should return True", async () => {
        const memo = transactions_1.stringUtf8CV(Buffer.from('0x616e6f746865722074657374206d656d6f0000000000000000000000000000000000'.substr(2), 'hex').toString('utf8'));
        const tx = poxLiteClient.createTransaction({
            method: { name: "deposit", args: ["u100", "'SP2FJ3GKA3KGTDZG27QGSFATKFVXQWQN01Z49W1Q7", memo] }
        });
        await tx.sign("SP2FJ3GKA3KGTDZG27QGSFATKFVXQWQN01Z49W1Q7");
        const receipt = await poxLiteClient.submitTransaction(tx);
        console.log(tx);
        console.log(receipt);
        assert.isTrue(receipt.success);
    });
    it("get-last-deposit-id function should return 1", async () => {
        const tx = poxLiteClient.createQuery({
            method: { name: "get-last-deposit-id", args: [] }
        });
        const receipt = await poxLiteClient.submitQuery(tx);
        const result = Result.unwrap(receipt);
        assert.equal(result, '1');
    });
    it("get-deposit-amounts-by-height function should return '(some SP2FJ3GKA3KGTDZG27QGSFATKFVXQWQN01Z49W1Q7)'", async () => {
        const tx = poxLiteClient.createQuery({
            method: { name: "get-deposit-amounts-by-height", args: ["4209"] }
        });
        const receipt = await poxLiteClient.submitQuery(tx);
        const result = Result.unwrap(receipt);
        assert.equal(result, '(some SP2FJ3GKA3KGTDZG27QGSFATKFVXQWQN01Z49W1Q7)');
    });
    after(async () => {
        await provider.close();
    });
});
//# sourceMappingURL=pox-lite.js.map