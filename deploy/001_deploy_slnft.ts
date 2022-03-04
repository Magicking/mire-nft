import {HardhatRuntimeEnvironment} from 'hardhat/types';
import {DeployFunction} from 'hardhat-deploy/types';

const func: DeployFunction = async function (hre: HardhatRuntimeEnvironment) {
  const {deployments, getNamedAccounts} = hre;
  const {deploy, catchUnknownSigner} = deployments;

  const {deployer, governance} = await getNamedAccounts();

  const NFTDescriptorLib = await deploy('NFTDescriptor', {
    from: deployer,
    log: true,
  });

  await catchUnknownSigner(
    deploy('MIRE', {
      from: deployer,
      log: true,
      libraries: {
        NFTDescriptor: NFTDescriptorLib.address,
      },
      proxy: {
        owner: governance,
        execute: {
          init: {
            methodName: 'init',
            args: [],
          },
          onUpgrade: {
            methodName: 'upgrade', // method to be executed when the proxy is upgraded (not first deployment)
            args: [],
          },
        },
      },
    }
  ), { log: true })
};
export default func;
func.tags = ['MIRE'];
