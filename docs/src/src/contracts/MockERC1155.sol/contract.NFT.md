# NFT
[Git Source](https://github.com/TamaraRingas/Misc-Bonding-Curves/blob/ff25700444f7f4c67d29f4a0a36244531dce36c7/src/contracts/MockERC1155.sol)

**Inherits:**
ERC1155, [IMockERC1155](/src/interfaces/IMockERC1155.sol/interface.IMockERC1155.md)


## Functions
### constructor


```solidity
constructor() ERC1155("ipfs://baseURI");
```

### mint


```solidity
function mint(address _to, uint256 _id, uint256 _amount, bytes memory _data) public;
```

### mintBatch


```solidity
function mintBatch(address _to, uint256[] memory _ids, uint256[] memory _amounts, bytes memory _data) public;
```

