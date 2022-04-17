import {getNamedAccounts, ethers, network} from 'hardhat';
import {parseEther, formatEther} from '@ethersproject/units';
import debugModule from 'debug';
import {keccak256} from '@ethersproject/keccak256';
import {defaultAbiCoder} from '@ethersproject/abi';
import {WAIT, MIRE, NFTDescriptor} from '../typechain';

function waitFor<T>(p: Promise<{wait: () => Promise<T>}>): Promise<T> {
  return p.then((tx) => tx.wait());
}

async function main() {
  try {
    const log = debugModule('mire:script');
    log.enabled = true;
    const {deployer} = await getNamedAccounts();

    const MIREContract = <MIRE>await ethers.getContract('SLINE', deployer);
    const WAITContract = <WAIT>await ethers.getContract('WAIT', deployer);
    for (let i = 0; i < 10; i++) {
      console.log(await MIREContract.tokenURI(i));
    }
  } catch (e) {
    console.log(e);
  }
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.log(error);
    process.exit(1);
  });
