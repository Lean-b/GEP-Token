// SPDX-License-Identifier: MIT

pragma solidity 0.8.13;

import "./IERC20.sol";

contract ERC20 is IERC20 {
    string private name = "GreenPower";
    string private symbol = "GEP";
    uint8 decimals = 18;
    uint256 totalSupply_;

    mapping(address => uint256) private balance;
    mapping(address => mapping(address => uint256)) private allowed;

    constructor(uint256 _totalSupply) {
        totalSupply_ = _totalSupply;
    }

    function totalSupply() public view returns (uint256) {
        return totalSupply_;
    }

    function balanceOf(address owner) public view returns (uint256) {
        return balance[owner];
    }

    function allowance(
        address owner,
        address spender
    ) public view returns (uint256) {
        return allowed[owner][spender];
    }

    function transfer(address to, uint256 value) public returns (bool) {
        balance[msg.sender] -= value;
        balance[to] += value;
        emit Transfer(msg.sender, to, value);
        return true;
    }

    function approve(address spender, uint256 value) public returns (bool) {
        allowed[msg.sender][spender] = value;
        emit Approval(msg.sender, spender, value);
        return true;
    }

    function transferFrom(
        address from,
        address to,
        uint256 value
    ) public returns (bool) {
        allowed[from][msg.sender] -= value;
        balance[from] -= value;
        balance[to] += value;
        emit Transfer(from, to, value);
        return true;
    }

    function mint(address to, uint256 value) internal {
        totalSupply_ += value;
        balance[to] += value;
        emit Transfer(address(0), to, value);
    }

    function burn(address from, uint256 value) internal {
        balance[from] -= value;
        totalSupply_ -= value;
        emit Transfer(from, address(0), value);
    }
}
