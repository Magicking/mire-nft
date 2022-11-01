Live coding with
@sky_light_sl
-> https://twitch.tv/magicking6120

- Fetch assets
  - Already downloaded
- Verify assets normalization
  - Normalized the asset newyork
- Publish the data on IPFS
  - sky-light_new-york-blonde: ipfs://QmYJhD8Uoj7CuBac9hKoWsKdVfBw1CtQP4ucS2P25kuvzm/{00..43}.png
    IDTOKEN->IDPNG
  - speed-line: ipfs://Qmc9D8hC8LZbk8XxaZiJK1K9xje8pPuSuU3PZqFriGNGE8/{F1212121SL,F121212SL,F12121SL,F1212SL,F121SL,F12SL,F1SL}.glb
    IN CONSTRUCTOR
- Drink Champagne
  --->8---------->8--->8---------->8--->8---------->8---
- Upgrade MIRE-NFT to latest Soldity compiler version
  - Upgrade hardhat to latest version
  - Upgrade solidity to latest version
    --->8---------->8--->8---------->8--->8---------->8---
- MintBatch function / constructor to link assets
- TODO: - CHECK INVARIANTS IN THE CONTRACT (e.g. `require`) - Add specific logic to mint the SpeedLine NFT using the same params but different name (see file name) - Add specific logic to mint the SLNYB NFT using the same params but different logic since it's a single asset(movie) with all the frames in different item number from 00 to 43
- Test
- Deploy everything
  --->8---------->8--->8---------->8--->8---------->8---

Notes:

NFT:

- SLNYB
- NAME: SLNYB
- SYMBOL: SLNYB
- DESCRIPTION: Sky Light New York Blonde
- S.peed L.ine
- NAME: S.peed L.ine
- SYMBOL: SLSL
- DESCRIPTION: < / S.ky L.ight \ > vision < / S.peed L.ine \ > collection < / S.uper L.ighters \ > creation Monaco, May 2022 Formula 1 Grand Prix Series of seven unique art pieces

Solidity updates:
0.8.5

- verbatim - Solidity word language
- bytes32(bytes1(bytes32(0x4243...))) -> 0x4200...
  0.8.4
- new error mgmt -> no more `revert("string")`, now it's `revert(Error("string"))` with `Error` being a function declared `error Error(string message)` in the compilation unit

TODO: CHECK INVARIANTS IN THE CONTRACT (e.g. `require`)
