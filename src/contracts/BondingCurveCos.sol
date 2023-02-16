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

contract BondingCurveCos is IBondingCurveCos, Ownable {
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

   // =================== CONSTRUCTOR =================== //

    constructor(
        address _collateralAddress,
        address _miscAddress,
        address _nftAddress,
        address _treasuryAddress,
        address _uniswapRouter
    ) {

        maxThreshold = 20000000;
        minThreshold = 5000000;
        timeoutPeriod = 150 days;
        tokensSold = 0;

        treasuryAddress = _treasuryAddress;
        uniswapRouterAddress = _uniswapRouter;

        ETH = IERC20(_collateralAddress);
        misc = MISC(_miscAddress);

        //NFT = IERC1155(_nftAddress);

        //getPriceContract = IGetPrice(_getPrice);

        curveActive = false; // ToDo switch to uint8
        transitionConditionsMet = false; // ToDo switch to uint8
        transitioned = false; // ToDo switch to uint8

        //nftStage = NFTStage(true, false, false, false);
        //currentNFTStage = "Black";
    }

    // =================== OWNER FUNCTIONS =================== //

    function initializeCurve() external onlyOwner {
        curveActive = true;
        timeoutPeriodExpiry = block.timestamp + timeoutPeriod;
        emit CurveActivated(msg.sender, block.timestamp);
    }
    
    function pauseCurve() external {
        marketTransitionContractAddress = curveFactory.getMarketAddress(
            address(this)
        );
        require(
            msg.sender == marketTransitionContractAddress ||
                msg.sender == owner(),
            "Access Denied"
        );

        curveActive = false;

        emit CurvePaused(msg.sender, block.timestamp);
    }
    
    function activateCurve() external onlyOwner {
        curveActive = true;
        timeoutPeriodExpiry = startTime + timeoutPeriod;
        emit CurveActivated(msg.sender, block.timestamp);
    }

    // =================== VIEW FUNCTIONS =================== //

    function getFee(int256 _price) public pure returns (int256) {
        int256 fee = PRBMathSD59x18.mul(
            PRBMathSD59x18.div(5 * 1e18, 100e18),
            _price
        );
        return fee;
    }
}