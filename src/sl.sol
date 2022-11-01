// SPDX-License-Identifier: AGPL-3.0
// https://github.com/Magicking/S.ky-L.ight-NFT
pragma solidity ^0.8.17;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/AccessControlEnumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Context.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "./@rarible/royalties/contracts/impl/RoyaltiesV2Impl.sol";
import "./@rarible/royalties/contracts/LibPart.sol";
import "./@rarible/royalties/contracts/LibRoyaltiesV2.sol";
import "./NFTDescriptor.sol";

contract SkyLight is Context, ERC721Enumerable, Ownable, RoyaltiesV2Impl, AccessControlEnumerable {
    using Strings for uint256;
    mapping(uint256 => NFTDescriptor.ConstructTokenURIParams) _metadatas;
    mapping(string => bool) public minted;

    uint256 mTokenId;
    NFTDescriptor mRender;

    /* Initialize contract with initial supply tokens to the creator of the contract */
    constructor(
        string memory name,
        string memory symbol,
        NFTDescriptor render,
        address owner
    ) ERC721(name, symbol) {
        if (owner == address(0x0)) {
            transferOwnership(_msgSender());
        } else {
            transferOwnership(owner);
            _setupRole(DEFAULT_ADMIN_ROLE, owner);
        }
        _setupRole(DEFAULT_ADMIN_ROLE, _msgSender());
        mTokenId = 0;
        mRender = render;
        if (keccak256(bytes(name)) == keccak256("SkyLight New York Blonde")) {
            NFTDescriptor.ConstructTokenURIParams memory params = NFTDescriptor.ConstructTokenURIParams({
                tokenId: 0,
                name: "Sky Light New York Blonde",
                description: name,
                imageURL: "ipfs://QmYJhD8Uoj7CuBac9hKoWsKdVfBw1CtQP4ucS2P25kuvzm/",
                animationURL: "",
                externalURL: "https://sky-light-sl.com"
            });
            string memory baseImageURL = string(copyBytes(bytes(params.imageURL)));
            for (uint256 i = 0; i < 44; i++) {
                require(!minted[name], "Item already minted");
                NFTDescriptor.ConstructTokenURIParams memory _params = params;
                string memory itemNum = i.toString();
                if (i < 10) {
                    itemNum = string(abi.encodePacked("0", itemNum));
                }
                string memory n = string(abi.encodePacked(baseImageURL, itemNum, ".png"));
                _params.tokenId = mTokenId;
                _params.imageURL = n;
                _metadatas[mTokenId] = _params;
                minted[_params.name] = true;
                _mint(owner, mTokenId);
                mTokenId++;
            }
        } else if (keccak256(bytes(name)) == keccak256("S.peed L.ine")) {
            NFTDescriptor.ConstructTokenURIParams memory _params = NFTDescriptor.ConstructTokenURIParams({
                tokenId: 0,
                name: name,
                description: "< / S.ky L.ight  > vision < / S.peed L.ine  > collection < / S.uper L.ighters  > creation Monaco, May 2022 Formula 1 Grand Prix Series of seven unique art pieces",
                imageURL: "ipfs://Qmc9D8hC8LZbk8XxaZiJK1K9xje8pPuSuU3PZqFriGNGE8/F",
                animationURL: "",
                externalURL: "https://sky-light-sl.com"
            });
            string memory baseImageURL = string(copyBytes(bytes(_params.imageURL)));
            uint256 nu = 0;
            for (uint256 i = 0; i < 7; i++) {
                nu = nu * 10 + ((i % 2) + 1);
                string memory n = string(abi.encodePacked(baseImageURL, nu.toString(), "SL.glb"));
                _params.tokenId = nu;
                _params.imageURL = n;
                _metadatas[nu] = _params;
                minted[_params.name] = true;
                _mint(owner, nu);
                mTokenId++;
            }
        } else {
            revert("Invalid name");
        }
    }

    function copyBytes(bytes memory _bytes) private pure returns (bytes memory) {
        bytes memory copy = new bytes(_bytes.length);
        uint256 max = _bytes.length + 31;
        for (uint256 i = 32; i <= max; i += 32) {
            assembly {
                mstore(add(copy, i), mload(add(_bytes, i)))
            }
        }
        return copy;
    }

    function uintToString(uint256 v, bool pad) public pure returns (string memory str) {
        uint256 maxlength = 100;
        bytes memory reversed = new bytes(maxlength);
        uint256 i = 0;
        while (v != 0) {
            uint256 remainder = v % 10;
            v = v / 10;
            reversed[i++] = bytes1(uint8(48 + remainder));
        }
        bytes memory s = new bytes(i + 1);
        for (uint256 j = 0; j <= i; j++) {
            s[j] = reversed[i - j];
        }
        if (v < 10 && pad) str = string.concat("0", string(s));
        else str = string(s);
    }

    function setRender(address render) public {
        require(hasRole(DEFAULT_ADMIN_ROLE, _msgSender()), "Only ADMIN ROLE");
        // Changer SVG Renderer library (update)
        mRender = NFTDescriptor(render);
    }

    function mint(address to, NFTDescriptor.ConstructTokenURIParams calldata params) public {
        require(hasRole(DEFAULT_ADMIN_ROLE, _msgSender()), "ERC721: must have admin role to mint");
        require(!minted[params.name], "Item already minted");

        NFTDescriptor.ConstructTokenURIParams memory _params = params;

        _params.tokenId = mTokenId;
        _metadatas[mTokenId] = _params;
        minted[params.name] = true;
        _mint(to, mTokenId);
        mTokenId++;
    }

    /*
    // Input: Array of items names and ConstructTokenURIParams
    // Output: NFT ITEM minted corresponding to each F1
    */

    /*
    // Input: number from 0 to 43 and ConstructTokenURIParams
    // Output: NFT ITEM minted corresponding to {00..43}.png
    function mintBatchSLNYB(address[] to, NFTDescriptor.ConstructTokenURIParams[] calldata params) public {
    }
*/
    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        return mRender.constructTokenURI(_metadatas[tokenId]);
    }

    function setRoyalties(
        uint256 _tokenId,
        address payable _royaltiesReceipientAddress,
        uint96 _percentageBasisPoints
    ) public onlyOwner {
        LibPart.Part[] memory _royalties = new LibPart.Part[](1);
        _royalties[0].value = _percentageBasisPoints;
        _royalties[0].account = _royaltiesReceipientAddress;
        _saveRoyalties(_tokenId, _royalties);
    }

    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 tokenId
    ) internal virtual override(ERC721Enumerable) {
        super._beforeTokenTransfer(from, to, tokenId);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        virtual
        override(ERC721Enumerable, AccessControlEnumerable)
        returns (bool)
    {
        if (interfaceId == LibRoyaltiesV2._INTERFACE_ID_ROYALTIES) {
            return true;
        }
        return super.supportsInterface(interfaceId);
    }

    function SL() public pure returns (string memory) {
        return unicode"S†L";
    }
}
