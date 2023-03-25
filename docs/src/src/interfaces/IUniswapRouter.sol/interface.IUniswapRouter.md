# IUniswapRouter
[Git Source](https://github.com/TamaraRingas/Misc-Bonding-Curves/blob/ff25700444f7f4c67d29f4a0a36244531dce36c7/src/interfaces/IUniswapRouter.sol)


## Functions
### transferOwner


```solidity
function transferOwner(address _newOwner) external;
```

### setPoolFee


```solidity
function setPoolFee(uint24 _fee) external;
```

### collectAllFees


```solidity
function collectAllFees(uint256 tokenId) external returns (uint256 amount0, uint256 amount1);
```

### getTokensToMint


```solidity
function getTokensToMint(address _transition) external returns (int256 amount);
```

### getQuote


```solidity
function getQuote(address _tokenIn, address _tokenOut, uint256 _amountIn) external returns (uint256 amountOut);
```

### createPool


```solidity
function createPool(address token0, address token1, uint256 amount0, uint256 amount1)
    external
    returns (address, uint256);
```

### swapCOLLATERALForMISC


```solidity
function swapCOLLATERALForMISC(uint256 _amountIn) external returns (uint256 amountOut);
```

### swapMISCforUSDC


```solidity
function swapMISCforUSDC(uint256 _amountIn) external isActive returns (uint256 amountOut);
```

