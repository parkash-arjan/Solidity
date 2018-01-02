pragma solidity ^0.4.18;
import "SoftKoin.sol";


contract Pinkoin is SoftKoin{
    address private owner;
    string public  constant name = "Pinkoin";
    string public constant symbol = "PNK";
    uint private totalTokenSupply = 1000000;

    function Pinkoin() public{
        owner = msg.sender;
    // tokenHolderBalances[msg.sender] = totalTokenSupply;
    }
}


