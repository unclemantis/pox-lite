"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const cross_fetch_1 = require("cross-fetch");
const blockchain_api_client_1 = require("@stacks/blockchain-api-client");
(async () => {
    const apiConfig = new blockchain_api_client_1.Configuration({
        fetchApi: cross_fetch_1.default,
        basePath: 'https://stacks-node-api.mainnet.stacks.co',
    });
    const accountsApi = new blockchain_api_client_1.AccountsApi(apiConfig);
    const txs = await accountsApi.getAccountInbound({
        principal: 'SPSB1D7MVRMWY8C521VWM6KY2J1FTNVASRG0DYR4',
    });
    console.log(txs.results[0]);
})().catch(console.error);
//# sourceMappingURL=get-stx-inbound.js.map