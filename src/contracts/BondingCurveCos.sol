// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

/*                     ___                           
  ___   ___   ___     / __\ _   _  _ __ __   __  ___ 
 / __| / _ \ / __|   / /   | | | || '__|\ \ / / / _ \
| (__ | (_) |\__ \  / /___ | |_| || |    \ V / |  __/
 \___| \___/ |___/  \____/  \__,_||_|     \_/   \___|

*/

import "./MISC.sol";
import "../libraries/LibErrors.sol";
import "../interfaces/IBondingCurveCos.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@prb-math/sd59x18/Math.sol";  

contract BondingCurveCos is IBondingCurveCos {
  //using  for int256;

  // =================== VARIABLES =================== //

  int256 immutable maxThreshold;
  int256 immutable minThreshold;
  int256 tokensSold;

  uint256 immutable timeoutPeriod;
  uint256 timeoutPeriodExpiry;

  bool public curveActive; // ToDo: Change to uint8 to save space
  bool public transitionConditionsMet; // ToDo: Change to uint8 to save space
  bool public transitioned; // ToDo: Change to uint8 to save space

  address uniswapRouterAddress;
  address daoAddress;
  address treasuryAddress;

  IERC20 ETH;
  MISC misc;

  // =================== MODIFIERS =================== //

  modifier isActive() {
      if (curveActive == false) revert LibErrors.CurvePaused();
      _;
  }

  //  /// @notice Checks if a user is whitelisted for the current sale round
  //   /// @dev Gets the currentNFTStage and checks if the user has a balance of the correcponding NFT in their wallet
  //   modifier isEligible() {
  //       if (keccak256(bytes(currentNFTStage)) == keccak256(bytes("Black"))) {
  //           require(NFT.balanceOf(msg.sender, BLACK_NFT_ID) > 0, "NFTRequired");
  //           _;
  //       }
  //       if (keccak256(bytes(currentNFTStage)) == keccak256(bytes("Gold"))) {
  //           require(
  //               NFT.balanceOf(msg.sender, BLACK_NFT_ID) > 0 ||
  //                   NFT.balanceOf(msg.sender, GOLD_NFT_ID) > 0,
  //               "NFTRequired"
  //           );
  //           _;
  //       }
  //       if (keccak256(bytes(currentNFTStage)) == keccak256(bytes("Silver"))) {
  //           require(
  //               NFT.balanceOf(msg.sender, BLACK_NFT_ID) > 0 ||
  //                   NFT.balanceOf(msg.sender, GOLD_NFT_ID) > 0 ||
  //                   NFT.balanceOf(msg.sender, SILVER_NFT_ID) > 0,
  //               "NFTRequired"
  //           );
  //           _;
  //       }
  //       if (keccak256(bytes(currentNFTStage)) == keccak256(bytes("None"))) {
  //           _;
  //       }
  //   }

  constructor() {

  }
}