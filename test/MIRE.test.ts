import {expect} from './chai-setup';
import {
  ethers,
  deployments,
  getUnnamedAccounts,
  getNamedAccounts,
} from 'hardhat';
import {MIRE, ShowerLovers, NFTDescriptor} from '../typechain';
import {setupUser, setupUsers} from './utils';

const setup = deployments.createFixture(async () => {
  await deployments.fixture('MIRE');
  const {deployer} = await getNamedAccounts();
  const contracts = {
    SL: <MIRE>await ethers.getContract('SLINE'),
    NFTDescriptor: <NFTDescriptor>await ethers.getContract('NFTDescriptor'),
    EXP: <ShowerLovers>await ethers.getContract('EXP'),
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

    const cloneAddress = '0x42ae11ac8c6caf0c2ad29af90c759314d2f55553'; // polygon & rinkeby
    const cloneId = 0;
    await expect(contracts.SL.mint(deployer.address, cloneAddress, cloneId))
      .to.emit(contracts.SL, 'Transfer')
      .withArgs(
        '0x0000000000000000000000000000000000000000',
        deployer.address,
        0
      );
  });
});

describe('EXP', function () {
  it('get SL tokenURI', async function () {
    const {contracts, users, deployer} = await setup();

    console.log(await contracts.EXP.metadata(0));
    await expect(await contracts.EXP.metadata(0)).to.equal('Transfer');
  });
});
