pragma solidity ^0.6.7;

import "@chainlink/contracts/src/v0.6/interfaces/AggregatorV3Interface.sol";
//"SPDX-License-Identifier: <SPDX-License>"
//"SPDX-License-Identifier: UNLICENSED"

contract PriceConsumerV3 {

    AggregatorV3Interface internal priceFeed;

    /**
     * Network: Kovan
     * Aggregator: ETH/USD
     * Address: 0x9326BFA02ADD2366b30bacB125260Af641031331
     */
    constructor(address _feedAddress) public {
        priceFeed = AggregatorV3Interface(_feedAddress);
    }
    
    function updatePriceFeed(address _feedAddress) external {
        priceFeed = AggregatorV3Interface(_feedAddress); 
    }

    /**
     * Returns the latest price
     */
    function getThePrice() public view returns (int) {
        (
            uint80 roundID, 
            int price,
            uint startedAt,
            uint timeStamp,
            uint80 answeredInRound
        ) = priceFeed.latestRoundData();
        return price;
    }
}