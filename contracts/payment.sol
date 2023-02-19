// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@chainlink/contracts/src/v0.8/ChainlinkClient.sol";
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract payment is ChainlinkClient {
    using Chainlink for Chainlink.Request;
    uint256 public paymentAmount;
    address public companyWallet;
    address public nftContractAddress;
    uint256 public nftTokenId;
    uint256 public nftFraction;
    bool public paymentComplete;

    function getLatestPrice(address _tokenPriceFeed) public view returns (int) {
        AggregatorV3Interface priceFeed = AggregatorV3Interface(
            _tokenPriceFeed
        );
        // prettier-ignore
        (
            /* uint80 roundID */,
            int price,
            /*uint startedAt*/,
            /*uint timeStamp*/,
            /*uint80 answeredInRound*/
        ) = priceFeed.latestRoundData();
        return price;
    }

    // Set the job ID
    bytes32 public constant jobID = bytes32("your_job_id_here");

    // Set the Chainlink oracle address
    address public constant oracle = 0x1234567890123456789012345678901234567890;

    // Set the fee (in LINK tokens)
    uint256 public constant fee = 1 * 10 ** 18; // 1 LINK token


    constructor(address _companyWallet, address _nftContractAddress, uint256 _nftTokenId, uint256 _nftFraction) {
        setPublicChainlinkToken();
        companyWallet = _companyWallet;
        nftContractAddress = _nftContractAddress;
        nftTokenId = _nftTokenId;
        nftFraction = _nftFraction;
        paymentComplete = false;
    }

    function setPaymentAmount(uint256 amount) public {
        require(!paymentComplete, "Payment already complete");
        paymentAmount = amount;
    }

    function requestPayment() public {
        require(!paymentComplete, "Payment already complete");

        Chainlink.Request memory request = buildChainlinkRequest(
            jobID,
            address(this),
            this.fulfillPayment.selector
        );
        request.add("get", "https://api.example.com/payment");
        request.add("path", "amount");

        sendChainlinkRequestTo(oracle, request, fee);
    }

    function fulfillPayment(bytes32 _requestId, uint256 _payment) public recordChainlinkFulfillment(_requestId) {
        require(msg.sender == oracle, "Fulfillment only allowed from Chainlink oracle");

        if (_payment == paymentAmount) {
            // Transfer fractional NFT to buyer
            // IERC721(nftContractAddress).safeTransferFrom(address(this), msg.sender, nftTokenId, nftFraction, "");

            // Send payment to company wallet
            payable(companyWallet).transfer(paymentAmount);

            // Set payment as complete
            paymentComplete = true;
        }
    }
}