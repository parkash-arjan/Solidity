pragma solidity ^0.4.18; 


contract MyContract {
    string private name;
    uint private id;

    function getName() public view returns (string){
        return name;
    }

    function setName(string p_name) public{
        name= p_name;
    }

    function getId() public view returns (uint){
        return id;
    }

    function setId(uint p_id) public{
        id= p_id;
    }
}


