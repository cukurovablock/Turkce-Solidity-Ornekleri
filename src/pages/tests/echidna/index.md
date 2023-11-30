---
title: Echidna
version: 0.8.20
description: Echidna ile kontrat test etme örneği
keywords: [test, echidna]
---

[Echidna](https://github.com/crytic/echidna) ile kontrat test etme örneği.

1. Solidity kontratını `TestEchidna.sol`  olarak kaydedin.
2. Kontratınızın olduğu klasörde aşağıdaki komutu çalıştırın.

```shell
docker run -it --rm -v $PWD:/code trailofbits/eth-security-toolbox
```

Docker içinde, kodunuz `/code` dizininde kaydedilecek.

3. Aşağıdaki yorum satırlarına bakın ve `echidna-test` komutunu çalıştırın.

```solidity
{{{TestEchidna}}}
```

### Zaman ve Göndericiyi Test Etme

Echidna, zaman damgasını (timestamp) fuzzlayabilir. Zaman damgasının aralığı yapılandırmada belirlenir. Varsayılan olarak 7 gündür.

Kontrat'ı çağıranlar yapılandırmada belirlenebilir. Varsayılan cüzdanlar şunlardır:

- `0x10000`
- `0x20000`
- `0x00a329C0648769a73afAC7F9381e08fb43DBEA70`

```solidity
{{{EchidnaTestTimeAndCaller}}}
```
