// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "forge-std/console.sol";

import "../src/UniswapV2SwapExamples.sol";

address constant WETH = 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2;
address constant DAI = 0x6B175474E89094C44Da98b954EedeAC495271d0F;
address constant USDC = 0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48;

contract UniswapV2SwapExamplesTest is Test {
    IWETH private weth = IWETH(WETH);
    IERC20 private dai = IERC20(DAI);
    IERC20 private usdc = IERC20(USDC);

    UniswapV2SwapExamples private uni = new UniswapV2SwapExamples();

    function setUp() public {}

    // WETH'yi -> DAI'ye çevir
    function testSwapSingleHopExactAmountIn() public {
        uint wethAmount = 1e18;
        weth.deposit{value: wethAmount}();
        weth.approve(address(uni), wethAmount);

        uint daiAmountMin = 1;
        uint daiAmountOut = uni.swapSingleHopExactAmountIn(wethAmount, daiAmountMin);

        console.log("DAI", daiAmountOut);
        assertGe(daiAmountOut, daiAmountMin, "amount out < min");
    }

    // DAI -> WETH -> USDC (Çevir)
    function testSwapMultiHopExactAmountIn() public {
        // WETH'yi -> DAI'ye çevir
        uint wethAmount = 1e18;
        weth.deposit{value: wethAmount}();
        weth.approve(address(uni), wethAmount);

        uint daiAmountMin = 1;
        uni.swapSingleHopExactAmountIn(wethAmount, daiAmountMin);

        // DAI -> WETH -> USDC (Çevir)
        uint daiAmountIn = 1e18;
        dai.approve(address(uni), daiAmountIn);

        uint usdcAmountOutMin = 1;
        uint usdcAmountOut = uni.swapMultiHopExactAmountIn(
            daiAmountIn,
            usdcAmountOutMin
        );

        console.log("USDC", usdcAmountOut);
        assertGe(usdcAmountOut, usdcAmountOutMin, "amount out < min");
    }

    // WETH'yi -> DAI'ye çevir
    function testSwapSingleHopExactAmountOut() public {
        uint wethAmount = 1e18;
        weth.deposit{value: wethAmount}();
        weth.approve(address(uni), wethAmount);

        uint daiAmountDesired = 1e18;
        uint daiAmountOut = uni.swapSingleHopExactAmountOut(
            daiAmountDesired,
            wethAmount
        );

        console.log("DAI", daiAmountOut);
        assertEq(daiAmountOut, daiAmountDesired, "amount out != amount out desired");
    }

    // DAI -> WETH -> USDC (Çevir)
    function testSwapMultiHopExactAmountOut() public {
        // WETH'yi -> DAI'ye çevir
        uint wethAmount = 1e18;
        weth.deposit{value: wethAmount}();
        weth.approve(address(uni), wethAmount);

        // 100 DAI al
        uint daiAmountOut = 100 * 1e18;
        uni.swapSingleHopExactAmountOut(daiAmountOut, wethAmount);

        // DAI -> WETH -> USDC (Çevir)
        dai.approve(address(uni), daiAmountOut);

        uint amountOutDesired = 1e6;
        uint amountOut = uni.swapMultiHopExactAmountOut(amountOutDesired, daiAmountOut);

        console.log("USDC", amountOut);
        assertEq(amountOut, amountOutDesired, "amount out != amount out desired");
    }
}
