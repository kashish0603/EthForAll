// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./BondNFT.sol";

contract BondBuyer {
    address public owner;
    BondNFT public bondNFT;

    constructor(address _bondNFTAddress) {
        owner = msg.sender;
        bondNFT = BondNFT(_bondNFTAddress);
    }

    function buyBond(uint256 _bondId) external payable {
        require(msg.value == bondNFT.getBondPrice(_bondId), "Invalid bond price");

        bondNFT.safeTransferFrom(address(this), msg.sender, _bondId);

        // Associate the bond with the buyer
        bondNFT.setBondHolder(_bondId, msg.sender);

        // Calculate and store the interest rate and payment dates for the bond
        uint256 interestRate = bondNFT.getBondInterestRate(_bondId);
        uint256 paymentInterval = bondNFT.getBondPaymentInterval(_bondId);
        uint256 paymentStartDate = block.timestamp + paymentInterval;

        bondNFT.setBondInterest(_bondId, interestRate, paymentInterval, paymentStartDate);
    }

    function sellBond(uint256 _bondId, uint256 _price) external {
        require(bondNFT.ownerOf(_bondId) == msg.sender, "Not bond owner");

        bondNFT.safeTransferFrom(msg.sender, address(this), _bondId);
        bondNFT.setBondHolder(_bondId, address(0));
        bondNFT.setBondInterest(_bondId, 0, 0, 0);

        (bool success, ) = msg.sender.call{value: _price}("");
        require(success, "Failed to send payment");
    }

    function claimInterest(uint256 _bondId) external {
        require(bondNFT.getBondHolder(_bondId) == msg.sender, "Not bond holder");
        require(block.timestamp >= bondNFT.getBondNextPaymentDate(_bondId), "Payment not due");

        uint256 interestAmount = bondNFT.calculateInterest(_bondId);
        uint256 paymentInterval = bondNFT.getBondPaymentInterval(_bondId);
        uint256 paymentStartDate = bondNFT.getBondNextPaymentDate(_bondId) + paymentInterval;

        bondNFT.setBondInterest(_bondId, bondNFT.getBondInterestRate(_bondId), paymentInterval, paymentStartDate);

        (bool success, ) = msg.sender.call{value: interestAmount}("");
        require(success, "Failed to send interest payment");
    }
}
