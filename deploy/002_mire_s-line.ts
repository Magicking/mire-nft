import {HardhatRuntimeEnvironment} from 'hardhat/types';
import {DeployFunction} from 'hardhat-deploy/types';

const func: DeployFunction = async function (hre: HardhatRuntimeEnvironment) {
  const {ethers, deployments, getNamedAccounts} = hre;
  const {deploy, catchUnknownSigner} = deployments;

  const {deployer, governance} = await getNamedAccounts();

  const NFTDescriptorLib = await ethers.getContract('NFTDescriptor', deployer);
  const EXP = await ethers.getContract('EXP', deployer);

  console.log(EXP.address);
  // if in test mode
  // start impersonation
  const impersonatedSigner = "0x6120932248DaFbDDb7e97279e10F9348b0E0242c";
  //console.log(await hre.network.provider.request({
  //  method: "hardhat_impersonateAccount",
  //  params: [impersonatedSigner],
  //}));

  //const impersonatedDeployer = await ethers.getSigner(impersonatedSigner);
  await catchUnknownSigner(
    deploy('SLINE', {
      contract: 'MIRE',
      from: impersonatedSigner,
      log: true,
      libraries: {
        NFTDescriptor: NFTDescriptorLib.address,
      },
      proxy: {
        owner: impersonatedSigner,
        execute: {
          init: {
            methodName: 'init',
            args: ['S-LINE', 'S†ine'],
          },
          onUpgrade: {
            methodName: 'migrate',
            args: [EXP.address],
          },
        },
      },
    }),
    {log: true}
  );
  // if in test mode
  // stop impersonation
//    await hre.network.provider.request({
//  method: "hardhat_stopImpersonatingAccount",
//  params: ["0x6120932248DaFbDDb7e97279e10F9348b0E0242c"],
//});
};
export default func;
