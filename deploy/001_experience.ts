import {HardhatRuntimeEnvironment} from 'hardhat/types';
import {DeployFunction} from 'hardhat-deploy/types';

const func: DeployFunction = async function (hre: HardhatRuntimeEnvironment) {
  const {ethers, deployments, getNamedAccounts} = hre;
  const {deploy, catchUnknownSigner} = deployments;

  const {deployer, governance} = await getNamedAccounts();

  await catchUnknownSigner(
    deploy('EXP', {
      contract: 'ShowerLovers',
      from: deployer,
      log: true,
    }),
    {log: true}
  );
};
export default func;
