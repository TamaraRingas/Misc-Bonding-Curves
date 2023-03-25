# LibEvents
[Git Source](https://github.com/TamaraRingas/Misc-Bonding-Curves/blob/ff25700444f7f4c67d29f4a0a36244531dce36c7/src/libraries/LibEvents.sol)


## Events
### CurveInitialized

```solidity
event CurveInitialized(uint256 timeout, uint256 startTime);
```

### CurveActivated

```solidity
event CurveActivated(uint256 time);
```

### CurveAddressSet

```solidity
event CurveAddressSet(address curve, address priceContract);
```

### CurvePaused

```solidity
event CurvePaused(uint256 time);
```

### MISCBought

```solidity
event MISCBought(int256 amountBought, address Buyer, uint256 timestamp);
```

### MISCSold

```solidity
event MISCSold(int256 amountSold, address Seller, uint256 timestamp);
```

### CurveInstanceCreated

```solidity
event CurveInstanceCreated(uint256 curveId, address curveAddress);
```

### MarketInstanceCreated

```solidity
event MarketInstanceCreated(uint256 marketInstance, address newMarketAddress);
```

### NFTStageSet

```solidity
event NFTStageSet(string currentNFTStage, uint256 time);
```

