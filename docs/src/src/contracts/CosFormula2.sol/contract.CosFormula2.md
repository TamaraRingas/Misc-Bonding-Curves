# CosFormula2
[Git Source](https://github.com/TamaraRingas/Misc-Bonding-Curves/blob/ff25700444f7f4c67d29f4a0a36244531dce36c7/src/contracts/CosFormula2.sol)

**Inherits:**
[ICosFormula2](/src/interfaces/ICosFormula2.sol/interface.ICosFormula2.md), Ownable


## State Variables
### factory

```solidity
address factory;
```


### curve

```solidity
address curve;
```


## Functions
### constructor


```solidity
constructor(address _factory, address _curve);
```

### setCurveAddress


```solidity
function setCurveAddress(address _curveAddress) external onlyOwner;
```

### calculatePriceCos2

Determines the price for an input amount of MISC, in COLL.

*The price is calculated as the integral between the endPoint(The amount of tokens sold after the user has bought the input amount) and the startPoint(the amount of tokens bought before the quote was requested) along the shifted cos curve.*


```solidity
function calculatePriceCos2(uint256 _amountMISC, uint8 _tokenDecimals) external view returns (int256 price);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`_amountMISC`|`uint256`|- The amount of MISC the user wishes to recieve a quote for in COLL.|
|`_tokenDecimals`|`uint8`|- The amount of decimals of the input token, 18 for ETH and 6 for USDC.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`price`|`int256`|- The amount of COLL (scaled) to be transferred if the input amount of MISCtokens are bought.|


