// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Uchiha is ERC20 {
    address public _owner;
    uint256 public claimAmount = 100 ether;
    mapping(address => bool) public whitelistedAddresses;
    mapping(address => bool) public claimedAddresses;


    constructor(uint256 totalSupply) ERC20('Ghost Of Uchiha', 'GOU') {
        _owner = msg.sender;
        _mint(address(this), totalSupply * 1e18);
    }

    function mint(uint256 amount) public owner {
        _mint(address(this), amount * 1e18);
    }

    function burn(uint256 amount) public owner {
        _burn(address(this), amount * 1e18);
    }

     function claimableAmount(uint256 amount ) public owner returns (uint256){
         return claimAmount = amount * 1e18;
    }
    
    function whitelistAddress() public {
        whitelistedAddresses[msg.sender] = true;
    }

    function claim() public {
        require(whitelistedAddresses[msg.sender]);
        require(!claimedAddresses[msg.sender]);
        
        claimedAddresses[msg.sender] = true;

        ERC20(address(this)).transfer(msg.sender, claimAmount);
    }

    modifier owner() {
        require(msg.sender == _owner, 'Only owner!!!');
        _;
    }
}
