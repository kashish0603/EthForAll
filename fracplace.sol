// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC721/ERC721.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/Counters.sol";

contract FractionalNFTMarketplace {
    using SafeMath for uint256;
    using Counters for Counters.Counter;

    Counters.Counter private _itemIds;
    Counters.Counter private _fractionIds;

    struct FractionalNFT {
        uint256 fractionId;
        uint256 tokenId;
        address nftContract;
        uint256 pricePerFraction;
        uint256 totalFractions;
        uint256 totalSold;
        address payable owner;
    }

    mapping (uint256 => FractionalNFT) private _fractionalNFTs;

    struct FractionalNFTBuyer {
        uint256 fractionId;
        uint256 fractionAmount;
        address buyer;
    }

    mapping (uint256 => FractionalNFTBuyer[]) private _fractionalNFTBuyers;

    event FractionalNFTCreated(
        uint256 indexed fractionId,
        uint256 indexed tokenId,
        address indexed nftContract,
        uint256 pricePerFraction,
        uint256 totalFractions,
        address owner
    );

    event FractionalNFTBought(
        uint256 indexed fractionId,
        uint256 indexed tokenId,
        address indexed buyer,
        uint256 fractionAmount
    );

    function createFractionalNFT(
        address nftContract,
        uint256 tokenId,
        uint256 pricePerFraction,
        uint256 totalFractions
    ) public {
        require(totalFractions > 1, "Total fractions must be greater than 1");
        require(pricePerFraction > 0, "Price per fraction must be greater than 0");

        ERC721 nft = ERC721(nftContract);
        require(nft.ownerOf(tokenId) == msg.sender, "Only the owner can create fractional NFTs");

        _itemIds.increment();
        uint256 fractionId = _itemIds.current();

        FractionalNFT memory fractionalNFT = FractionalNFT({
            fractionId: fractionId,
            tokenId: tokenId,
            nftContract: nftContract,
            pricePerFraction: pricePerFraction,
            totalFractions: totalFractions,
            totalSold: 0,
            owner: payable(msg.sender)
        });

        _fractionalNFTs[fractionId] = fractionalNFT;
        nft.safeTransferFrom(msg.sender, address(this), tokenId);

        emit FractionalNFTCreated(
            fractionId,
            tokenId,
            nftContract,
            pricePerFraction,
            totalFractions,
            msg.sender
        );
    }

    function buyFractionalNFT(uint256 fractionId, uint256 fractionAmount) public {
        FractionalNFT storage fractionalNFT = _fractionalNFTs[fractionId];
        require(fractionalNFT.fractionId > 0, "Fractional NFT does not exist");
        require(fractionAmount > 0, "Fraction amount must be greater than 0");
        require(fractionalNFT.totalSold.add(fractionAmount) <= fractionalNFT.totalFractions, "Not enough fractions left for sale");
        uint256 totalPrice = fractionalNFT.pricePerFraction.mul(fractionAmount);
        IERC20 paymentToken = IERC20(fractionalNFT.nftContract);

        require(paymentToken.allowance(msg.sender, address(this)) >= totalPrice, "Not enough payment token allowance");
        require(paymentToken.transferFrom(msg.sender, address(this), totalPrice), "Payment token transfer failed");

        fractionalNFT.totalSold = fractionalNFT.totalSold.add(fractionAmount);

        for (uint256 i = 0; i < fractionAmount; i++) {
            _fractionIds.increment();
            uint256 newFractionId = _fractionIds.current();

            _fractionalNFTBuyers[fractionId].push(FractionalNFTBuyer({
                fractionId: newFractionId,
                fractionAmount: 1,
                buyer: msg.sender
            }));
        }

        if (fractionalNFT.totalSold == fractionalNFT.totalFractions) {
            ERC721 nft = ERC721(fractionalNFT.nftContract);

            for (uint256 i = 0; i < fractionalNFT.totalFractions; i++) {
                FractionalNFTBuyer memory fractionalNFTBuyer = _fractionalNFTBuyers[fractionId][i];
                nft.safeTransferFrom(address(this), fractionalNFTBuyer.buyer, fractionalNFT.tokenId);
            }

            fractionalNFT.owner.transfer(address(this).balance);
        }

        

        emit FractionalNFTBought(fractionId, fractionalNFT.tokenId, msg.sender, fractionAmount);

        
    }

    function getFractionalNFT(uint256 fractionId) public view returns (
        uint256 tokenId,
        address nftContract,
        uint256 pricePerFraction,
        uint256 totalFractions,
        uint256 totalSold,
        address owner
    ) {
        FractionalNFT storage fractionalNFT = _fractionalNFTs[fractionId];
        require(fractionalNFT.fractionId > 0, "Fractional NFT does not exist");

        return (
            fractionalNFT.tokenId,
            fractionalNFT.nftContract,
            fractionalNFT.pricePerFraction,
            fractionalNFT.totalFractions,
            fractionalNFT.totalSold,
            fractionalNFT.owner
        );
    }

    function getFractionalNFTBuyers(uint256 fractionId) public view returns (FractionalNFTBuyer[] memory) {
        return _fractionalNFTBuyers[fractionId];
    }
}

       
