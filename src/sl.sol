// SPDX-License-Identifier: AGPL-3.0

pragma solidity ^0.8.0;

import "@openzeppelin/contracts-upgradeable/token/ERC721/ERC721Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC721/extensions/ERC721EnumerableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/access/AccessControlEnumerableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/utils/ContextUpgradeable.sol";
import "./@rarible/royalties/contracts/impl/RoyaltiesV2Impl.sol";
import "./@rarible/royalties/contracts/LibPart.sol";
import "./@rarible/royalties/contracts/LibRoyaltiesV2.sol";
import "./NFTDescriptor.sol";

/**
 * @title ERC-721 Non-Fungible Token Standard, optional metadata tokenURI extension only
 * @dev See https://eips.ethereum.org/EIPS/eip-721
 */
interface IERC721MetadataTokenURI {
    /**
     * @dev Returns the Uniform Resource Identifier (URI) for `tokenId` token.
     */
    function tokenURI(uint256 tokenId) external view returns (string memory);
}

contract MIRE is ERC721EnumerableUpgradeable, RoyaltiesV2Impl, AccessControlEnumerableUpgradeable {
    using NFTDescriptor for NFTDescriptor.ConstructTokenParams;
    using NFTDescriptor for NFTDescriptor.ConstructContractURIParams;

    mapping(uint256 => IERC721MetadataTokenURI) cloneMappingAddress;
    mapping(uint256 => uint256) cloneMappingId;
    mapping(uint256 => uint256) cloneMappingValue;

    uint256 mTokenId;
    NFTDescriptor.ConstructContractURIParams contractMetadata;
    uint256 public version;

    /* Initializes contract with initial supply tokens to the creator of the contract */
    function init() public initializer {
        __ERC721_init("MIRE", unicode"M†RE");
        __ERC721Enumerable_init_unchained();
        __AccessControlEnumerable_init_unchained();

        _setupRole(DEFAULT_ADMIN_ROLE, _msgSender());
        mTokenId = 0;
        version = 0;
    }

    function upgrade() public {
        mTokenId = 0;
        version = 0;
    }

    function mint(address to, address cloneContract, uint256 cloneId) public onlyRole(DEFAULT_ADMIN_ROLE) {
        cloneMappingValue[mTokenId] = 42 - mTokenId;

        cloneMappingAddress[mTokenId] = IERC721MetadataTokenURI(cloneContract);
        cloneMappingId[mTokenId] = cloneId;

        _mint(to, mTokenId);
        // if contractMetadata.royaltiesFeeBasisPoints > 0
        // setRoyalties (mTokenId, params.royaltiesRecipient, uint96(params.royaltiesFeeBasisPoints))
        mTokenId++;
        //require valid tokenURI (so far length > 0)
    }

    function updateClone(uint256 tokenId, address _cloneContract, uint256 cloneId) public {
        // reward for cleaning up space
        require(ownerOf(tokenId) == _msgSender());

        uint256 decayCount = cloneMappingValue[tokenId];
        require(decayCount > 1);

        cloneMappingValue[tokenId] = decayCount - 1;

        IERC721MetadataTokenURI cloneContract = IERC721MetadataTokenURI(_cloneContract);
        cloneMappingAddress[tokenId] = cloneContract;
        cloneMappingId[tokenId] = cloneId;

        bytes memory tokenURIData = bytes(cloneMappingAddress[tokenId].tokenURI(cloneId));
        require(tokenURIData.length > 0); // check for actual validity of the content
    }

    function tokenURI(uint256 tokenId) public view override returns (string memory) {
    // CUSTOM RH.v0
        //ret = call NFT.tokenURI(_metadatas[tokenId].tokenIdNFT)
        // extract URL to set internal URL
        // set rendered imageURL
        // set rendered externalURL
        // set rendered contract description if different than hash(contractMetadata.current)
        // set rendered tokenId
    // END CUSTOM RH.v0
        return cloneMappingAddress[tokenId].tokenURI(cloneMappingId[tokenId]);
    }

    // CUSTOM RH.v1
    //  function setNFTAddrAndID ID
    //    // set Addr & tokenID
    //    // value = value - 1
    //    // set _metadatas[tokenId]._metadatas[tokenId].tokenIdHypbear = ID
    // END CUSTOM RH.v1


    // Rarrible & OpenSea roylaties informations
    function setRoyalties(
        uint256 _tokenId,
        address payable _royaltiesReceipientAddress,
        uint96 _percentageBasisPoints
    ) public onlyRole(DEFAULT_ADMIN_ROLE) {
        LibPart.Part[] memory _royalties = new LibPart.Part[](1);
        _royalties[0].value = _percentageBasisPoints;
        _royalties[0].account = _royaltiesReceipientAddress;
        _saveRoyalties(_tokenId, _royalties);
    }

    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 tokenId
    ) internal virtual override(ERC721EnumerableUpgradeable) {
        super._beforeTokenTransfer(from, to, tokenId);
    }

    // OpenSea contract metadata info
    function contractURI() public view returns (string memory) {
        return contractMetadata.constructContractURI(name());
    }
    
    // Set contract information, royalties and such
    function setContractURI(NFTDescriptor.ConstructContractURIParams memory params) public onlyRole(DEFAULT_ADMIN_ROLE) {
      contractMetadata = params;
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        virtual
        override(ERC721EnumerableUpgradeable, AccessControlEnumerableUpgradeable)
        returns (bool)
    {
        if (interfaceId == LibRoyaltiesV2._INTERFACE_ID_ROYALTIES) {
            return true;
        }
        return super.supportsInterface(interfaceId);
    }
}
