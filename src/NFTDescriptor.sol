// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/Strings.sol";
import "base64-sol/base64.sol";

library NFTDescriptor {
    using Strings for uint256;

    struct ConstructTokenURIParams {
        uint256 tokenId;
        string imageURL;
        string animationURL;
        string externalURL;
    }

    function TokenURIParamsCtor(
        string calldata imageURL,
        string calldata animationURL,
        string calldata externalURL
    ) public pure returns (ConstructTokenURIParams memory params) {
        params.imageURL = imageURL;
        params.animationURL = animationURL;
        params.externalURL = externalURL;
        return params;
    }

    function constructTokenURI(ConstructTokenURIParams memory params) public pure returns (string memory) {
        string memory name = generateName(params);
        string memory description = generateDescription(params);
        //string memory image = Base64.encode(bytes(generateSVGImage(params)));

        return
            string(
                abi.encodePacked(
                    "data:application/json;base64,",
                    Base64.encode(
                        bytes(
                            abi.encodePacked(
                                '{"name":"',
                                name,
                                '", "description":"',
                                description,
                                generateExternalUrl(params),
                                '", "image":"',
                                generateImagesLink(params),
                                '"}'
                            )
                        )
                    )
                )
            );
    }

    function generateExternalUrl(ConstructTokenURIParams memory params) internal pure returns (string memory) {
        if (bytes(params.externalURL).length > 0)
            return string(abi.encodePacked('", "external_url": "', params.externalURL));
        return "";
    }

    function generateImagesLink(ConstructTokenURIParams memory params) internal pure returns (string memory) {
        if (bytes(params.animationURL).length > 0)
            return string(abi.encodePacked(params.imageURL, '", "animation_url": "', params.animationURL));
        return params.imageURL;
    }

    function escapeQuotes(string memory symbol) internal pure returns (string memory) {
        bytes memory symbolBytes = bytes(symbol);
        uint8 quotesCount = 0;
        for (uint8 i = 0; i < symbolBytes.length; i++) {
            if (symbolBytes[i] == '"') {
                quotesCount++;
            }
        }
        if (quotesCount > 0) {
            bytes memory escapedBytes = new bytes(symbolBytes.length + (quotesCount));
            uint256 index;
            for (uint8 i = 0; i < symbolBytes.length; i++) {
                if (symbolBytes[i] == '"') {
                    escapedBytes[index++] = "\\";
                }
                escapedBytes[index++] = symbolBytes[i];
            }
            return string(escapedBytes);
        }
        return symbol;
    }

    function generateDescription(ConstructTokenURIParams memory params) private pure returns (string memory) {
        return string(abi.encodePacked("MIRE SL - Number ", params.tokenId.toString()));
    }

    function generateName(ConstructTokenURIParams memory params) private pure returns (string memory) {
        return string(abi.encodePacked("MIRE SL - ", params.tokenId.toString()));
    }

    function addressToString(address addr) internal pure returns (string memory) {
        return (uint256(uint160(addr))).toHexString(20);
    }
}
