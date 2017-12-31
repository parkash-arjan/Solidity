pragma solidity ^0.4.18;


interface Regulator{
    function checkValue(uint amount) public returns (bool);
    function loan() public returns (bool);
}


contract Bank is Regulator{
    uint private value;

    function Bank(uint initialValue) public{
        value  = initialValue;
    }

    function deposite(uint pValue) public{
        value = value+ pValue;
    }

    function withdraw(uint pValue) public{
        if(checkValue(pValue)){
            value = value - pValue;
        }
    }

    function balance()  public view returns (uint){
        return value;
    }

    function checkValue(uint amount) public returns (bool){
        return amount<value;
    }

    function loan() public returns (bool){
        return value > 0;
    }
}


