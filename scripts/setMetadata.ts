import {getNamedAccounts, ethers, network} from 'hardhat';
import {parseEther, formatEther} from '@ethersproject/units';
import debugModule from 'debug';
import {keccak256} from '@ethersproject/keccak256';
import {defaultAbiCoder} from '@ethersproject/abi';
import {MIRE, NFTDescriptor} from '../typechain';

function waitFor<T>(p: Promise<{wait: () => Promise<T>}>): Promise<T> {
  return p.then((tx) => tx.wait());
}

async function main() {
  try {
    const log = debugModule('mire:script');
    log.enabled = true;
    const {deployer} = await getNamedAccounts();

    const MIREContract = <MIRE>await ethers.getContract('SLINE', deployer);

    log('Set Metadata');
    let tx = await MIREContract.setContractURI({
      imageURL: 'https://6120.eu/img/skylight.png',
      externalURL: 'https://sky-light-sl.com',
      description: 'S.ky L.ight ',
      royaltiesRecipient: deployer,
      royaltiesFeeBasisPoints: 1000,
    });
    await tx.wait();
    console.log(await MIREContract.contractURI());
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
