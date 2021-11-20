// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/Strings.sol";
import "base64-sol/base64.sol";

contract NFTDescriptor {
    using Strings for uint256;

    struct ConstructTokenURIParams {
        uint256 tokenId;
        string name;
        string description;
        string imageURL;
        string animationURL;
        string externalURL;
    }

    function TokenURIParamsCtor(
        string calldata name,
        string calldata description,
        string calldata imageURL,
        string calldata animationURL,
        string calldata externalURL
    ) public pure returns (ConstructTokenURIParams memory params) {
        params.name = name;
        params.description = description;
        params.imageURL = imageURL;
        params.animationURL = animationURL;
        params.externalURL = externalURL;
    }

    function constructTokenURI(ConstructTokenURIParams memory params) public pure returns (string memory) {
        return
            string(
                abi.encodePacked(
                    "data:application/json;base64,",
                    Base64.encode(
                        bytes(
                            abi.encodePacked(
                                "{",
                                generateName(params, false),
                                generateDescription(params, false),
                                generateExternalUrl(params, false),
                                generateImageLink(params, false),
                                generateAnimationLink(params, true),
                                "}"
                            )
                        )
                    )
                )
            );
    }

    function getEof(bool end) internal pure returns (string memory eof) {
        if (!end) eof = ",";
    }

    function generateDescription(ConstructTokenURIParams memory params, bool end) private pure returns (string memory) {
        string memory eof = getEof(end);
        return string(abi.encodePacked('"description": "', escapeChars('\n"\\', params.description), '"', eof));
    }

    function generateName(ConstructTokenURIParams memory params, bool end) private pure returns (string memory) {
        string memory eof = getEof(end);
        return string(abi.encodePacked('"name": "', params.name, '"', eof));
    }

    function generateExternalUrl(ConstructTokenURIParams memory params, bool end)
        internal
        pure
        returns (string memory)
    {
        string memory eof = getEof(end);

        if (bytes(params.externalURL).length > 0)
            return string(abi.encodePacked('"external_url": "', params.externalURL, '"', eof));
        return "";
    }

    function generateImageLink(ConstructTokenURIParams memory params, bool end) internal pure returns (string memory) {
        string memory eof = getEof(end);

        if (bytes(params.imageURL).length > 0) return string(abi.encodePacked('"image": "', params.imageURL, '"', eof));
        return "";
    }

    function generateAnimationLink(ConstructTokenURIParams memory params, bool end)
        internal
        pure
        returns (string memory)
    {
        string memory eof = getEof(end);

        if (bytes(params.animationURL).length > 0)
            return string(abi.encodePacked('"animation_url": "', params.animationURL, '"', eof));
        return "";
    }

    function escapeChars(string memory chars, string memory symbol) internal pure returns (string memory) {
        bytes memory symbolBytes = bytes(symbol);
        bytes memory charsBytes = bytes(chars);
        uint8 quotesCount = 0;
        for (uint8 i = 0; i < symbolBytes.length; i++) {
            for (uint8 j = 0; j < charsBytes.length; j++) {
                if (symbolBytes[i] == charsBytes[j]) {
                    quotesCount++;
                    continue;
                }
            }
        }
        if (quotesCount > 0) {
            bytes memory escapedBytes = new bytes(symbolBytes.length + (quotesCount));
            uint256 index;
            for (uint8 i = 0; i < symbolBytes.length; i++) {
                for (uint8 j = 0; j < charsBytes.length; j++) {
                    if (symbolBytes[i] == charsBytes[j]) {
                        escapedBytes[index++] = "\\";
                        break;
                    }
                }
                if (symbolBytes[i] == "\n") symbolBytes[i] = "n";
                escapedBytes[index++] = symbolBytes[i];
            }
            return string(escapedBytes);
        }
        return symbol;
    }

    function addressToString(address addr) internal pure returns (string memory) {
        return (uint256(uint160(addr))).toHexString(20);
    }
}
