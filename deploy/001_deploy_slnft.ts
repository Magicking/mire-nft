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
    args: [
      'ˢ</S.ky-†-L.ight\\>ᶫ',
      'S†L',
      NFTDescriptorLib.address,
      '0x47108CEa6a1a5ca48EC210169808DF65c34E7Ab0',
    ],
  });
};
export default func;
func.tags = ['MIRE'];
