# TokenVesting
[Git Source](https://github.com/TamaraRingas/Misc-Bonding-Curves/blob/ff25700444f7f4c67d29f4a0a36244531dce36c7/src/contracts/Vesting.sol)

**Inherits:**
Ownable, ReentrancyGuard

__  __     _____   _____      __    ___
/\   /\   /__\/ _\   /__   \  \_   \  /\ \ \  / _ \
\ \ / /  /_\  \ \      / /\/   / /\/ /  \/ / / /_\/
\ V /  //__  _\ \    / /   /\/ /_  / /\  / / /_\\
\_/   \__/  \__/    \/    \____/  \_\ \/  \____/


## State Variables
### _token

```solidity
IERC20 private immutable _token;
```


### vestingSchedulesIds

```solidity
bytes32[] private vestingSchedulesIds;
```


### vestingSchedules

```solidity
mapping(bytes32 => VestingSchedule) private vestingSchedules;
```


### holdersVestingCount

```solidity
mapping(address => uint256) private holdersVestingCount;
```


### vestingSchedulesTotalAmount

```solidity
uint256 private vestingSchedulesTotalAmount;
```


## Functions
### onlyIfVestingScheduleExists

*Reverts if no vesting schedule matches the passed identifier.*


```solidity
modifier onlyIfVestingScheduleExists(bytes32 vestingScheduleId);
```

### onlyIfVestingScheduleNotRevoked

*Reverts if the vesting schedule does not exist or has been revoked.*


```solidity
modifier onlyIfVestingScheduleNotRevoked(bytes32 vestingScheduleId);
```

### constructor

*Creates a vesting contract.*


```solidity
constructor(address token_);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`token_`|`address`|address of the ERC20 token contract|


### receive


```solidity
receive() external payable;
```

### fallback


```solidity
fallback() external payable;
```

### getVestingSchedulesCountByBeneficiary

*Returns the number of vesting schedules associated to a beneficiary.*


```solidity
function getVestingSchedulesCountByBeneficiary(address _beneficiary) external view returns (uint256);
```
**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`uint256`|the number of vesting schedules|


### getVestingIdAtIndex

*Returns the vesting schedule id at the given index.*


```solidity
function getVestingIdAtIndex(uint256 index) external view returns (bytes32);
```
**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`bytes32`|the vesting id|


### getVestingScheduleByAddressAndIndex

Returns the vesting schedule information for a given holder and index.


```solidity
function getVestingScheduleByAddressAndIndex(address holder, uint256 index)
    external
    view
    returns (VestingSchedule memory);
```
**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`VestingSchedule`|the vesting schedule structure information|


### getVestingSchedulesTotalAmount

Returns the total amount of vesting schedules.


```solidity
function getVestingSchedulesTotalAmount() external view returns (uint256);
```
**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`uint256`|the total amount of vesting schedules|


### getToken

*Returns the address of the ERC20 token managed by the vesting contract.*


```solidity
function getToken() external view returns (address);
```

### createVestingSchedule

Creates a new vesting schedule for a beneficiary.


```solidity
function createVestingSchedule(
    address _beneficiary,
    uint256 _start,
    uint256 _cliff,
    uint256 _duration,
    uint256 _slicePeriodSeconds,
    bool _revocable,
    uint256 _amount
) public onlyOwner;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`_beneficiary`|`address`|address of the beneficiary to whom vested tokens are transferred|
|`_start`|`uint256`|start time of the vesting period|
|`_cliff`|`uint256`|duration in seconds of the cliff in which tokens will begin to vest|
|`_duration`|`uint256`|duration in seconds of the period in which the tokens will vest|
|`_slicePeriodSeconds`|`uint256`|duration of a slice period for the vesting in seconds|
|`_revocable`|`bool`|whether the vesting is revocable or not|
|`_amount`|`uint256`|total amount of tokens to be released at the end of the vesting|


### revoke

Revokes the vesting schedule for given identifier.


```solidity
function revoke(bytes32 vestingScheduleId) public onlyOwner onlyIfVestingScheduleNotRevoked(vestingScheduleId);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`vestingScheduleId`|`bytes32`|the vesting schedule identifier|


### withdraw

Withdraw the specified amount if possible.


```solidity
function withdraw(uint256 amount) public nonReentrant onlyOwner;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`amount`|`uint256`|the amount to withdraw|


### release

Release vested amount of tokens.


```solidity
function release(bytes32 vestingScheduleId, uint256 amount)
    public
    nonReentrant
    onlyIfVestingScheduleNotRevoked(vestingScheduleId);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`vestingScheduleId`|`bytes32`|the vesting schedule identifier|
|`amount`|`uint256`|the amount to release|


### getVestingSchedulesCount

*Returns the number of vesting schedules managed by this contract.*


```solidity
function getVestingSchedulesCount() public view returns (uint256);
```
**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`uint256`|the number of vesting schedules|


### computeReleasableAmount

Computes the vested amount of tokens for the given vesting schedule identifier.


```solidity
function computeReleasableAmount(bytes32 vestingScheduleId)
    public
    view
    onlyIfVestingScheduleNotRevoked(vestingScheduleId)
    returns (uint256);
```
**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`uint256`|the vested amount|


### getVestingSchedule

Returns the vesting schedule information for a given identifier.


```solidity
function getVestingSchedule(bytes32 vestingScheduleId) public view returns (VestingSchedule memory);
```
**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`VestingSchedule`|the vesting schedule structure information|


### getWithdrawableAmount

*Returns the amount of tokens that can be withdrawn by the owner.*


```solidity
function getWithdrawableAmount() public view returns (uint256);
```
**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`uint256`|the amount of tokens|


### computeNextVestingScheduleIdForHolder

*Computes the next vesting schedule identifier for a given holder address.*


```solidity
function computeNextVestingScheduleIdForHolder(address holder) public view returns (bytes32);
```

### getLastVestingScheduleForHolder

*Returns the last vesting schedule for a given holder address.*


```solidity
function getLastVestingScheduleForHolder(address holder) public view returns (VestingSchedule memory);
```

### computeVestingScheduleIdForAddressAndIndex

*Computes the vesting schedule identifier for an address and an index.*


```solidity
function computeVestingScheduleIdForAddressAndIndex(address holder, uint256 index) public pure returns (bytes32);
```

### _computeReleasableAmount

*Computes the releasable amount of tokens for a vesting schedule.*


```solidity
function _computeReleasableAmount(VestingSchedule memory vestingSchedule) internal view returns (uint256);
```
**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`uint256`|the amount of releasable tokens|


### getCurrentTime


```solidity
function getCurrentTime() internal view virtual returns (uint256);
```

## Events
### Released

```solidity
event Released(uint256 amount);
```

### Revoked

```solidity
event Revoked();
```

## Structs
### VestingSchedule

```solidity
struct VestingSchedule {
    bool initialized;
    address beneficiary;
    uint256 cliff;
    uint256 start;
    uint256 duration;
    uint256 slicePeriodSeconds;
    bool revocable;
    uint256 amountTotal;
    uint256 released;
    bool revoked;
}
```

