---
title: Uniswap V3 Flash Kredi
version: 0.8.20
description: Uniswap V3 Flash Kredi
keywords: [defi, uniswap, v3, flash, loan, amm]
---

### Uniswap V3 Flash Kredi Örneği

```solidity
{{{UniswapV3Flash}}}
```

### Foundry ile Test Et

1. Bu kodu kopyalayıp projenizin `test` klasörüne kaydedin

```solidity
{{{UniswapV3FlashTest}}}
```

2. Testi başlatmak için aşağıdaki komutları çalıştırın

```shell
FORK_URL=https://eth-mainnet.g.alchemy.com/v2/613t3mfjTevdrCwDl28CVvuk6wSIxRPi
forge test -vv --gas-report --fork-url $FORK_URL --match-path test/UniswapV3FlashTest.test.sol
```

### Linkler

<a href="https://github.com/foundry-rs/foundry" target="__blank">Foundry</a>

<a href="https://github.com/t4sk/defi-notes" target="__blank">Uniswap V3 Foundry örneği</a>
