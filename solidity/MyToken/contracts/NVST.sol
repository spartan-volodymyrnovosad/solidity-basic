// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./IERC20.sol";
import "./ERC20.sol";

contract NVST is ERC20 {

    constructor(address _shop) ERC20("Novosad Token", "NVST", 1000000000000, _shop) {

    }
}

contract MyShop {
    IERC20 public token;
    address payable public owner;
    event Bought(address indexed _buyer, uint _amount);
    event Sold(address indexed _seller, uint _amount);

    constructor() {
        token = new NVST(address(this));
        owner = payable(msg.sender);
    }

    receive() external payable {
        uint tokensToPurchase = msg.value; 
        require(tokensToPurchase > 0, "not enough funds");

        require(shopBalance() >= tokensToPurchase, "not enough tokens");

        token.transfer(msg.sender, tokensToPurchase);
        emit Bought(msg.sender, tokensToPurchase);
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "not an owner");
        _;
    }

    function sellToken(uint _amount) external {
        require(_amount > 0 && token.balanceOf(msg.sender) >= _amount, "incorrect amount of tokens to sell");

        uint allowance = token.allowance(msg.sender, address(this));
        require(allowance >= _amount, "allowance error");

        token.transferFrom(msg.sender, address(this), _amount);
        payable(msg.sender).transfer(_amount); // funct transfer reserves only 2300wei to complete transfer operation
        emit Sold(msg.sender, _amount);
    }

    function shopBalance() public view returns(uint) {
        return token.balanceOf(address(this));
    }   
}