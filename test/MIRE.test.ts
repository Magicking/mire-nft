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
    SLSL: <SkyLight>await ethers.getContract('SLSL'),
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

    const TokenURIParams = {
      tokenId: 0,
      name: 'S.peed L.ine',
      description:
        '< / S.ky L.ight  > vision < / S.peed L.ine  > collection < / S.uper L.ighters  > creation Monaco, May 2022 Formula 1 Grand Prix Series of seven unique art pieces',
      imageURL:
        'ipfs://Qmc9D8hC8LZbk8XxaZiJK1K9xje8pPuSuU3PZqFriGNGE8/F1SL.glb',
      animationURL: '',
      externalURL: 'https://sky-light-sl.com',
    };
    let token = await contracts.SL.tokenURI(1);
    console.log(token);
    token = await contracts.SL.tokenURI(3);
    console.log(token);
    token = await contracts.SLSL.tokenURI(1);
    console.log(token);
    token = await contracts.SLSL.tokenURI(1212);
    console.log(token);
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
