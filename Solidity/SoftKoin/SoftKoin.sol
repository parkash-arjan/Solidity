pragma solidity ^0.4.18;


contract SoftKoin{
    address private owner;
    string public  constant name = "SoftKoin";
    string public constant symbol = "SFK";
    mapping(address=>uint) private tokenHolderBalances;
    mapping(address=>mapping(address=>uint)) private tokenHolderApprovals;
    uint private totalTokenSupply;
    mapping(address=>uint) coinHolders;

    function SoftKoin() public{
        owner = msg.sender;
    }

    function giveCoins(uint numCoins  , address receiver) public{
        // owner can never run out of coins , so he can send as many coins as he wants.
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

    // ERC20
    function totalSupply() public constant returns (uint){
        return totalTokenSupply;
    }

    function balanceOf(address tokenOwner) public constant returns (uint balance){
        return tokenHolderBalances[tokenOwner];
    }

    function transfer(address to, uint tokens) public returns (bool success){
        if(tokenHolderBalances[msg.sender]>tokens && tokens>0){
            tokenHolderBalances[msg.sender] = tokenHolderBalances[msg.sender] - tokens;
            tokenHolderBalances[to] = tokenHolderBalances[to] + tokens;
            return true;
        } else {
            return false;
        }
    }

    function approve(address spender, uint tokens) public returns (bool success){
        if(tokenHolderBalances[msg.sender]>tokens){
            tokenHolderApprovals[msg.sender][spender] = tokens;
            return true;
        } else {
            return false;
        }
    }

    function allowance(address tokenOwner, address spender) public constant returns (uint remaining){
        return tokenHolderApprovals[tokenOwner][spender];
    }

    function transferFrom(address from, address to, uint tokens) public returns (bool success){
        /*TODO: need to re-think about msg.sender==to condition*/
        if(msg.sender==to && tokenHolderApprovals[from][to] >0 && tokenHolderBalances[from]>0){
            tokenHolderBalances[from] = tokenHolderBalances[from]  - tokens;
            tokenHolderBalances[to] = tokenHolderBalances[to]  + tokens;
            tokenHolderApprovals[from][to] = tokenHolderApprovals[from][to] - tokens;
        } else {
            return false;
        }
    }
}


