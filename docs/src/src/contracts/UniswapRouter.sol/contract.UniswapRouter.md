# UniswapRouter
[Git Source](https://github.com/TamaraRingas/Misc-Bonding-Curves/blob/ff25700444f7f4c67d29f4a0a36244531dce36c7/src/contracts/UniswapRouter.sol)

**Inherits:**
IERC721Receiver, [Tick](/src/contracts/Tick.sol/contract.Tick.md)


## State Variables
### SWAP_ROUTER

```solidity
address private constant SWAP_ROUTER = 0xE592427A0AEce92De3Edee1F18E0157C05861564;
```


### pool

```solidity
address pool;
```


### owner

```solidity
address public owner;
```


### curveToPool

```solidity
mapping(address => address) curveToPool;
```


### COLL

```solidity
IERC20 COLL;
```


### MISC

```solidity
IERC20 MISC;
```


### poolFee

```solidity
uint24 public poolFee;
```


### poolActive

```solidity
bool public poolActive;
```


### factory

```solidity
IUniswapV3Factory factory = IUniswapV3Factory(0x1F98431c8aD98523631AE4a59f267346ea31F984);
```


### manager

```solidity
INonfungiblePositionManager public immutable manager;
```


### swapRouter

```solidity
ISwapRouter swapRouter = ISwapRouter(SWAP_ROUTER);
```


### quoter

```solidity
IQuoter quoter = IQuoter(0xb27308f9F90D607463bb33eA1BeBb41C27CE5AB6);
```


### deposits
*deposits[tokenId] => Deposit*


```solidity
mapping(uint256 => Deposit) public deposits;
```


## Functions
### isActive


```solidity
modifier isActive();
```

### onlyOwner


```solidity
modifier onlyOwner();
```

### constructor


```solidity
constructor(INonfungiblePositionManager _nonfungiblePositionManager, address _COLLATERAL, address _MISC);
```

### transferOwner


```solidity
function transferOwner(address _newOwner) public onlyOwner;
```

### setPoolFee


```solidity
function setPoolFee(uint24 _fee) external onlyOwner;
```

### pausePool


```solidity
function pausePool() external onlyOwner;
```

### activatePool


```solidity
function activatePool() external onlyOwner;
```

### getTokensToMint


```solidity
function getTokensToMint(address _transition) internal returns (int256 amount);
```

### increaseLiquidityCurrentRange

A function that decreases the current liquidity. An example to show how to call the `decreaseLiquidity` function defined in periphery.

Increases liquidity in the current range, User must approve this router for the amounts

*Pool must be initialized already to add liquidity*


```solidity
function increaseLiquidityCurrentRange(uint256 tokenId, uint256 amountAdd0, uint256 amountAdd1)
    external
    returns (uint128 liquidity, uint256 amount0, uint256 amount1);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`tokenId`|`uint256`|The id of the erc721 token|
|`amountAdd0`|`uint256`||
|`amountAdd1`|`uint256`||

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`liquidity`|`uint128`|amount0 The amount received back in token0|
|`amount0`|`uint256`|The amount received back in token0|
|`amount1`|`uint256`|The amount returned back in token1|


### onERC721Received


```solidity
function onERC721Received(address operator, address, uint256 tokenId, bytes calldata)
    external
    override
    returns (bytes4);
```

### _createDeposit


```solidity
function _createDeposit(address owner, uint256 tokenId) internal;
```

### collectAllFees

Collects the fees associated with provided liquidity

*The contract must hold the erc721 token before it can collect fees*


```solidity
function collectAllFees(uint256 tokenId) public returns (uint256 amount0, uint256 amount1);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`tokenId`|`uint256`|The id of the erc721 token|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`amount0`|`uint256`|The amount of fees collected in token0|
|`amount1`|`uint256`|The amount of fees collected in token1|


### getLiquidity


```solidity
function getLiquidity(uint256 _tokenId) external view returns (uint128);
```

### _sendToOwner

Transfers funds to owner of NFT


```solidity
function _sendToOwner(uint256 tokenId, uint256 amount0, uint256 amount1) internal;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`tokenId`|`uint256`|The id of the erc721|
|`amount0`|`uint256`|The amount of token0|
|`amount1`|`uint256`|The amount of token1|


### retrieveNFT

Transfers the NFT to the owner


```solidity
function retrieveNFT(uint256 tokenId) external;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`tokenId`|`uint256`|The id of the erc721|


### getQuote


```solidity
function getQuote(address _tokenIn, address _tokenOut, uint256 _amountIn)
    external
    isActive
    returns (uint256 amountOut);
```

### createPool


```solidity
function createPool(address token0, address token1, uint256 amount0, uint256 amount1)
    public
    returns (address, uint256);
```

### swapCOLLATERALForMISC

msg.sender must approve this contract!

Swaps a fixed amount of collateral for a maximum possible amount of MISCusing the associated 0.3% pool by calling `exactInputSingle` in the swap router.

*The calling address must approve this contract to spend at least `amountIn` worth of its USDC for this function to succeed.*


```solidity
function swapCOLLATERALForMISC(uint256 _amountIn) external isActive returns (uint256 amountOut);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`_amountIn`|`uint256`|The exact amount of collateral that will be swapped for METADEX.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`amountOut`|`uint256`|The amount of MISC received.|


### swapMISCforUSDC

msg.sender must approve this contract!

Swaps a fixed amount of MISC for a maximum possible amount of COLL using the COLL/MISC 0.3% pool by calling `exactInputSingle` in the swap router.

*The calling address must approve this contract to spend at least `amountIn` worth of its MISC for this function to succeed.*


```solidity
function swapMISCforUSDC(uint256 _amountIn) external isActive returns (uint256 amountOut);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`_amountIn`|`uint256`|The exact amount of MISC that will be swapped for USDC.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`amountOut`|`uint256`|The amount of COLL received.|


## Events
### TokensSwapped

```solidity
event TokensSwapped(address tokenIn, address tokenOut, uint256 amountIn, uint256 amountOut);
```

### OwnershipTransfer

```solidity
event OwnershipTransfer(address oldOwner, address newOwner);
```

## Structs
### Deposit
Represents the deposit of an NFT


```solidity
struct Deposit {
    address owner;
    uint128 liquidity;
    address token0;
    address token1;
}
```

