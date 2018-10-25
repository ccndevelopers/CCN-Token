pragma solidity 0.4.25;
contract ERC20 {
  uint256 public totalSupply;
  function balanceOf(address who) public view returns (uint256 _user);
  function transfer(address to, uint256 value) public returns (bool success);
  function allowance(address owner, address spender) public view returns (uint256 value);
  function transferFrom(address from, address to, uint256 value) public returns (bool success);
  function approve(address spender, uint256 value) public returns (bool success);

  event Transfer(address indexed from, address indexed to, uint256 value);
  event Approval(address indexed owner, address indexed spender, uint256 value);
}