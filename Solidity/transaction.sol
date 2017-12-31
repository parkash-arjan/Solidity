pragma solidity ^0.4.18;


contract Transaction {
    address private owner;

    function Transaction () public{
        owner = msg.sender;
    }

    event SenderLogger(address);

    event ValueLogger(uint);

    modifier isOwner{
        require(owner==msg.sender);
        _;
    }

    modifier validvalue{
        assert(msg.value == 1 ether);
        _;
    }

    function () payable public isOwner validvalue{
        SenderLogger(msg.sender);
        ValueLogger(msg.value);
    }
}


