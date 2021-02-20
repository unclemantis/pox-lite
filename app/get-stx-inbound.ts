import fetch from 'cross-fetch';
import { Configuration, AccountsApi } from '@stacks/blockchain-api-client';

(async () => {
  const apiConfig = new Configuration({
    fetchApi: fetch,
    basePath: 'https://stacks-node-api.mainnet.stacks.co',
  });

  const accountsApi = new AccountsApi(apiConfig);

  const txs = await accountsApi.getAccountInbound({
    principal: 'SPSB1D7MVRMWY8C521VWM6KY2J1FTNVASRG0DYR4',
  });
  console.log(txs.results[0]);
  
})().catch(console.error);