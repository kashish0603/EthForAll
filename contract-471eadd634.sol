// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts@4.8.1/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts@4.8.1/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts@4.8.1/access/Ownable.sol";
import "@openzeppelin/contracts@4.8.1/token/ERC20/extensions/draft-ERC20Permit.sol";
import "@openzeppelin/contracts@4.8.1/token/ERC721/utils/ERC721Holder.sol";

contract MyToken is ERC20, Ownable, ERC20Permit, ERC721Holder {
    IERC721 public collection; //address of the NFT we want to fractionalize
    uint256 public tokenId; //tokenId of NFT we want to fractionalize
    bool public initialized = false; //so that the owner can't call the initialized function again and again
    bool public forSale = false;
    uint256 public salePrice;
    bool public canRedeem = false;
    constructor() ERC20("MyToken", "MTK") ERC20Permit("MyToken") {}

    function initialize(address _collection, uint256 _tokenId, uint256 _amount) external onlyOwner{ //before calling this function the owner needs to allow this contract to be the operator for the NFT so that the contract can fetch the NFT
        require(!initialized, "Already initialized");
        require(_amount > 0);
        collection = IERC721(_collection);
        collection.safeTransferFrom(msg.sender, address(this), _tokenId); //msg.sender = person who holds the NFT
        tokenId = _tokenId;
        initialized = true;
        _mint(msg.sender, _amount); //minting ERC20 tokens and sending all the tokens to the person who holds the NFT, -amount = amount of tokens the user wants to mint
    } //after the user has these tokens, can create a liquidity pool, list it on exchanges 

    function putForSale(uint256 price) external onlyOwner{ //amount that NFT should be sold for
        salePrice = price;
        forSale = true;
    }

    function purchase() external payable {
        require(forSale, "Not for Sale");
        require(msg.value > salePrice, "Not enough ether sent");
        collection.transferFrom(address(this), msg.sender, tokenId);
        forSale = false;
        canRedeem = true;
    }

    function redeem(uint256 _amount) external {
        require(canRedeem, "Redemption not available");
        uint256 totalEther = address(this).balance;
        uint256 toRedeem = _amount * totalEther / totalSupply();
        //first we burn the ERC-20 tokens then we transfer the eth to the user. If not done in this order,there can be re-entrancy attack 
        _burn(msg.sender, _amount); //checks whether the user has that much amount to burn otherwise gives error
        payable(msg.sender).transfer(toRedeem);
         
    }
    // function mint(address to, uint256 amount) public onlyOwner {
    //     _mint(to, amount);
    // }
}
