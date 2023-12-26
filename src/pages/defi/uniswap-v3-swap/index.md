---
title: Uniswap V3 Swap Örneği
version: 0.8.20
description: Uniswap V3 swap örneği
keywords: [defi, uniswap, v3, swap, amm]
---

### Uniswap V3 Swap Örneği

```solidity
{{{UniswapV3SwapExamples}}}
```

### Foundry ile test et

1. Bu kodu kopyalayıp projenizin `test` klasörüne kaydedin

```solidity
{{{UniswapV3SwapExamplesTest}}}
```

2. Testi başlatmak için aşağıdaki komutları çalıştırın

```shell
FORK_URL=https://eth-mainnet.g.alchemy.com/v2/613t3mfjTevdrCwDl28CVvuk6wSIxRPi
forge test -vv --gas-report --fork-url $FORK_URL --match-path test/UniswapV3SwapExamples.test.sol
```

### Links

<a href="https://docs.uniswap.org/protocol/guides/swaps/single-swaps" target="__blank">Uniswap V3</a>

<a href="https://github.com/foundry-rs/foundry" target="__blank">Foundry</a>

<a href="https://github.com/t4sk/defi-notes" target="__blank">Uniswap V3 Foundry örneği</a>
