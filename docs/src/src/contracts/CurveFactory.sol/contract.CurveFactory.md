# CurveFactory
[Git Source](https://github.com/TamaraRingas/Misc-Bonding-Curves/blob/ff25700444f7f4c67d29f4a0a36244531dce36c7/src/contracts/CurveFactory.sol)

**Inherits:**
[ICurveFactory](/src/interfaces/ICurveFactory.sol/interface.ICurveFactory.md)


## State Variables
### router

```solidity
IUniswapRouter2 router;
```


### curveInstances

```solidity
uint32 public curveInstances = 0;
```


### marketInstances

```solidity
uint32 public marketInstances = 0;
```


### curve

```solidity
Curve curve;
```


### formulaToContract
*Where:
0 = Ln
1 = Adapted Sin
=> Sin(x + A)/B + C
=> Default = Sin(x + (3pi/2))/2 + 0.5
2 = Adapted Cos 1
=> Cos(x + A)/B + C
=> Default = Cos(x)/2.5 + 0.5
3 = Adapted Cos 2 (Rapid Period)
=> Cos(Ax + B)/C + D
=> Default = Cos(3x)/2 + 0.6
4 = PieceWise (Straight Line)*


```solidity
mapping(uint8 => address) public formulaToContract;
```


### curveIdToAddress

```solidity
mapping(uint32 => address) public curveIdToAddress;
```


### curveToMarketTransition

```solidity
mapping(address => address) public curveToMarketTransition;
```


## Functions
### constructor


```solidity
constructor(address _routerAddress);
```

### getCurveAddress


```solidity
function getCurveAddress(uint256 _curveId) external view returns (address);
```

### getMarketAddress


```solidity
function getMarketAddress(address _curveAddress) external view returns (address);
```

### createBondingCurve


```solidity
function createBondingCurve(
    address _collateralAddress,
    address _miscAddress,
    address _nftAddress,
    address _treasuryAddress,
    address _uniswapRouter,
    address _marketTransition,
    uint8 _formula
) external onlyOwner returns (address[2] memory);
```

