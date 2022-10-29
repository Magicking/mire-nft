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
      args: [
        'SkyLight New York Blonde',
        'SLNYB',
        NFTDescriptorLib.address,
        deployer,
      ],
      from: deployer,
      log: true,
    }),
    {log: true}
  );
  const SLNYB = await ethers.getContract('SLNYB', deployer);
  console.log('SLNYB address: ' + SLNYB.address);
  // Set 00..43 items metadatas
};
export default func;
