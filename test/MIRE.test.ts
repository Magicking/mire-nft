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
  const {deployer} = await getNamedAccounts();
  const contracts = {
    MIRE: <MIRE>await ethers.getContract('MIRE'),
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

    const cloneAddress = '0x42ae11ac8c6caf0c2ad29af90c759314d2f55553'; // polygon & rinkeby
    const cloneId = 0;
    await expect(
      contracts.MIRE.mint(deployer.address, cloneAddress, cloneId)
    )
      .to.emit(contracts.MIRE, 'Transfer')
      .withArgs(
        '0x0000000000000000000000000000000000000000',
        deployer.address,
        0
      );
  });
});
