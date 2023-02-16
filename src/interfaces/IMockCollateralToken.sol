// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

/*
   ___    ___    __     _    _____    __    __     _      __  
  / __\  /___\  / /    /_\  /__   \  /__\  /__\   /_\    / /  
 / /    //  // / /    //_\\   / /\/ /_\   / \//  //_\\  / /   
/ /___ / \_// / /___ /  _  \ / /   //__  / _  \ /  _  \/ /___ 
\____/ \___/  \____/ \_/ \_/ \/    \__/  \/ \_/ \_/ \_/\____/ 
***********************************************************/

interface IMockCollateralToken {

    function balanceOf(address _account) external view returns (uint256);

    function mint(address _to, uint256 _amount) external;

    function approve(address _spender, uint256 _amount) external;
}