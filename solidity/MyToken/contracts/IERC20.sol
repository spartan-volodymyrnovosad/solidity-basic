// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IERC20 {
    function name() external view returns(string memory);

    function symbol() external view returns(string memory);

    function decimals() external pure returns(uint); // amount of numbers after decimal in my token

    function totalSuply() external view returns(uint);

    function balanceOf(address account) external view returns(uint);

    function transfer(address _to, uint amount) external;

    function allowance(address _owner, address _spender) external view returns(uint);

    function approve(address _spender, uint _amount) external;

    function transferFrom(address _sender, address _recipient, uint _amount) external;

    function burnTokens(address _from, uint _amount) external;

    event Transfer(address indexed _from, address indexed _to, uint _amount);

    event Approve(address indexed _owner, address indexed _to, uint _amount);
}