// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

/*
  _______     _______ _   _ _____ ____  
 | ____\ \   / / ____| \ | |_   _/ ___| 
 |  _|  \ \ / /|  _| |  \| | | | \___ \ 
 | |___  \ V / | |___| |\  | | |  ___) |
 |_____|  \_/  |_____|_| \_| |_| |____/ 
***************************************/

library LibEvents {

    event CurveInitialized(uint256 timeout, uint256 startTime);

    event CurveActivated(uint256 time);

    event CurveAddressSet(address curve, address priceContract);
    
    event CurvePaused(uint256 time);

    event MISCBought(int256 amountBought, address Buyer, uint256 timestamp);

    event MISCSold(int256 amountSold, address Seller, uint256 timestamp);

    event CurveInstanceCreated(uint256 curveId, address curveAddress);

    event MarketInstanceCreated(
        uint256 marketInstance,
        address newMarketAddress
    );

    event NFTStageSet(string currentNFTStage, uint256 time);
}