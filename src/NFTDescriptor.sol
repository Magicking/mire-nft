// SPDX-License-Identifier: AGPL-3.0
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/Strings.sol";
import "base64-sol/base64.sol";

library NFTDescriptor {
    using Strings for uint256;

    struct ConstructTokenParams {
        uint256 tokenId;
        string imageURL;
        string animationURL;
        string externalURL;
        uint256 value;
        // ---- CUSTOM -----
        uint256 tokenIdHypebear;
    }

    struct ConstructContractURIParams {
        string imageURL;
        string description;
        string externalURL;
        uint256 sellerFeeBasisPoints; // OpenSea seller fee in basis point
        address feeRecipient; // OpenSea seller fees recipient
    }

    function TokenURIParamsCtor(
        string calldata imageURL,
        string calldata animationURL,
        string calldata externalURL
    ) public pure returns (ConstructTokenParams memory params) {
        params.imageURL = imageURL;
        params.animationURL = animationURL;
        params.externalURL = externalURL;
        return params;
    }

    function ConstructContractURIParamsCtor(
        string calldata imageURL,
        string calldata description,
        string calldata externalURL,
        uint256 sellerFeeBasisPoints,
        address feeRecipient
    ) public pure returns (ConstructContractURIParams memory params) {
        params.imageURL = imageURL;
        params.description = description;
        params.externalURL = externalURL;
        params.sellerFeeBasisPoints = sellerFeeBasisPoints;
        params.feeRecipient = feeRecipient;
        return params;
    }

    function constructTokenURI(ConstructTokenParams memory params, string memory name) public pure returns (string memory) {
        string memory _name = generateName(params.tokenId, name);
        string memory description = generateDescription(params.tokenId, name);

        return
            string(
                abi.encodePacked(
                    "data:application/json;base64,",
                    Base64.encode(
                        bytes(
                            abi.encodePacked(
                                '{"name":"',
                                _name,
                                '", "description":"',
                                description,
                                generateExternalUrl(params.externalURL),
                                '", "image":"',
                                generateImagesLink(params.imageURL, params.animationURL),
                                '"}'
                            )
                        )
                    )
                )
            );
    }

    function constructContractURI(ConstructContractURIParams memory params, string memory contractName) public pure returns (string memory) {

        return
            string(
                abi.encodePacked(
                    "data:application/json;base64,",
                    Base64.encode(
                        bytes(
                            abi.encodePacked(
                                '{"name":"',
                                contractName,
                                '", "description":"',
                                params.description,
                                generateExternalUrl(params.externalURL),
                                '", "image":"',
                                generateImagesLink(params.imageURL, ""),
                                '", "seller_fee_basis_points":"',
                                "4242",
                                '", "fee_recipient":"',
                                addressToString(params.feeRecipient),
                                '"}'
                            )
                        )
                    )
                )
            );
    }

    function generateExternalUrl(string memory externalURL) internal pure returns (string memory) {
        if (bytes(externalURL).length > 0)
            return string(abi.encodePacked('", "external_url": "', externalURL));
        return "";
    }

    function generateImagesLink(string memory imageURL, string memory animationURL) internal pure returns (string memory) {
        // if animation URL is not set
        if (bytes(animationURL).length > 0)
            return string(abi.encodePacked(imageURL, '", "animation_url": "', animationURL));
        // return only the imageURL
        return imageURL;
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

    function generateDescription(uint256 tokenId, string memory contractName) private pure returns (string memory) {
        return string(abi.encodePacked(contractName, " - ", tokenId.toString(), unicode"º")); // TODO make it binary with ª
    }

    function generateName(uint256 tokenId, string memory contractName) private pure returns (string memory) {
        return string(abi.encodePacked(contractName, " - ", tokenId.toString()));
    }

    function addressToString(address addr) internal pure returns (string memory) {
        return (uint256(uint160(addr))).toHexString(20);
    }
}
