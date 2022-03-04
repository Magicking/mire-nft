# MIRE NFT

- [x] ERC721 based on OpenZeppelin
- [x] Access Control
- [x] On-Chain Metdata generation
- [x] External NFT Metadata insertion
- [x] Rarrible Royalties compatible
- [x] OpenSea Royalties compatible
- [ ] Updates

## Known bugs

 - Opensea creator with capabilities to set royalties is set once at creation

## INSTALL

```bash
yarn
```

## TEST

```bash
yarn test
```

# Development

Mint a new item in a collection

```typescript
    const NFTparams = await NFTDescriptorC.TokenURIParamsCtor(
      'ipfs://QmQRX7xuHiuLVt29E2BMtadf5YGVQFRqf98GyShgwi44G9/mire.svg',
      'ipfs://QmUBup7b6eKy5WCSJxx6LM5vQhfpKmjbJVNVDL4QcQxkiF/2CylinderEngine.glb',
      'https://fr.wikipedia.org/wiki/Mire_(t%C3%A9l%C3%A9vision)'
    );
    log('Mint new token');
    await MIREContract.mint(deployer, NFTparams);
```

See [./scripts/mint.ts](./scripts/mint.ts)

## SCRIPTS

Here is the list of npm scripts you can execute:

Some of them relies on [./\_scripts.js](./_scripts.js) to allow parameterizing it via command line argument (have a look inside if you need modifications)
<br/><br/>

`yarn prepare`

As a standard lifecycle npm script, it is executed automatically upon install. It generate config file and typechain to get you started with type safe contract interactions
<br/><br/>

`yarn lint`, `yarn lint:fix`, `yarn format` and `yarn format:fix`

These will lint and format check your code. the `:fix` version will modifiy the files to match the requirement specified in `.eslintrc` and `.prettierrc.`
<br/><br/>

`yarn compile`

These will compile your contracts
<br/><br/>

`yarn void:deploy`

This will deploy your contracts on the in-memory hardhat network and exit, leaving no trace. quick way to ensure deployments work as intended without consequences
<br/><br/>

`yarn test [mocha args...]`

These will execute your tests using mocha. you can pass extra arguments to mocha
<br/><br/>

`yarn coverage`

These will produce a coverage report in the `coverage/` folder
<br/><br/>

`yarn gas`

These will produce a gas report for function used in the tests
<br/><br/>

`yarn dev`

These will run a local hardhat network on `localhost:8545` and deploy your contracts on it. Plus it will watch for any changes and redeploy them.
<br/><br/>

`yarn local:dev`

This assumes a local node it running on `localhost:8545`. It will deploy your contracts on it. Plus it will watch for any changes and redeploy them.
<br/><br/>

`yarn execute <network> <file.ts> [args...]`

This will execute the script `<file.ts>` against the specified network
<br/><br/>

`yarn deploy <network> [args...]`

This will deploy the contract on the specified network.

Behind the scene it uses `hardhat deploy` command so you can append any argument for it
<br/><br/>

`yarn export <network> <file.json>`

This will export the abi+address of deployed contract to `<file.json>`
<br/><br/>

`yarn fork:execute <network> [--blockNumber <blockNumber>] [--deploy] <file.ts> [args...]`

This will execute the script `<file.ts>` against a temporary fork of the specified network

if `--deploy` is used, deploy scripts will be executed
<br/><br/>

`yarn fork:deploy <network> [--blockNumber <blockNumber>] [args...]`

This will deploy the contract against a temporary fork of the specified network.

Behind the scene it uses `hardhat deploy` command so you can append any argument for it
<br/><br/>

`yarn fork:test <network> [--blockNumber <blockNumber>] [mocha args...]`

This will test the contract against a temporary fork of the specified network.
<br/><br/>

`yarn fork:dev <network> [--blockNumber <blockNumber>] [args...]`

This will deploy the contract against a fork of the specified network and it will keep running as a node.

Behind the scene it uses `hardhat node` command so you can append any argument for it

# Install Rarible codes

git clone rarible
mkdir -p @rarible/royalties/contracts/impl
cp ../node*modules/@rarible/royalties/contracts/{LibRoyaltiesV2.sol,LibPart.sol,RoyaltiesV2.sol,impl/{RoyaltiesV2Impl.sol,AbstractRoyalties.sol}} ./@rarible/royalties/contracts/
sed -i 's: = address.*: = payable(address(uint160(\_to)));:' src/@rarible/royalties/contracts/impl/AbstractRoyalties.sol
sed -i 's:>=0.6.2 <:^:' \_.sol
mv AbstractRoyalties.sol RoyaltiesV2Impl.sol impl

# Fix oz compiler fixe 

sed -e 's#/// @custom:oz-up.*##' -i /home/magicking/source/gocode/src/github.com/Magicking/mire-nft/node_modules/@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol
