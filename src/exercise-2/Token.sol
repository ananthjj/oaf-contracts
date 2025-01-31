// ananthjj
// 04/20/2023
// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

interface IERC20 {
function totalSupply() external view returns (uint256);
function balanceOf(address account) external view returns (uint256);
function transfer(address recipient, uint256 amount) external returns (bool);
function allowance(address owner, address spender) external view returns (uint256);
function approve(address spender, uint256 amount) external returns (bool);
function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);
event Transfer(address indexed from, address indexed to, uint256 value);
event Approval(address indexed owner, address indexed spender, uint256 value);
}

contract Token is IERC20 {
mapping(address => uint256) private _balances;
mapping(address => mapping(address => uint256)) private _allowances;
uint256 private _totalSupply;
constructor(uint256 totalSupply) {
    _totalSupply = totalSupply;
    _balances[msg.sender] = totalSupply;
}

function totalSupply() external view override returns (uint256) {
    return _totalSupply;
}

function balanceOf(address account) external view override returns (uint256) {
    return _balances[account];
}

function transfer(address recipient, uint256 amount) external override returns (bool) {
    require(_balances[msg.sender] >= amount, "Insufficient balance");
    _balances[msg.sender] -= amount;
    _balances[recipient] += amount;
    emit Transfer(msg.sender, recipient, amount);
    return true;
}

function allowance(address owner, address spender) external view override returns (uint256) {
    return _allowances[owner][spender];
}

function approve(address spender, uint256 amount) external override returns (bool) {
    _allowances[msg.sender][spender] = amount;
    emit Approval(msg.sender, spender, amount);
    return true;
}

function transferFrom(address sender, address recipient, uint256 amount) external override returns (bool) {
    require(_balances[sender] >= amount, "Insufficient balance");
    require(_allowances[sender][msg.sender] >= amount, "Insufficient allowance");
    _balances[sender] -= amount;
    _balances[recipient] += amount;
    _allowances[sender][msg.sender] -= amount;
    emit Transfer(sender, recipient, amount);
    return true;
}
