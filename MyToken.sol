// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC721/ERC721.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/IERC20.sol";

contract MyToken {
    // Mapping of ERC721 token ID to IERC20 token amount
    mapping (uint256 => uint256) private _tokenAmounts;
    uint256 totalSupply = 0;
    // Address of the IERC20 token contract
    address private _IERC20TokenAddress;

    constructor(address IERC20TokenAddress) {
        _IERC20TokenAddress = IERC20TokenAddress;
    }

    
    // Function to exchange IERC20 tokens for ERC721 tokens
    function exchangeTokens(uint256 amount) external returns(uint256) {
        // Transfer the specified amount of IERC20 tokens to this contract
        IERC20 IERC20Token = IERC20(_IERC20TokenAddress);
        IERC20Token.transferFrom(msg.sender, address(this), amount);

        // Mint a new ERC721 token and associate it with the specified amount of IERC20 tokens
        uint256 tokenId = totalSupply + 1;
        _safeMint(msg.sender, tokenId);
        _tokenAmounts[tokenId] = amount;
        return tokenId;
    }

    // Function to get the amount of IERC20 tokens associated with a particular ERC721 token ID
    // function getTokenAmount(uint256 tokenId) external view returns (uint256) {
    //     require(_exists(tokenId), "Token does not exist");
    //     return _tokenAmounts[tokenId];
    // }
}
