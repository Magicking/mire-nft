import {HardhatRuntimeEnvironment} from 'hardhat/types';
import {DeployFunction} from 'hardhat-deploy/types';

const func: DeployFunction = async function (hre: HardhatRuntimeEnvironment) {
  const {ethers, deployments, getNamedAccounts} = hre;
  const {deploy, catchUnknownSigner} = deployments;

  const {deployer, governance} = await getNamedAccounts();

  const NFTDescriptorLib = await ethers.getContract('NFTDescriptor', deployer);

  await catchUnknownSigner(
    deploy('SLSL', {
      contract: 'SkyLight',
      args: ['S.peed L.ine', 'SLSL', NFTDescriptorLib.address, deployer],
      from: deployer,
      log: true,
    }),
    {log: true}
  );
  const SLSL = await ethers.getContract('SLSL', deployer);
  console.log('SLSL address: ' + SLSL.address);
};
export default func;
