"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const cross_fetch_1 = require("cross-fetch");
const blockchain_api_client_1 = require("@stacks/blockchain-api-client");
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
    it("deposit function should return True", async () => {
        const apiConfig = new blockchain_api_client_1.Configuration({
            fetchApi: cross_fetch_1.default,
            basePath: 'https://stacks-node-api.mainnet.stacks.co',
        });
        const accountsApi = new blockchain_api_client_1.AccountsApi(apiConfig);
        const txs = await accountsApi.getAccountInbound({
            principal: 'SPSB1D7MVRMWY8C521VWM6KY2J1FTNVASRG0DYR4',
        });
        const memo = txs.results[0].memo;
        const tx = poxLiteClient.createTransaction({
            method: { name: "deposit", args: ["u4209", "'SP2FJ3GKA3KGTDZG27QGSFATKFVXQWQN01Z49W1Q7", "u100", memo] }
        });
        await tx.sign("SP2FJ3GKA3KGTDZG27QGSFATKFVXQWQN01Z49W1Q7");
        const receipt = await poxLiteClient.submitTransaction(tx);
        assert.isTrue(receipt.success);
    });
    it("get-deposits-by-height function should return True", async () => {
        const tx = poxLiteClient.createTransaction({
            method: { name: "get-deposits-by-height", args: ["u4209"] }
        });
        await tx.sign("SP2FJ3GKA3KGTDZG27QGSFATKFVXQWQN01Z49W1Q7");
        const receipt = await poxLiteClient.submitTransaction(tx);
        assert.isTrue(receipt.success);
    });
    after(async () => {
        await provider.close();
    });
});
//# sourceMappingURL=pox-lite.js.map