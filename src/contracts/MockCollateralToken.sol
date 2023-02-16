// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

/*
   ___    ___    __     _    _____    __    __     _      __  
  / __\  /___\  / /    /_\  /__   \  /__\  /__\   /_\    / /  
 / /    //  // / /    //_\\   / /\/ /_\   / \//  //_\\  / /   
/ /___ / \_// / /___ /  _  \ / /   //__  / _  \ /  _  \/ /___ 
\____/ \___/  \____/ \_/ \_/ \/    \__/  \/ \_/ \_/ \_/\____/ 
***********************************************************/

import "../interfaces/IMockCollateralToken.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MockCollateralToken is ERC20 {

    constructor() ERC20("mCOLL", "MockCOLLATERA;") {}

    function mint(address _to, uint256 _amount) public {
        _mint(_to, _amount);
    }

    function getBalanceOf(address _account) public view returns (uint256){
        return balanceOf(_account);
    }

}