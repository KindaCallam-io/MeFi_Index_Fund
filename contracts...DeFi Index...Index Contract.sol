// This example code is designed to quickly deploy an example contract using Remix.

pragma solidity ^0.6.7;

import "https://github.com/smartcontractkit/chainlink/blob/master/evm-contracts/src/v0.6/interfaces/AggregatorV3Interface.sol";

contract Index {

    struct CoinList {
        AggregatorV3Interface[4] feeds; 
        uint length;
        uint smallestIndex;
        uint maxIndex; 
    }


    CoinList internal coins; 
    AggregatorV3Interface internal priceFeed;
    AggregatorV3Interface[4] feeds;
    
    /**
     * Network: Kovan
     * Aggregator: ETH/USD
     * Address: 0x9326BFA02ADD2366b30bacB125260Af641031331
     */
    constructor() public {       
        
        feeds[0] = AggregatorV3Interface(0x9326BFA02ADD2366b30bacB125260Af641031331);
        feeds[1] = AggregatorV3Interface(0x9326BFA02ADD2366b30bacB125260Af641031331);
        feeds[2] = AggregatorV3Interface(0x9326BFA02ADD2366b30bacB125260Af641031331);
        feeds[3] = AggregatorV3Interface(0x9326BFA02ADD2366b30bacB125260Af641031331); 
        
        coins = CoinList(feeds,0, 0, 3);
        priceFeed = coins.feeds[0]; 
    }

    /**
     * Returns the latest price
     */
    function getLatestPrice() public view returns (int) {
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


