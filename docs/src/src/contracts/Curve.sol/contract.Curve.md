# Curve
[Git Source](https://github.com/TamaraRingas/Misc-Bonding-Curves/blob/ff25700444f7f4c67d29f4a0a36244531dce36c7/src/contracts/Curve.sol)

**Inherits:**
[ICurve](/src/interfaces/ICurve.sol/interface.ICurve.md)


## State Variables
### maxThreshold

```solidity
int256 maxThreshold;
```


### minThreshold

```solidity
int256 minThreshold;
```


### tokensSold

```solidity
int256 tokensSold;
```


### treasuryFee

```solidity
int256 treasuryFee;
```


### startTime

```solidity
uint256 startTime;
```


### timeoutPeriod

```solidity
uint256 timeoutPeriod;
```


### timeoutPeriodExpiry

```solidity
uint256 timeoutPeriodExpiry;
```


### curveActive

```solidity
bool public curveActive;
```


### transitionConditionsMet

```solidity
bool public transitionConditionsMet;
```


### transitioned

```solidity
bool public transitioned;
```


### curveInitialized

```solidity
bool public curveInitialized;
```


### nftAccessSet

```solidity
bool public nftAccessSet;
```


### uniswapRouter

```solidity
address uniswapRouter;
```


### marketTransition

```solidity
address marketTransition;
```


### treasury

```solidity
address treasury;
```


### COLL

```solidity
IERC20 COLL;
```


### misc

```solidity
MISC misc;
```


### nft

```solidity
IERC1155 nft;
```


## Functions
### isActive


```solidity
modifier isActive();
```

### isEligible

Checks if a user is whitelisted for the current sale round

*Gets the currentnftStage and checks if the user has a balance of the correcponding nft in their wallet*


```solidity
modifier isEligible();
```

### constructor


```solidity
constructor(
    address _collateralAddress,
    address _miscAddress,
    address _nftAddress,
    address _treasuryAddress,
    address _uniswapRouter,
    address _marketTransition,
    address _priceCurve
);
```

### initializeCurve


```solidity
function initializeCurve(bool _nftAccessSet, int256 _maxThreshold, int256 _minThreshold, uint256 _timeoutPeriod)
    external
    onlyOwner;
```

### pauseCurve


```solidity
function pauseCurve() public;
```

### activateCurve


```solidity
function activateCurve() public onlyOwner;
```

### getFee


```solidity
function getFee(int256 _price, int256 _percentFee) public pure returns (int256 fee);
```

### getTokensSold


```solidity
function getTokensSold() external view returns (uint256 tokensSold);
```

### getMarketTransitionAddress


```solidity
function getMarketTransitionAddress() public view returns (address);
```

### buyMISC


```solidity
function buyMISC(uint256 amount) external isEligible isActive;
```

### sellMISC


```solidity
function sellMISC(uint256 amount) external isEligible isActive;
```

