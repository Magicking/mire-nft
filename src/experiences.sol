// SPDX-License-Identifier: AGPL-3.0
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/Strings.sol";
import "base64-sol/base64.sol";

contract ShowerLovers {
    using Strings for uint256;
    struct AssetsipfsURL {
        string imageipfsURL;
        string animationipfsURL;
    }

    mapping(bytes4 => bool) internal supportedInterfaces;
    mapping(uint256 => AssetsipfsURL) urls;
    uint256 _totalSupply;

    function getURLS(AssetsipfsURL[] memory _urls) public pure returns (AssetsipfsURL[] memory) {
        return _urls;
    }

    function setURL(uint256 i, string memory prefix) internal {
        urls[i].imageipfsURL = string(
            abi.encodePacked("QmUtqMJowAqwdBmqLnHgoNxRvVy4m4EzXZVnWpzop1Bdcb/", prefix, ".jpg")
        );
        urls[i].animationipfsURL = string(
            abi.encodePacked("QmQbRrpTDe2sMTtHTv2UYVKrgLXK6pFF8HPEfRxJ6vsaSg/", prefix, ".mp4")
        );
    }

    constructor() {
        setURL(0, "091eb57f4515c01f43e32f3682ef869232db9c01338b2039daf7e7bf57168a53");
        setURL(1, "1161dd097c1ff860e791dd24ce31a0d58b1341bcf8fe87a6dd5bc9e8e438c5b0");
        setURL(2, "1572daef89ba0e00759c424e60f3ad1d02494d4ea15c2c1b938bd392d177b079");
        setURL(3, "25ca6522c5a84a352160e854ad80bf0d516e62b077fc96dbdedde449e4e46bce");
        setURL(4, "3903efdc65cad99bffdb73c0de2c0e4cc514cca3f37fa62045e1f1d6c29c1eb2");
        setURL(5, "4c627d508bf2f575d676eb87a175719f1a6d60e6020824a7b42dd35c64d5bd4e");
        setURL(6, "5120eb81bb4275513fcd165e8b9acd1b2d20cb01f3004ebe448cfb04bae61487");
        setURL(7, "a5ecadb3eaadb5461b5da6d481e8bc0c21553cce3f191a4ad3b6c522cb782aaa");
        setURL(8, "a87435884e68fa572b1938a1a1791c07ee6bcd908dbdf645a8d9ab65433c1d48");
        setURL(9, "a9ed5f5a05e1e5bc1e490954ddb788bec58eb72eb184ef8b39a5ec1df073dea4");
        setURL(10, "aa424a430dc9f065f18edf33a9a1f5bdcb868afeb38941b89a74d5bf2a19a5cf");
        setURL(11, "ca3fb3a3dc90e7c4656680486b03edd1ba2209b1deb5c64f9b00e29517f0bdb8");
        setURL(12, "e1ff80c44022ed135246f4703c52c742709470083b5895836dec0ea1cd8a0f45");
        _totalSupply = 13;
        supportedInterfaces[0x80ac58cd] = true; // ERC721
        supportedInterfaces[0x5b5e139f] = true; // ERC721Metadata
    }

    function name() public pure returns (string memory) {
        return "S.hower L.overs";
    }

    function symbol() public pure returns (string memory) {
        return unicode"🚿❤️";
    }

    function totalSupply() public view returns (uint256) {
        return _totalSupply;
    }

    function metadata(uint256 id) public view returns (string memory) {
        string memory desc;
        if (id % 2 == 0) desc = string(abi.encodePacked(symbol(), " - ", id.toString(), unicode"º"));
        else desc = string(abi.encodePacked(symbol(), " - ", id.toString(), unicode"ª"));
        return
            string(
                abi.encodePacked(
                    '{"name":"',
                    name(),
                    '", "description":"',
                    desc,
                    string(abi.encodePacked('", "external_url": "', "https://sky-light-sl.com/")),
                    '", "image":"ipfs://',
                    urls[id].imageipfsURL,
                    '", "animation_url": "ipfs://',
                    urls[id].animationipfsURL,
                    '"}'
                )
            );
    }

    function tokenURI(uint256 id) public view returns (string memory) {
        require(bytes(urls[id].imageipfsURL).length > 0);
        require(bytes(urls[id].animationipfsURL).length > 0);
        return string(abi.encodePacked("data:application/json;base64,", Base64.encode(bytes(metadata(id)))));
    }

    function supportsInterface(bytes4 interfaceID) external view returns (bool) {
        return supportedInterfaces[interfaceID];
    }
}
