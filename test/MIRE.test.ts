import {expect} from './chai-setup';
import {
  ethers,
  deployments,
  getUnnamedAccounts,
  getNamedAccounts,
} from 'hardhat';
import {SkyLight, NFTDescriptor} from '../typechain';
import {setupUser, setupUsers} from './utils';

const setup = deployments.createFixture(async () => {
  await deployments.fixture('MIRE');
  const {deployer} = await getNamedAccounts();
  const contracts = {
    SL: <SkyLight>await ethers.getContract('SLNYB'),
    NFTDescriptor: <NFTDescriptor>await ethers.getContract('NFTDescriptor'),
  };
  const users = await setupUsers(await getUnnamedAccounts(), contracts);
  return {
    contracts,
    users,
    deployer: await setupUser(deployer, contracts),
  };
});
describe('SLNFT', function () {
  it('mint a composition', async function () {
    const {contracts, users, deployer} = await setup();

    const TokenURIParams = await contracts.NFTDescriptor.constructTokenURI({
      tokenId: 0,
      name: 'NAME',
      description: 'DESCRIPTION',
      imageURL: 'https://6120.eu/img/skylight.png',
      animationURL: '',
      externalURL: 'https://sky-light-sl.com',
    });
    await expect(
      contracts.SL.mint(deployer.address, {
        tokenId: 0,
        name: 'NAME',
        description: 'DESCRIPTION',
        imageURL: 'https://6120.eu/img/skylight.png',
        animationURL: '',
        externalURL: 'https://sky-light-sl.com',
      })
    )
      .to.emit(contracts.SL, 'Transfer')
      .withArgs(
        '0x0000000000000000000000000000000000000000',
        deployer.address,
        0
      );
  });
});

/*
describe('EXP', function () {
  it('get SL tokenURI', async function () {
    const {contracts, users, deployer} = await setup();

    console.log(await contracts.EXP.metadata(0));
    await expect(await contracts.EXP.metadata(0)).to.equal('Transfer');
  });
});
*/
