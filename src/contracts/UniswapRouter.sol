// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;
pragma abicoder v2;

/*
   __     ___         _____    __    __  
  /__\   /___\ /\ /\ /__   \  /__\  /__\ 
 / \//  //  /// / \ \  / /\/ /_\   / \// 
/ _  \ / \_// \ \_/ / / /   //__  / _  \ 
\/ \_/ \___/   \___/  \/    \__/  \/ \_/ 
*/


import "../contracts/Tick.sol"; 
import "../interfaces/ICurve.sol";
import "../interfaces/IMarketTransition.sol";
import '@uniswap/v3-core/contracts/UniswapV3Factory.sol';
import '@uniswap/v3-core/contracts/libraries/TickMath.sol';
import "@uniswap/v3-periphery/contracts/interfaces/IQuoter.sol";
import '@uniswap/v3-core/contracts/interfaces/IUniswapV3Pool.sol';
import '@openzeppelin/contracts/token/ERC721/IERC721Receiver.sol';
import '@uniswap/v3-periphery/contracts/interfaces/ISwapRouter.sol';
import '@uniswap/v3-core/contracts/interfaces/IUniswapV3Factory.sol';
import '@uniswap/v3-periphery/contracts/libraries/TransferHelper.sol';
import '@uniswap/v3-periphery/contracts/base/LiquidityManagement.sol';
import "@uniswap/v3-periphery/contracts/interfaces/INonfungiblePositionManager.sol";

import {console} from "forge-std/console.sol";

contract UniswapRouter is IERC721Receiver, Tick {

    // =================== VARIABLES =================== //

    address private constant SWAP_ROUTER = 0xE592427A0AEce92De3Edee1F18E0157C05861564;

    address pool;
    address public owner;

    mapping(address => address) curveToPool;

    IERC20 COLL;
    IERC20 MISC;

    uint24 public poolFee;

    bool public poolActive;

    IUniswapV3Factory factory = IUniswapV3Factory(0x1F98431c8aD98523631AE4a59f267346ea31F984);
    INonfungiblePositionManager public immutable manager;
    ISwapRouter swapRouter = ISwapRouter(SWAP_ROUTER);

    IQuoter quoter = IQuoter(0xb27308f9F90D607463bb33eA1BeBb41C27CE5AB6);

    /// @notice Represents the deposit of an NFT
    struct Deposit {
        address owner;
        uint128 liquidity;
        address token0;
        address token1;
    }

    /// @dev deposits[tokenId] => Deposit
    mapping(uint256 => Deposit) public deposits;

    // =================== EVENTS =================== //

    event TokensSwapped(address tokenIn, address tokenOut, uint256 amountIn, uint256 amountOut);
    event OwnershipTransfer(address oldOwner, address newOwner);

    // =================== MODIFIERS =================== //

    modifier isActive() {
        require(poolActive, "Liquidity Pool is Paused");
        _;
    }

    
    modifier onlyOwner() {
        require(msg.sender == owner, "Caller is not the owner");
        _;
    }

    // =================== CONSTRUCTOR =================== //

    constructor(
        INonfungiblePositionManager _nonfungiblePositionManager,
        address _COLLATERAL,
        address _MISC
    ) {
        manager = _nonfungiblePositionManager;

        poolFee = 3000;

        MISC = IERC20(_MISC); 
        COLL = IERC20(_COLLATERAL);

        owner = msg.sender;
    }

    // =================== OWNER =================== //

    function transferOwner(address _newOwner) public onlyOwner {
        address oldOwner = owner;
        owner = _newOwner;

        emit OwnershipTransfer(oldOwner, _newOwner);
    }

    function setPoolFee(uint24 _fee) external onlyOwner {
        poolFee = _fee;
    }

    function pausePool() external onlyOwner {
        poolActive = false;
    }

    function activatePool() external onlyOwner {
        poolActive = true;
    }

    // =================== GENERAL =================== //

    function getTokensToMint(address _transition) internal returns (int256 amount) {
        IMarketTransition transition = IMarketTransition(_transition);
        amount = transition.getTokenstoMint();
    }

    /// @notice A function that decreases the current liquidity. An example to show how to call the `decreaseLiquidity` function defined in periphery.
    /// @param tokenId The id of the erc721 token
    /// @return amount0 The amount received back in token0
    /// @return amount1 The amount returned back in token1
    // function decreaseLiquidity(uint256 tokenId, uint128 liquidity) external returns (uint amount0, uint amount1) {
        
    //     INonfungiblePositionManager.DecreaseLiquidityParams memory params =
    //         INonfungiblePositionManager.DecreaseLiquidityParams({
    //             tokenId: tokenId,
    //             liquidity: liquidity + 1,
    //             amount0Min: 0,
    //             amount1Min: 0,
    //             deadline: block.timestamp
    //         });

    //     (amount0, amount1) = manager.decreaseLiquidity(params);

    //     collectAllFees(tokenId);

    //     COLLATERAL.transfer(msg.sender, amount0);
    //     MISC.transfer(msg.sender, amount1);

    // }

    /// @notice Increases liquidity in the current range, User must approve this router for the amounts
    /// @dev Pool must be initialized already to add liquidity
    /// @param tokenId The id of the erc721 token
    /// @param amount0 The amount to add of token0
    /// @param amount1 The amount to add of token1
    function increaseLiquidityCurrentRange(
        uint256 tokenId,
        uint256 amountAdd0,
        uint256 amountAdd1
    )
        external
        returns (
            uint128 liquidity,
            uint256 amount0,
            uint256 amount1
        )
    {

        TransferHelper.safeTransferFrom(address(COLL), msg.sender, address(this), amountAdd0);
        TransferHelper.safeTransferFrom(address(MISC), msg.sender, address(this), amountAdd1);

        TransferHelper.safeApprove(address(COLL), address(manager), amountAdd0);
        TransferHelper.safeApprove(address(MISC), address(manager), amountAdd1);

        INonfungiblePositionManager.IncreaseLiquidityParams memory params =
            INonfungiblePositionManager.IncreaseLiquidityParams({
                tokenId: tokenId,
                amount0Desired: amountAdd0,
                amount1Desired: amountAdd1,
                amount0Min: 0,
                amount1Min: 0,
                deadline: block.timestamp
            });

        (liquidity, amount0, amount1) = manager.increaseLiquidity(params);

        if(amountAdd0 > amount0) {
            uint256 diff = amountAdd0 - amount0;
            TransferHelper.safeTransfer(address(COLL), msg.sender, diff);
        }

        if(amountAdd1 > amount1) {
            uint256 diff2 = amountAdd1 - amount1;
            TransferHelper.safeTransfer(address(MISC), msg.sender, diff2);
        }
    }

    // Implementing `onERC721Received` so this contract can receive custody of erc721 tokens
    function onERC721Received(
        address operator,
        address,
        uint256 tokenId,
        bytes calldata
    ) external override returns (bytes4) {
        // get position information

        _createDeposit(operator, tokenId);

        return this.onERC721Received.selector;
    }

    function _createDeposit(address owner, uint256 tokenId) internal {
        (, , address token0, address token1, , , , uint128 liquidity, , , , ) =
            manager.positions(tokenId);

        // set the owner and data for position
        // operator is msg.sender
        deposits[tokenId] = Deposit({owner: owner, liquidity: liquidity, token0: token0, token1: token1});
    }

    /// @notice Collects the fees associated with provided liquidity
    /// @dev The contract must hold the erc721 token before it can collect fees
    /// @param tokenId The id of the erc721 token
    /// @return amount0 The amount of fees collected in token0
    /// @return amount1 The amount of fees collected in token1
    function collectAllFees(uint256 tokenId) public returns (uint256 amount0, uint256 amount1) {
        // Caller must own the ERC721 position, meaning it must be a deposit

        // set amount0Max and amount1Max to uint256.max to collect all fees
        // alternatively can set recipient to msg.sender and avoid another transaction in `sendToOwner`
        INonfungiblePositionManager.CollectParams memory params =
            INonfungiblePositionManager.CollectParams({
                tokenId: tokenId,
                recipient: address(this),
                amount0Max: type(uint128).max,
                amount1Max: type(uint128).max
            });

        (amount0, amount1) = manager.collect(params);

        // send collected feed back to owner
        _sendToOwner(tokenId, amount0, amount1);
    }

    function getLiquidity(uint _tokenId) external view returns (uint128) {
        (
            ,
            ,
            ,
            ,
            ,
            ,
            ,
            uint128 liquidity,
            ,
            ,
            ,

        ) = manager.positions(_tokenId);
        return liquidity;
    }

    /// @notice Transfers funds to owner of NFT
    /// @param tokenId The id of the erc721
    /// @param amount0 The amount of token0
    /// @param amount1 The amount of token1
    function _sendToOwner(
        uint256 tokenId,
        uint256 amount0,
        uint256 amount1
    ) internal {
        // get owner of contract
        address owner = deposits[tokenId].owner;

        address token0 = deposits[tokenId].token0;
        address token1 = deposits[tokenId].token1;
        // send collected fees to owner
        TransferHelper.safeTransfer(token0, owner, amount0);
        TransferHelper.safeTransfer(token1, owner, amount1);
    }

    /// @notice Transfers the NFT to the owner
    /// @param tokenId The id of the erc721
    function retrieveNFT(uint256 tokenId) external {
        // must be the owner of the NFT
        require(msg.sender == deposits[tokenId].owner, 'Not the owner');
        // transfer ownership to original owner
        manager.safeTransferFrom(address(this), msg.sender, tokenId);
        //remove information related to tokenId
        delete deposits[tokenId];
    }

    function getQuote(address _tokenIn, address _tokenOut, uint256 _amountIn) external isActive returns(uint256 amountOut) {
        amountOut = quoter.quoteExactInputSingle(
            address(_tokenIn),
            address(_tokenOut),
            poolFee,
            _amountIn,
            0);
    }

    // ToDo Add modifier that only transition or owner can call 
    function createPool(address token0, address token1, uint256 amount0, uint256 amount1) public returns(address, uint256) {

        if (token0 > token1) {
            address tmp = token0;
            token0 = token1;
            token1 = tmp;

            uint256 tmpAmount = amount0;
            amount0 = amount1;
            amount1 = tmpAmount;
        }

        address poolAddress = manager.createAndInitializePoolIfNecessary(token0, token1, poolFee, encodePriceSqrt(amount1, amount0));

        INonfungiblePositionManager.MintParams memory params =
            INonfungiblePositionManager.MintParams({
                    token0: token0,
                    token1: token1,
                    fee: poolFee,
                    tickLower: getMinTick(TICK_MEDIUM),
                    tickUpper: getMaxTick(TICK_MEDIUM),
                    amount0Desired: amount0,
                    amount1Desired: amount1,
                    amount0Min: 0,
                    amount1Min: 0,
                    recipient: address(this),
                    deadline: block.timestamp + 10
                });

        TransferHelper.safeApprove(token0, poolAddress, 100000000*1e18);
        TransferHelper.safeApprove(token1, poolAddress, 100000000*1e18);

        TransferHelper.safeApprove(token0, address(manager), 100000000*1e18);
        TransferHelper.safeApprove(token1, address(manager), 100000000*1e18);

        TransferHelper.safeApprove(token0, 0x91ae842A5Ffd8d12023116943e72A606179294f3, 100000000*1e18);
        TransferHelper.safeApprove(token1, 0x91ae842A5Ffd8d12023116943e72A606179294f3, 100000000*1e18);

        (uint256 tokenId,,,) = manager.mint(params);

        return (poolAddress, tokenId);
    }

    /// msg.sender must approve this contract!
    /// @notice Swaps a fixed amount of collateral for a maximum possible amount of MISCusing the associated 0.3% pool by calling `exactInputSingle` in the swap router.
    /// @dev The calling address must approve this contract to spend at least `amountIn` worth of its USDC for this function to succeed.
    /// @param _amountIn The exact amount of collateral that will be swapped for METADEX.
    /// @return amountOut The amount of MISC received.
    function swapCOLLATERALForMISC(uint256 _amountIn) external isActive returns (uint256 amountOut) {
        require(_amountIn > 0, "Amount must be larger than zero");

        TransferHelper.safeTransferFrom(address(COLL), msg.sender, address(this), _amountIn);

        TransferHelper.safeApprove(address(COLL), address(swapRouter), _amountIn);

        ISwapRouter.ExactInputSingleParams memory params = ISwapRouter.ExactInputSingleParams({
            tokenIn: address(COLL),
            tokenOut: address(MISC),
            fee: poolFee,
            recipient: address(msg.sender),
            deadline: block.timestamp,
            amountIn: _amountIn,
            amountOutMinimum: 0,
            sqrtPriceLimitX96: 0
        });

        amountOut = ISwapRouter(address(swapRouter)).exactInputSingle(params);

        emit TokensSwapped(address(COLL), address(MISC), _amountIn, amountOut);

        return amountOut;
    }

    /// msg.sender must approve this contract!
    /// @notice Swaps a fixed amount of MISC for a maximum possible amount of COLL using the COLL/MISC 0.3% pool by calling `exactInputSingle` in the swap router.
    /// @dev The calling address must approve this contract to spend at least `amountIn` worth of its MISC for this function to succeed.
    /// @param _amountIn The exact amount of MISC that will be swapped for USDC.
    /// @return amountOut The amount of COLL received.
    function swapMISCforUSDC(uint256 _amountIn) external isActive returns (uint256 amountOut) {
        require(_amountIn > 0, "Amount must be larger than zero");

        TransferHelper.safeTransferFrom(address(MISC), msg.sender, address(this), _amountIn);

        TransferHelper.safeApprove(address(MISC), address(swapRouter), _amountIn);

        ISwapRouter.ExactInputSingleParams memory params = ISwapRouter.ExactInputSingleParams({
            tokenIn: address(MISC),
            tokenOut: address(COLL),
            fee: poolFee,
            recipient: address(msg.sender),
            deadline: block.timestamp,
            amountIn: _amountIn,
            amountOutMinimum: 0,
            sqrtPriceLimitX96: 0
        });

        amountOut = ISwapRouter(address(swapRouter)).exactInputSingle(params);

        emit TokensSwapped(address(MISC), address(COLL), _amountIn, amountOut);

        return amountOut;
    }

    /// @notice Calls the mint function defined in periphery, mints the same amount of each token.
    /// For this example we are providing 1000 METADEX and 1000 USDC in liquidity
    /// @return tokenId The id of the newly minted ERC721
    /// @return liquidity The amount of liquidity for the position
    /// @return amount0 The amount of token0
    /// @return amount1 The amount of token1
    // function mintNewPosition()
    //     external
    //     returns (
    //         uint256 tokenId,
    //         uint128 liquidity,
    //         uint256 amount0,
    //         uint256 amount1
    //     )
    // {
    //     // For this example, we will provide equal amounts of liquidity in both assets.
    //     // Providing liquidity in both assets means liquidity will be earning fees and is considered in-range.
    //     uint256 amount0ToMint = 1000;
    //     uint256 amount1ToMint = 1000;

    //     // transfer tokens to contract
    //     TransferHelper.safeTransferFrom(address(METADEX), msg.sender, address(this), amount0ToMint);
    //     TransferHelper.safeTransferFrom(address(USDC), msg.sender, address(this), amount1ToMint);

    //     // Approve the position manager
    //     TransferHelper.safeApprove(address(METADEX), address(manager), amount0ToMint);
    //     TransferHelper.safeApprove(address(USDC), address(manager), amount1ToMint);

        // INonfungiblePositionManager.MintParams memory params =
        //     INonfungiblePositionManager.MintParams({
        //         token0: address(USDC),
        //         token1: address(METADEX),
        //         fee: poolFee,
        //         tickLower: TickMath.MIN_TICK,
        //         tickUpper: TickMath.MAX_TICK,
        //         amount0Desired: amount0ToMint,
        //         amount1Desired: amount1ToMint,
        //         amount0Min: 0,
        //         amount1Min: 0,
        //         recipient: address(this),
        //         deadline: block.timestamp
        //     });

    //     // Note that the pool defined by METADEX/USDC and fee tier 0.3% must already be created and initialized in order to mint
    //     (tokenId, liquidity, amount0, amount1) = manager.mint(params);

    //     // Create a deposit
    //     _createDeposit(msg.sender, tokenId);

    //     // Remove allowance and refund in both assets.
    //     if (amount0 < amount0ToMint) {
    //         TransferHelper.safeApprove(address(METADEX), address(manager), 0);
    //         uint256 refund0 = amount0ToMint - amount0;
    //         TransferHelper.safeTransfer(address(METADEX), msg.sender, refund0);
    //     }

    //     if (amount1 < amount1ToMint) {
    //         TransferHelper.safeApprove(address(USDC), address(manager), 0);
    //         uint256 refund1 = amount1ToMint - amount1;
    //         TransferHelper.safeTransfer(address(USDC), msg.sender, refund1);
    //     }
    // }
}