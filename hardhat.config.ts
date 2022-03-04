import 'dotenv/config';
import {HardhatUserConfig} from 'hardhat/types';
import 'hardhat-deploy';
import '@nomiclabs/hardhat-ethers';
import 'hardhat-gas-reporter';
import 'hardhat-abi-exporter';
import '@nomiclabs/hardhat-etherscan';
import '@typechain/hardhat';
import 'solidity-coverage';
import {node_url, accounts} from './utils/network';

// While waiting for hardhat PR: https://github.com/nomiclabs/hardhat/pull/1542
if (process.env.HARDHAT_FORK) {
  process.env['HARDHAT_DEPLOY_FORK'] = process.env.HARDHAT_FORK;
}

const config: HardhatUserConfig = {
  solidity: {
        compilers: [
      {
        version: '0.8.0',
        settings: {
          optimizer: {
            enabled: true,
            runs: 200,
          },
          evmVersion: 'istanbul',
        },
      },
      {
        version: '0.8.1',
        settings: {
          optimizer: {
            enabled: true,
            runs: 200,
          },
          evmVersion: 'istanbul',
        },
      },
    ],
  },
  namedAccounts: {
    deployer: 0,
    MIREBeneficiary: 1,
    governance: '0x18900eF2675aCc6D429fC75F2159101209E851ac', // MireTirelire
  },
  networks: {
    hardhat: {
      initialBaseFeePerGas: 0, // to fix : https://github.com/sc-forks/solidity-coverage/issues/652, see https://github.com/sc-forks/solidity-coverage/issues/652#issuecomment-896330136
      // process.env.HARDHAT_FORK will specify the network that the fork is made from.
      // this line ensure the use of the corresponding accounts
      accounts: accounts(process.env.HARDHAT_FORK),
      forking: process.env.HARDHAT_FORK
        ? {
            // TODO once PR merged : network: process.env.HARDHAT_FORK,
            url: node_url(process.env.HARDHAT_FORK),
            blockNumber: process.env.HARDHAT_FORK_NUMBER
              ? parseInt(process.env.HARDHAT_FORK_NUMBER)
              : undefined,
          }
        : undefined,
    },
    localhost: {
      url: node_url('localhost'),
      accounts: accounts(),
    },
    staging: {
      url: node_url('rinkeby'),
      accounts: accounts('rinkeby'),
    },
    production: {
      url: node_url('mainnet'),
      accounts: accounts('mainnet'),
    },
    mainnet: {
      url: node_url('mainnet'),
      accounts: accounts('mainnet'),
    },
    rinkeby: {
      url: node_url('rinkeby'),
      accounts: accounts('rinkeby'),
    },
    kovan: {
      url: node_url('kovan'),
      accounts: accounts('kovan'),
    },
    goerli: {
      url: node_url('goerli'),
      accounts: accounts('goerli'),
    },
    polygon: {
      url: node_url('polygon'),
      accounts: accounts('polygon'),
    },
  },
  paths: {
    sources: 'src',
  },
  gasReporter: {
    currency: 'USD',
    gasPrice: 100,
    enabled: process.env.REPORT_GAS ? true : false,
    coinmarketcap: process.env.COINMARKETCAP_API_KEY,
    maxMethodDiff: 10,
  },
  typechain: {
    outDir: 'typechain',
    target: 'ethers-v5',
  },
  mocha: {
    timeout: 0,
  },
  etherscan: {
    apiKey: 'ZHN4D4X3CHR87G444GM3FQ31R8FFN12RTM',
  },
  abiExporter: {
    path: './abi',
    clear: true,
    flat: true,
    spacing: 2,
    pretty: true,
  },
};

export default config;
