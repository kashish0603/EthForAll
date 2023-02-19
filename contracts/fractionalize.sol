// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./payment.sol";
import "./MyToken.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC721/ERC721.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/Counters.sol";


contract fracplace is ERC721, IERC20, payment, MyToken {
    address payable public owner;
    mapping(uint256 => uint256) public prices;
    mapping(address => mapping(uint256 => uint256)) public balances;

    AggregatorV3Interface internal priceFeed;

    constructor() {
        owner = payable(msg.sender);
        priceFeed = AggregatorV3Interface(0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419); // Ethereum/USD price feed on mainnet
    }

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
    mapping (uint256 => address) public fractionalTokenAddresses;

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

    function generateFractionalTokenAddress(uint256 fractionalId) internal returns (address) {
        bytes32 hash = keccak256(abi.encodePacked(fractionalId, address(this), block.timestamp));
        address tokenAddress = address(uint160(uint256(hash)));
        fractionalTokenAddresses[fractionalId] = tokenAddress;
        return tokenAddress;
    }


    // function transferTokenOwnership(uint256 tId, address buyer, uint256 amount) internal {
    //     IERC20 token = IERC20(fracaddress);
    //     // address seller = ownerOf(tokenAddress);
    //     require(token.allowance(ownerof(fracaddress), address(this)) >= amount, "Marketplace does not have enough allowance");
    //     require(token.transferFrom(ownerof(fracaddress), buyer, amount), "Transfer failed");
    // }

    function buyFractionalNFT(uint256 fractionId, uint256 fractionAmount, uint256 tokenId, uint256 amount) public payable {
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
            uint256 tId = exchangeTokens(newFractionId);
            safeTransferFrom(address(this), msg.sender, tId);
            _fractionalNFTBuyers[fractionId].push(FractionalNFTBuyer({
                fractionId: newFractionId,
                fractionAmount: 1,
                buyer: msg.sender
            }));
        }

        require(msg.value == prices[tokenId] * amount, "Incorrect amount of ether sent");
        uint256 totalPrice1 = msg.value;

        (, int256 price, , , ) = priceFeed.latestRoundData();
        uint256 etherPrice = uint256(price) * 1e10; // Convert the price to wei
        uint256 usdPrice = etherPrice / 1e8; // Convert the price to USD
        uint256 usdTotalPrice = totalPrice / 1e18 * usdPrice; // Convert the total price to USD

        // Transfer the money to the owner of the fractional NFT
        balances[owner][tokenId] += amount;
        payable(owner).transfer(usdTotalPrice);    

        emit FractionalNFTBought(fractionId, fractionalNFT.tokenId, msg.sender, fractionAmount);

        
    }

    function getFractionalNFT(uint256 fractionId) public view returns (
        uint256 tokenId,
        address nftContract,
        uint256 pricePerFraction,
        uint256 totalFractions,
        uint256 totalSold,
        address owner1
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