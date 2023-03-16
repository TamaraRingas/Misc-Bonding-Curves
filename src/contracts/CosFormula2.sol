// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

/*                     ___                           
  ___   ___   ___     / __\ _   _  _ __ __   __  ___ 
 / __| / _ \ / __|   / /   | | | || '__|\ \ / / / _ \
| (__ | (_) |\__ \  / /___ | |_| || |    \ V / |  __/
 \___| \___/ |___/  \____/  \__,_||_|     \_/   \___|
****************************************************/

import "./MISC.sol";
import "./MarketTransition.sol";
import "../interfaces/ICurve.sol"; 
import "../libraries/LibErrors.sol";
import "../libraries/LibEvents.sol";
import "@prb-math/sd59x18/Math.sol";
import "@trigonometry/Trigonometry.sol";
import "../interfaces/ICosFormula1.sol"; 
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";