// SPDX-License-Identifier: MIT
 pragma solidity ^0.8.19;
 import { ERC20Token } from "./Token.sol";
import "../lib/solmate/src/tokens/ERC721.sol";


contract NFTMarketplace {

    // Define the NFT contract
    ERC721 public nftContract;
    ERC20Token public erctoken;
    address vaultPlatform;

    struct Listing {
        uint256 tokenId;
        uint256 price;
        address seller;
        bool active;
        uint balance;
    }
    constructor(address _nftContract) {
        erctoken = new ERC20Token(); 
        nftContract = ERC721(_nftContract);
    }

    uint fractionPrice = 0.01 ether;
    uint fractionsToWhole = 100;
    uint wholeNFT = 1 ether;
    mapping(uint256 => Listing) public listings;

    event NFTListed(uint256 indexed tokenId, address indexed seller, uint256 price);
    event NFTSold(uint256 indexed tokenId, address indexed buyer, uint256 price);

    // constructor(address _nftContract) {
    //     nftContract = ERC721(_nftContract);
    // }

    function listNFT(uint256 _tokenId, uint256 _price) external {
        require(nftContract.ownerOf(_tokenId) == msg.sender, "You do not own this NFT");
        require(!listings[_tokenId].active, "NFT is already listed");

        listings[_tokenId] = Listing({
            tokenId: _tokenId,
            seller: msg.sender,
            price: _price,
            active: true,
            balance: 0
        });

        emit NFTListed(_tokenId, msg.sender, _price);
    }

    function purchaseOneFractionNFT(uint256 _tokenId) external payable {
        Listing storage listing = listings[_tokenId];
        require(listing.active, "NFT is not listed");
        require(msg.value == fractionPrice, "Insufficient funds sent");

        address seller = listing.seller;
        listing.balance += msg.value;
        uint charges = 1 * listing.balance / 10;
        uint listingFee = charges;
        uint sellermoney = listing.balance - charges;
        ERC20Token(seller).mint(msg.sender, 100 wei);
        payable(seller).transfer(sellermoney);
        payable(vaultPlatform).transfer(listingFee);

        listing.active = false;
    }
    function purchaseWholeNFT(uint256 _tokenId) public payable {
         Listing storage listing = listings[_tokenId];
        require(listing.active, "NFT is not listed");
        require(msg.value == wholeNFT, "Insufficient funds sent");

        address seller = listing.seller;
        listing.balance += msg.value;

        nftContract.safeTransferFrom(seller, msg.sender, _tokenId);
        ERC20Token(seller).mint(msg.sender, 1e18);
        uint charges = 1 * listing.balance / 10;
        uint listingFee = charges;
        uint sellermoney = listing.balance - charges;
        payable(seller).transfer(sellermoney);
        payable(vaultPlatform).transfer(listingFee);
        listing.active = false;
    }

}
