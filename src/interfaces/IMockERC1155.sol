// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

/*
   __    __     ___    _  _  ____   ____  
  /__\  /__\   / __\  / |/ || ___| | ___| 
 /_\   / \//  / /     | || ||___ \ |___ \ 
//__  / _  \ / /___   | || | ___) | ___) |
\__/  \/ \_/ \____/   |_||_||____/ |____/                                      
***************************************/


interface IMockERC1155 {

    function mint(
        address _to,
        uint256 _id,
        uint256 _amount,
        bytes memory _data
    ) external;

    function mintBatch(
        address _to,
        uint256[] memory _ids,
        uint256[] memory _amounts,
        bytes memory _data
    ) external;
}