# MISC
[Git Source](https://github.com/TamaraRingas/Misc-Bonding-Curves/blob/ff25700444f7f4c67d29f4a0a36244531dce36c7/src/contracts/MISC.sol)

**Inherits:**
ERC20, ERC20Burnable, Pausable, AccessControl


## State Variables
### PAUSER_ROLE

```solidity
bytes32 public constant PAUSER_ROLE = keccak256("PAUSER_ROLE");
```


### MINTER_ROLE

```solidity
bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");
```


## Functions
### constructor


```solidity
constructor() ERC20("MISC", "MISC");
```

### grantRole


```solidity
function grantRole(bytes32 role, address account) public virtual override onlyRole(getRoleAdmin(role));
```

### pause


```solidity
function pause() public onlyRole(PAUSER_ROLE);
```

### unpause


```solidity
function unpause() public onlyRole(PAUSER_ROLE);
```

### mint


```solidity
function mint(address to, uint256 amount) public onlyRole(MINTER_ROLE);
```

### _mint


```solidity
function _mint(address account, uint256 amount) internal override(ERC20);
```

### _beforeTokenTransfer


```solidity
function _beforeTokenTransfer(address from, address to, uint256 amount) internal override whenNotPaused;
```

