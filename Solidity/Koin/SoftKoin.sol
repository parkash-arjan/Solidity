pragma solidity ^0.4.18;


contract SoftKoin{
    address private owner;
    string public  constant name = "SoftKoin";
    string public constant symbol = "SFK";
    mapping(address=>uint) private tokenHolderBalances;
    mapping(address=>mapping(address=>uint)) private tokenHolderApprovals;
    uint private totalTokenSupply = 1000000;
    mapping(address=>uint) coinHolders;

    function SoftKoin() public{
        owner = msg.sender;
        tokenHolderBalances[msg.sender] = totalTokenSupply;
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
    // https://theethereum.wiki/w/index.php/ERC20_Token_Standard
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
            Transfer(msg.sender,to,tokens);
            return true;
        } else {
            return false;
        }
    }

    function approve(address spender, uint tokens) public returns (bool success){
        if(tokenHolderBalances[msg.sender]>tokens){
            tokenHolderApprovals[msg.sender][spender] = tokens;
            Approval(msg.sender,spender,tokens);
            return true;
        } else {
            return false;
        }
    }

    function allowance(address tokenOwner, address spender) public constant returns (uint remaining){
        return tokenHolderApprovals[tokenOwner][spender];
    }

    function transferFrom(address from, address to, uint tokens) public returns (bool success){
        // if(tokens>0 && tokenHolderBalances[from]>0 && tokenHolderApprovals[from][msg.sender] >0 && tokenHolderApprovals[from][msg.sender] >tokens){
        if(tokens>0 && tokenHolderBalances[from]>0  && tokenHolderApprovals[from][msg.sender] >tokens){
            tokenHolderBalances[from] = tokenHolderBalances[from]  - tokens;
            tokenHolderBalances[to] = tokenHolderBalances[to]  + tokens;
            tokenHolderApprovals[from][to] = tokenHolderApprovals[from][to] - tokens;
            Transfer(from,to,tokens);
            return true;
        } else {
            return false;
        }
    }

    event Transfer(address indexed from, address indexed to, uint tokens);

    event Approval(address indexed tokenOwner, address indexed spender, uint tokens);
}


