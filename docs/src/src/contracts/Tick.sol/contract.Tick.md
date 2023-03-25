# Tick
[Git Source](https://github.com/TamaraRingas/Misc-Bonding-Curves/blob/ff25700444f7f4c67d29f4a0a36244531dce36c7/src/contracts/Tick.sol)


## State Variables
### FEE_LOW

```solidity
uint24 constant FEE_LOW = 500;
```


### FEE_MEDIUM

```solidity
uint24 constant FEE_MEDIUM = 3000;
```


### FEE_HIGH

```solidity
uint24 constant FEE_HIGH = 10000;
```


### TICK_LOW

```solidity
int24 constant TICK_LOW = 10;
```


### TICK_MEDIUM

```solidity
int24 constant TICK_MEDIUM = 60;
```


### TICK_HIGH

```solidity
int24 constant TICK_HIGH = 200;
```


### PRECISION

```solidity
uint256 constant PRECISION = 2 ** 96;
```


## Functions
### getMinTick


```solidity
function getMinTick(int24 tickSpacing) public pure returns (int24);
```

### getMaxTick


```solidity
function getMaxTick(int24 tickSpacing) public pure returns (int24);
```

### encodePriceSqrt


```solidity
function encodePriceSqrt(uint256 reserve1, uint256 reserve0) public pure returns (uint160);
```

### sqrt


```solidity
function sqrt(uint256 x) public pure returns (uint256 z);
```

