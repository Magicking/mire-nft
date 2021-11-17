import {HardhatRuntimeEnvironment} from 'hardhat/types';
import {DeployFunction} from 'hardhat-deploy/types';

const func: DeployFunction = async function (hre: HardhatRuntimeEnvironment) {
  const {deployments, getNamedAccounts} = hre;
  const {deploy} = deployments;

  const {deployer} = await getNamedAccounts();

  const NFTDescriptorLib = await deploy('NFTDescriptor', {
    from: deployer,
    log: true,
  });

  await deploy('MIRE', {
    from: deployer,
    log: true,
    args: ['MIRE2', 'M†RE', NFTDescriptorLib.address],
  });
};
export default func;
func.tags = ['MIRE'];
