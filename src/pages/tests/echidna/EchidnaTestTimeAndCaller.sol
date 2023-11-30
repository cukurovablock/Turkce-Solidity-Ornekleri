// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

/*
docker run -it --rm -v $PWD:/code trailofbits/eth-security-toolbox
echidna-test EchidnaTestTimeAndCaller.sol --contract EchidnaTestTimeAndCaller
*/
contract EchidnaTestTimeAndCaller {
    bool private pass = true;
    uint private createdAt = block.timestamp;

    /*
    test başarısız olacak eğer Echidna, setFail() fonksiyonunu çağırabilirse
    öteki durumda test başarılı olacak
    */
    function echidna_test_pass() public view returns (bool) {
        return pass;
    }

    function setFail() external {
        /*
        Echidna bu fonsksiyonu çağırabilir eğer delay <= max block delay olursa
        Öteki durumda Echidna bu fonksiyonu çağıramayacak
        Configuration dosyasındaki ayarlar değiştirilerek "Max block delay" arttırılabilir
        */
        uint delay = 7 days;
        require(block.timestamp >= createdAt + delay);
        pass = false;
    }

    // Varsayılan gönderici adresler
    // Adresi değiştirip testin başarısız olup olmadığına bak
    address[3] private senders = [
        address(0x10000),
        address(0x20000),
        address(0x00a329C0648769a73afAC7F9381e08fb43DBEA70)
    ];

    address private sender = msg.sender;

    // _sender değişkenini input olarak ver ve 
    // require msg.sender == _sender'daki _sender değişkenine bak
    function setSender(address _sender) external {
        require(_sender == msg.sender);
        sender = msg.sender;
    }

    // Varsayılan gönderici adresi kontrol et. sender değişkeni varsayılan 3 adresten biri olmalı
    function echidna_test_sender() public view returns (bool) {
        for (uint i; i < 3; i++) {
            if (sender == senders[i]) {
                return true;
            }
        }
        return false;
    }
}
