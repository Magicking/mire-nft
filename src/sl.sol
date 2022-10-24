// SPDX-License-Identifier: AGPL-3.0
// https://github.com/Magicking/S.ky-L.ight-NFT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/AccessControlEnumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Context.sol";
import "./@rarible/royalties/contracts/impl/RoyaltiesV2Impl.sol";
import "./@rarible/royalties/contracts/LibPart.sol";
import "./@rarible/royalties/contracts/LibRoyaltiesV2.sol";
import "./NFTDescriptor.sol";

contract SkyLight is Context, ERC721Enumerable, Ownable, RoyaltiesV2Impl, AccessControlEnumerable {
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

    function SL() public returns (string memory) {
        return unicode"S†L";
    }
}
