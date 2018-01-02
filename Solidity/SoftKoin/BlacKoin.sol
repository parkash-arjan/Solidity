pragma solidity ^0.4.18;
import "SoftKoin.sol";


contract BlacKoin is SoftKoin{
    address private owner;
    string public  constant name = "BlacKoin";
    string public constant symbol = "BLK";
    uint private totalTokenSupply = 1000000;

    function BlacKoin() public{
        owner = msg.sender;
        tokenHolderBalances[msg.sender] = totalTokenSupply;
    }
}


