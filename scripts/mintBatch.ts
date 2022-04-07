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
    const NFTDescriptorC = <NFTDescriptor>(
      await ethers.getContract('NFTDescriptor', deployer)
    );

    /*
    const addresses = [
    '0x6120932248dafbddb7e97279e10f9348b0e0242c',
    '0x6120932248dafbddb7e97279e10f9348b0e0242c',
    '0x6120932248dafbddb7e97279e10f9348b0e0242c',
    '0x6120932248dafbddb7e97279e10f9348b0e0242c',
    '0x6120932248dafbddb7e97279e10f9348b0e0242c'];
    */
    const addresses = [
    '0xd35b6046dbb75668caF1A69B139c32DcE81C2B63',
    '0x6120932248dafbddb7e97279e10f9348b0e0242c',
    '0x547b4BF7f39FAE562d2d0d5CFc329B05ec3694F2',
    '0x1abae2B8026264E58e28302b1295153Cc5166F6d',
    '0x8772575854F296a0Bb9aE95b0fe01473B13B43a3',
    '0x75193E584257f45147abf12Cee96061EBba50c09',
    '0x44b19ff86d745d5ae14fe608aa5b99e16122ab8c',
    '0x55c23Ff0D59d062C279B4CB715eFbfd2fB4b3139'];
    //const cloneAddress = '0x22a13cbb476f66cf97fda78f15879613854f04b0'; // id: 6 // polygon
    const cloneAddress = WAITContract.address; // id: 0rinkeby
    console.log("Cloning ", cloneAddress);
    const cloneId = 42;
    log('Mint new token');
    console.log(addresses, cloneAddress, cloneId);
    let tx = await MIREContract.batchMint(addresses, cloneAddress, cloneId);
    await tx.wait();
    const balance = await MIREContract.balanceOf(deployer);
    console.log(balance);
    //console.log(await MIREContract.tokenURI(balance.sub(1)));
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
