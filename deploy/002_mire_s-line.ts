import {HardhatRuntimeEnvironment} from 'hardhat/types';
import {DeployFunction} from 'hardhat-deploy/types';

const func: DeployFunction = async function (hre: HardhatRuntimeEnvironment) {
  const {ethers, deployments, getNamedAccounts} = hre;
  const {deploy, catchUnknownSigner} = deployments;

  const {deployer, governance} = await getNamedAccounts();

  const NFTDescriptorLib = await ethers.getContract('NFTDescriptor', deployer);
  const EXP = await ethers.getContract('EXP', deployer);

  await catchUnknownSigner(
    deploy('SLINE', {
      contract: 'MIRE',
      from: deployer,
      log: true,
      libraries: {
        NFTDescriptor: NFTDescriptorLib.address,
      },
      proxy: {
        owner: deployer,
        execute: {
          init: {
            methodName: 'init',
            args: ['S-LINE', 'S†ine'],
          },
          onUpgrade: {
            methodName: 'init',
            args: [EXP.address],
          },
        },
      },
    }),
    {log: true}
  );
};
export default func;
