import {HardhatRuntimeEnvironment} from 'hardhat/types';
import {DeployFunction} from 'hardhat-deploy/types';

const func: DeployFunction = async function (hre: HardhatRuntimeEnvironment) {
  const {deployments, getNamedAccounts} = hre as any;
  const {deploy} = deployments;

  const {deployer} = await getNamedAccounts();

  console.log('Deployer ' + deployer);
  console.log('Deploying NFTDescriptor');
  await deploy('NFTDescriptor', {
    from: deployer,
    log: true,
  });
};
export default func;
