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

    const MIREContract = <MIRE>await ethers.getContract('MIRE', deployer);
    const NFTDescriptorC = <NFTDescriptor>(
      await ethers.getContract('NFTDescriptor', deployer)
    );

    //const cloneAddress = '0x22a13cbb476f66cf97fda78f15879613854f04b0'; // id: 6 // polygon
    const cloneAddress = '0xa7b8ca95b0cbbf745ee08981ad9b12e79dd3cddf'; // id: 0rinkeby
    const cloneId = 6;
    log('Mint new token');
    let tx = await MIREContract.mint(deployer, cloneAddress, cloneId);
    await tx.wait();
    console.log(await MIREContract.balanceOf(deployer));
    console.log(await MIREContract.tokenURI(0));
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
