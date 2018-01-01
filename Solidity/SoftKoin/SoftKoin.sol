pragma solidity ^0.4.18;


contract SoftKoin{
    address owner;
    mapping(address=>uint) coinHolders;

    function SoftKoin() public{
        owner = msg.sender;
    }

    function giveCoins(uint numCoins  , address receiver) public{
        //owner can never run out of coins , so he can send as many coins as he wants.
        if(msg.sender ==owner && numCoins>0){
            coinHolders[receiver] = coinHolders[receiver] + numCoins;
        } else {
            revert();
        }
    }

    function viewBalance()public view returns (uint){
        // return the balance of caller
        return coinHolders[msg.sender];
    }
}


