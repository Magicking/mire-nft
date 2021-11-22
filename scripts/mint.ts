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
    /*
    const NFTparams = await NFTDescriptorC.TokenURIParamsCtor(
      'MIRE',
      'Description - MIRE',
      'ipfs://QmXePuve3fwsP5n3jGH3xCoCxi4vkn3CwRAvpNAomXfKRJ/S.iel-†-S1.png',
      'ipfs://QmcrTTbuz2eV9nAMPJRyQ31disgVKasUvRB3X38HdDRuhL/S.iel-†-S1.glb',
      'https://sky-light-sl.com/'
    );*/
    const NFTparams = await NFTDescriptorC.TokenURIParamsCtor(
      'MIRE †',
      'Line †\nLine ††\nLine †††\nLine †V\n'.replace(/(\r\n|\n|\r)/gm, '\\n'),
      'ipfs://QmQRX7xuHiuLVt29E2BMtadf5YGVQFRqf98GyShgwi44G9/mire.svg',
      'ipfs://QmUBup7b6eKy5WCSJxx6LM5vQhfpKmjbJVNVDL4QcQxkiF/2CylinderEngine.glb',
      'https://6120.eu'
    ); //
    log('Mint new token');
    const tx = await MIREContract.mint(deployer, NFTparams);
    await tx.wait();
    console.log(tx);
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
