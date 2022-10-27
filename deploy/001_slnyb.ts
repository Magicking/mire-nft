import {HardhatRuntimeEnvironment} from 'hardhat/types';
import {DeployFunction} from 'hardhat-deploy/types';

const func: DeployFunction = async function (hre: HardhatRuntimeEnvironment) {
  const {ethers, deployments, getNamedAccounts} = hre;
  const {deploy, catchUnknownSigner} = deployments;

  const {deployer, governance} = await getNamedAccounts();

  const NFTDescriptorLib = await ethers.getContract('NFTDescriptor', deployer);

  await catchUnknownSigner(
    deploy('SLNYB', {
      contract: 'SkyLight',
      args: ['SL NYB', 'SLNYB', NFTDescriptorLib.address, deployer],
      from: deployer,
      log: true,
    }),
    {log: true}
  );
};
export default func;
