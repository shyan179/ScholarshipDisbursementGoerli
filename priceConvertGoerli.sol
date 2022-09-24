// SPDX-License-Identifier: MIT
pragma solidity >= 0.8.0 <0.9.0;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract PriceConversion {

    AggregatorV3Interface internal priceFeed;

    /**
     * Network: Goerli
     * Aggregator: ETH/USD
     * Address: 0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e
     */
    constructor() {
        priceFeed = AggregatorV3Interface(0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e);
    }

    /**
     * Returns the latest price
     */
    function getLatestPrice() public view returns (uint256) {
        (
            /*uint80 roundID*/,
            int256 price,
            /*uint startedAt*/,
            /*uint timeStamp*/,
            /*uint80 answeredInRound*/
        ) = priceFeed.latestRoundData();
        return uint256(price);
    }

    function getUSDWEI(uint256 _number) external view returns (uint256) {
        uint256 input = _number;
        uint256 priceETH = getLatestPrice();
        uint256 price = (input*100000000000000000000000000/priceETH);
        return price;
    }
}