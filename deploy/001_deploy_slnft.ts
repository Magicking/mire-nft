import {HardhatRuntimeEnvironment} from 'hardhat/types';
import {DeployFunction} from 'hardhat-deploy/types';
import {MIRE} from '../typechain';

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
    args: [
      'MIRE',
      'MIRE †',
      NFTDescriptorLib.address,
      '0x6120932248dafbddb7e97279e10f9348b0e0242c',
    ],
  });
};
export default func;
func.tags = ['MIRE'];
