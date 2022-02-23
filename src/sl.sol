// SPDX-License-Identifier: AGPL-3.0

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

contract MIRE is Context, ERC721Enumerable, Ownable, RoyaltiesV2Impl, AccessControlEnumerable {
    using NFTDescriptor for NFTDescriptor.ConstructTokenParams;
    using NFTDescriptor for NFTDescriptor.ConstructContractURIParams;
    mapping(uint256 => NFTDescriptor.ConstructTokenParams) _metadatas;

    uint256 mTokenId;
    NFTDescriptor.ConstructContractURIParams contractMetadata;

    /* Initializes contract with initial supply tokens to the creator of the contract */
    constructor() ERC721("MIRE", unicode"M†RE") {
        transferOwnership(_msgSender());
        _setupRole(DEFAULT_ADMIN_ROLE, _msgSender());
        mTokenId = 0;
    }

    function mint(address to, NFTDescriptor.ConstructTokenParams calldata params) public {
        NFTDescriptor.ConstructTokenParams memory _params = params;

        _params.tokenId = mTokenId;
        _params.value = 70000 - mTokenId;
        _metadatas[mTokenId] = _params;
        _mint(to, mTokenId);
        mTokenId++;
    }

    function tokenURI(uint256 tokenId) public view override returns (string memory) {
    // CUSTOM RH.v0
        //ret = call hypebears.tokenURI(_metadatas[tokenId].tokenIdHypebear)
        // extract URL to set internal URL
        // set rendered imageURL
        // set rendered externalURL
        // set rendered contract description if different than hash(contractMetadata.current)
        // set rendered tokenId
    // END CUSTOM RH.v0
        return _metadatas[tokenId].constructTokenURI(name());
    }

    // CUSTOM RH.v0
    //  function setHypeBearID ID
    //    // value = value - 1
    //    // set _metadatas[tokenId]._metadatas[tokenId].tokenIdHypbear = ID
    // END CUSTOM RH.v0


    // Rarrible roylaties informations
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

    // OpenSea contract metadata info
    function contractURI() public view returns (string memory) {
        return contractMetadata.constructContractURI(name());
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
}
