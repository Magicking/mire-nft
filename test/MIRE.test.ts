import {expect} from './chai-setup';
import {
  ethers,
  deployments,
  getUnnamedAccounts,
  getNamedAccounts,
} from 'hardhat';
import {MIRE, NFTDescriptor} from '../typechain';
import {setupUser, setupUsers} from './utils';

const setup = deployments.createFixture(async () => {
  await deployments.fixture('MIRE');
  const {MIREBeneficiary} = await getNamedAccounts();
  const contracts = {
    MIRE: <MIRE>await ethers.getContract('MIRE'),
    NFTDescriptor: <NFTDescriptor>await ethers.getContract('NFTDescriptor'),
  };
  const users = await setupUsers(await getUnnamedAccounts(), contracts);
  return {
    contracts,
    users,
    MIREBeneficiary: await setupUser(MIREBeneficiary, contracts),
  };
});

describe('SLNFT', function () {
  it('mint a composition', async function () {
    const {contracts, users, MIREBeneficiary} = await setup();

    const NFTparams = await contracts.NFTDescriptor.TokenURIParamsCtor(
      'MIRE',
      'Descri\nption',
      'ipfs://QmQRX7xuHiuLVt29E2BMtadf5YGVQFRqf98GyShgwi44G9/mire.svg',
      'ipfs://QmUBup7b6eKy5WCSJxx6LM5vQhfpKmjbJVNVDL4QcQxkiF/2CylinderEngine.glb',
      'https://fr.wikipedia.org/wiki/Mire_(t%C3%A9l%C3%A9vision)'
    );
    await expect(contracts.MIRE.mint(MIREBeneficiary.address, NFTparams))
      .to.emit(contracts.MIRE, 'Transfer')
      .withArgs(
        '0x0000000000000000000000000000000000000000',
        MIREBeneficiary.address,
        0
      );

    await expect(contracts.MIRE.mint(MIREBeneficiary.address, NFTparams))
      .to.emit(contracts.MIRE, 'Transfer')
      .withArgs(
        '0x0000000000000000000000000000000000000000',
        MIREBeneficiary.address,
        1
      );

    await expect(contracts.MIRE.mint(MIREBeneficiary.address, NFTparams))
      .to.emit(contracts.MIRE, 'Transfer')
      .withArgs(
        '0x0000000000000000000000000000000000000000',
        MIREBeneficiary.address,
        2
      );
    const dataURI = (await contracts.MIRE.tokenURI(0)).substring(
      'data:application/json;base64,'.length
    );
    const metadata = Buffer.from(dataURI, 'base64').toString();
    console.log(metadata);
  });
});
