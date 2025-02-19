// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/*
echidna-test TestEchidna.sol --contract TestCounter
*/
contract Counter {
    uint public count;

    function inc() external {
        count += 1;
    }

    function dec() external {
        count -= 1;
    }
}

contract TestCounter is Counter {
    function echidna_test_true() public view returns (bool) {
        return true;
    }

    function echidna_test_false() public view returns (bool) {
        return false;
    }

    function echidna_test_count() public view returns (bool) {
        // Burada Counter.count'ın her zaman <= 5 olup olmadığını kontrol ediyoruz.
        // Test başarısız olacak. Echidna Counter.inc() fonksiyonunu
        // 5 defadan fazla çağıracak kadar akıllı.
        return count <= 5;
    }
}

/*
echidna-test TestEchidna.sol --contract TestAssert --check-asserts
*/
contract TestAssert {
    // 0.8'de deneme tespit edilmedi.
    // Denemeleri yapmak için 0.7'ye geçin.
    function test_assert(uint _i) external {
        assert(_i < 10);
    }

    // More complex example
    function abs(uint x, uint y) private pure returns (uint) {
        if (x >= y) {
            return x - y;
        }
        return y - x;
    }

    function test_abs(uint x, uint y) external {
        uint z = abs(x, y);
        if (x >= y) {
            assert(z <= x);
        } else {
            assert(z <= y);
        }
    }
}
