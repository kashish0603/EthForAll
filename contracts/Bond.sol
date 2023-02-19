// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract Bond_minter {
    address payable[] public deployed_bonds;

    function createBond(string memory company, string memory symbl) public {
        address newBond = address(new Bond_NFT(company, symbl));
        deployed_bonds.push(payable(newBond));
    }

    function getDeplyedBonds() public view returns (address payable[] memory) {
        return deployed_bonds;
    }

}

contract Bond_NFT is ERC721, ERC721Enumerable, Ownable {
    
    uint256 public _interest;
    string public _description;
    uint256 _time_period;

    using Counters for Counters.Counter;

    Counters.Counter private _tokenIdCounter;

    constructor(string memory company, string memory symbl, uint256 interest, string memory description, uint256 time_period ) ERC721(company, symbl) {
        _interest = interest;
        _description = description;
        _time_period = time_periodl;
    }

    function safeMint(address to) public onlyOwner {    
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        _safeMint(to, tokenId);
    }

    // The following functions are overrides required by Solidity.

    function _beforeTokenTransfer(address from, address to, uint256 tokenId, uint256 batchSize)
        internal
        override(ERC721, ERC721Enumerable)
    {
        super._beforeTokenTransfer(from, to, tokenId, batchSize);
    }

    function supportsInterface(bytes4 interfaceId) public view override(ERC721, ERC721Enumerable) returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
}
