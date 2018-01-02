pragma solidity ^0.4.18;
import "SoftKoin.sol";


contract Blackoin is SoftKoin{
    address private owner;
    string public  constant name = "Blackoin";
    string public constant symbol = "BLK";
    uint private totalTokenSupply = 1000000;

    function Blackoin() public{
        owner = msg.sender;
    // tokenHolderBalances[msg.sender] = totalTokenSupply;
    }
}


