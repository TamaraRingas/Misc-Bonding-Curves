# CosFormula1
[Git Source](https://github.com/TamaraRingas/Misc-Bonding-Curves/blob/ff25700444f7f4c67d29f4a0a36244531dce36c7/src/contracts/CosFormula1.sol)

**Inherits:**
[ICosFormula1](/src/interfaces/ICosFormula1.sol/interface.ICosFormula1.md), Ownable

The formula for this curve is cos(x + pi)/2 + 0.6

This curve oscillates between a price of 0.1 & 1.1


## State Variables
### curve

```solidity
address curve;
```


## Functions
### setCurveAddress


```solidity
function setCurveAddress(address _curveAddress) external onlyOwner;
```

### calculatePriceCos1

Determines the price for an input amount of MISC, in COLL, along the bonding curve with the formula => Cos(x)/2.5 + 0.5

*The price is calculated as the integral between the endPoint(The amount of tokens sold after the user has bought the input amount) and the startPoint(the amount of tokens bought before the quote was requested) along the shifted cos curve.
The integral of Cos(x)/2.5 + 0.5 is 2(Sin(x))/5 + x/2*


```solidity
function calculatePriceCos1(uint256 _amountMISC, uint8 _tokenDecimals) external view returns (int256 price);
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


