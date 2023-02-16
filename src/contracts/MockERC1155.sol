// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

/*
   __    __     ___    _  _  ____   ____  
  /__\  /__\   / __\  / |/ || ___| | ___| 
 /_\   / \//  / /     | || ||___ \ |___ \ 
//__  / _  \ / /___   | || | ___) | ___) |
\__/  \/ \_/ \____/   |_||_||____/ |____/                                      
*/

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "../interfaces/IMockERC1155.sol";

contract NFT is ERC1155, IMockERC1155 {
  
    constructor() ERC1155("ipfs://baseURI") {}

    function mint(
        address _to,
        uint256 _id,
        uint256 _amount,
        bytes memory _data
    ) public {
        _mint(_to, _id, _amount, _data);
    }

    function mintBatch(
        address _to,
        uint256[] memory _ids,
        uint256[] memory _amounts,
        bytes memory _data
    ) public {
        _mintBatch(_to, _ids, _amounts, _data);
    }
}