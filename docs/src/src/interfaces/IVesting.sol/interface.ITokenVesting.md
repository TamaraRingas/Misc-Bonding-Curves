# ITokenVesting
[Git Source](https://github.com/TamaraRingas/Misc-Bonding-Curves/blob/ff25700444f7f4c67d29f4a0a36244531dce36c7/src/interfaces/IVesting.sol)

__  __     _____   _____      __    ___
/\   /\   /__\/ _\   /__   \  \_   \  /\ \ \  / _ \
\ \ / /  /_\  \ \      / /\/   / /\/ /  \/ / / /_\/
\ V /  //__  _\ \    / /   /\/ /_  / /\  / / /_\\
\_/   \__/  \__/    \/    \____/  \_\ \/  \____/


## Functions
### createVestingSchedule


```solidity
function createVestingSchedule(
    address _beneficiary,
    uint256 _start,
    uint256 _cliff,
    uint256 _duration,
    uint256 _slicePeriodSeconds,
    bool _revocable,
    uint256 _amount
) external;
```

### transferOwnership


```solidity
function transferOwnership(address newOwner) external;
```

### revoke


```solidity
function revoke(bytes32 vestingScheduleId) external;
```

