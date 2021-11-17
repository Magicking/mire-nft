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

    const NFTparams = await NFTDescriptorC.TokenURIParamsCtor(
      'MIRE',
      'Description - MIRE',
      'ipfs://QmQRX7xuHiuLVt29E2BMtadf5YGVQFRqf98GyShgwi44G9/mire.svg',
      'ipfs://QmUBup7b6eKy5WCSJxx6LM5vQhfpKmjbJVNVDL4QcQxkiF/2CylinderEngine.glb',
      'https://fr.wikipedia.org/wiki/Mire_(t%C3%A9l%C3%A9vision)'
    );
    log('Mint new token');
    const tx = await MIREContract.mint(deployer, NFTparams);
    await tx.wait();
    console.log(
      await MIREContract.tokenURI((await MIREContract.totalSupply()).sub(1))
    );
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
