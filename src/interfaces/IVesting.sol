// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

/**
            __  __     _____   _____      __    ___ 
 /\   /\   /__\/ _\   /__   \  \_   \  /\ \ \  / _ \
 \ \ / /  /_\  \ \      / /\/   / /\/ /  \/ / / /_\/
  \ V /  //__  _\ \    / /   /\/ /_  / /\  / / /_\\ 
   \_/   \__/  \__/    \/    \____/  \_\ \/  \____/ 
*/

interface ITokenVesting {

    function createVestingSchedule(
        address _beneficiary,
        uint256 _start,
        uint256 _cliff,
        uint256 _duration,
        uint256 _slicePeriodSeconds,
        bool _revocable,
        uint256 _amount
    ) external;

    function transferOwnership(address newOwner) external;
    
    function revoke(bytes32 vestingScheduleId) external;
}