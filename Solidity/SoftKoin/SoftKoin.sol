pragma solidity ^0.4.18;


contract SoftKoin{
    address private owner;
    string private  constant name = "SoftKoin";
    string private constant symbol = "SFK";
    mapping(address=>uint) private tokenHolderBalances;
    mapping(address=>mapping(address=>uint)) private tokenHolderApprovals;
    uint private totalSupply;

    function name() public constant returns (string){
        return name;
    }

    function symbol() public constant returns (string){
        return symbol;
    }

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
        return totalSupply;
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
        if(msg.sender==to && tokenHolderApprovals[from][to] >0 && tokenHolderApprovals[from]>0){
            tokenHolderBalances[from] = tokenHolderBalances[from]  - tokens;
            tokenHolderBalances[to] = tokenHolderBalances[to]  + tokens;
            tokenHolderApprovals[from][to] = tokenHolderApprovals[from][to] - tokens;
        } else {
            return false;
        }
    }
}


