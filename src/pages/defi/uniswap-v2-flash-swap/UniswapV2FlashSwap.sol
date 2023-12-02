// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

interface IUniswapV2Callee {
    function uniswapV2Call(
        address sender,
        uint amount0,
        uint amount1,
        bytes calldata data
    ) external;
}

contract UniswapV2FlashSwap is IUniswapV2Callee {
    address private constant UNISWAP_V2_FACTORY =
        0x5C69bEe701ef814a2B6a3EDD4B1652CB9cc5aA6f;

    address private constant DAI = 0x6B175474E89094C44Da98b954EedeAC495271d0F;
    address private constant WETH = 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2;

    IUniswapV2Factory private constant factory = IUniswapV2Factory(UNISWAP_V2_FACTORY);

    IERC20 private constant weth = IERC20(WETH);

    IUniswapV2Pair private immutable pair;

    // Bu örnek için, ödenecek miktarı kaydedin
    uint public amountToRepay;

    constructor() {
        pair = IUniswapV2Pair(factory.getPair(DAI, WETH));
    }

    function flashSwap(uint wethAmount) external {
        // uniswapV2Call fonksiyonunu tetiklemek için birkaç veri göndermek gerekiyor
        bytes memory data = abi.encode(WETH, msg.sender);

        // amount0Out DAI'yi temsil ediyor, amount1Out ise WETH'yi
        pair.swap(0, wethAmount, address(this), data);
    }

    // Bu fonksiyon DAI/WETH kontratı tarafından çağırılıyor
    function uniswapV2Call(
        address sender,
        uint amount0,
        uint amount1,
        bytes calldata data
    ) external {
        require(msg.sender == address(pair), "not pair");
        require(sender == address(this), "not sender");

        (address tokenBorrow, address caller) = abi.decode(data, (address, address));

        // Sizin yazacağınız kod buraya yazılacak. Örneğin, arbitraj kodu.
        require(tokenBorrow == WETH, "token borrow != WETH");

        // Yaklaşık yüzde 0.3 fee, +1 kısmını yumarlamak için ekliyoruz
        uint fee = (amount1 * 3) / 997 + 1;
        amountToRepay = amount1 + fee;

        // Kullanıcıdan flash swap feeyi burada transfer ediyoruz
        weth.transferFrom(caller, address(this), fee);

        // Geri ödeme kısmı
        weth.transfer(address(pair), amountToRepay);
    }
}

interface IUniswapV2Pair {
    function swap(
        uint amount0Out,
        uint amount1Out,
        address to,
        bytes calldata data
    ) external;
}

interface IUniswapV2Factory {
    function getPair(
        address tokenA,
        address tokenB
    ) external view returns (address pair);
}

interface IERC20 {
    function totalSupply() external view returns (uint);

    function balanceOf(address account) external view returns (uint);

    function transfer(address recipient, uint amount) external returns (bool);

    function allowance(address owner, address spender) external view returns (uint);

    function approve(address spender, uint amount) external returns (bool);

    function transferFrom(
        address sender,
        address recipient,
        uint amount
    ) external returns (bool);

    event Transfer(address indexed from, address indexed to, uint value);
    event Approval(address indexed owner, address indexed spender, uint value);
}

interface IWETH is IERC20 {
    function deposit() external payable;

    function withdraw(uint amount) external;
}
