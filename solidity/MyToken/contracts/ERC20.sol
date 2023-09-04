// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./IERC20.sol";

contract ERC20 is IERC20 {
    uint totalTokens;
    address owner;
    mapping(address => uint) balances;
    mapping(address => mapping(address => uint)) allowances; // contains data about wallets that can get tokens from another wallet by access
    string tokenName;
    string tokenSymbol;

    modifier enoughTokens(address _from, uint _amount) {
        require(balanceOf(_from) >= _amount, "not enough tokens");
        _;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "not an owner");
        _;
    }

    constructor(string memory _name, string memory _symbol, uint initialSupply, address shop) {
        tokenName = _name;
        tokenSymbol = _symbol;
        owner = msg.sender;
        // balances[0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266] = 10000;
        // balances[0x70997970C51812dc3A010C7d01b50e0d17dc79C8] = 10000;
        mint(initialSupply, shop);
    }

    function mint(uint _amount, address _shop) public onlyOwner {
        beforeTokenTransfer(msg.sender, _shop, _amount);

        balances[_shop] += _amount;
        totalTokens += _amount;
        emit Transfer(address(0), _shop, _amount);
    }

    function name() external view returns(string memory) {
        return tokenName;
    }

    function symbol() external view returns(string memory) {
        return tokenSymbol;
    }

    function decimals() external pure returns(uint) {
        return 18;
    }

    function totalSuply() external view returns(uint) {
        return totalTokens;
    }

    function balanceOf(address account) public view returns(uint) {
        return balances[account];
    }

    function transfer(address _to, uint amount) public enoughTokens(msg.sender, amount) {
        beforeTokenTransfer(msg.sender, _to, amount);

        balances[msg.sender] -= amount;
        balances[_to] += amount;
        emit Transfer(msg.sender, _to, amount);
    }

    function allowance(address _owner, address _spender) public view returns(uint) {
        return allowances[_owner][_spender];
    }

    function approve(address _spender, uint _amount) public {
        _approve(msg.sender, _spender, _amount);
        emit Approve(msg.sender, _spender, _amount);
    }

    function transferFrom(address _sender, address _recipient, uint _amount) public enoughTokens(_sender, _amount){
        beforeTokenTransfer(_sender, _recipient, _amount);

        allowances[_sender][_recipient] -= _amount;
        balances[_sender] -= _amount;
        balances[_recipient] += _amount;
        emit Transfer(_sender, _recipient, _amount);
    }

    function _approve(address _sender, address _spender, uint _amount) internal virtual {
        allowances[_sender][_spender] = _amount;
    }

    function burnTokens(address _from, uint _amount) public onlyOwner {
        beforeTokenTransfer(_from, address(0), _amount);

        balances[_from] -= _amount;
        totalTokens -= _amount;
    }

    function beforeTokenTransfer(address _from, address _to, uint amount) internal virtual { // check requirements before transfer

    }

}