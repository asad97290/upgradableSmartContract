// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC777/ERC777Upgradeable.sol";


contract Box is Initializable, ERC777Upgradeable{
    
    uint256 public basePrice;
    address public owner;
    mapping (address => uint) public pendingWithdrawals;    
    
    function initialize() public initializer {
        __ERC777_init("V1 Real Estate Innovative Technologies","VREIT",new address[](0));
        basePrice = 120000000000000; 
        owner = msg.sender;
        _mint(owner, 100000000 * 10**18, "", "");
    } 
    
    modifier onlyOwner() {
        require(msg.sender == owner, "only owner can run this function");
        _;
    }
        
    event PriceChange(uint256 newPrice,uint256 oldPrice);
    event CapChange(uint256 newCap,uint256 oldCap);
    
    function increaseInitialSupply(uint256 _initialSupply) public onlyOwner() {
        uint256 a = totalSupply();
        _mint(owner, _initialSupply * 10**18, "", "");
        emit CapChange(totalSupply(),a);
    }

    function adjustPrice(uint256 _newPrice) public onlyOwner() {
        uint256 a = basePrice;
        basePrice = _newPrice;
        emit PriceChange(_newPrice,a);
    }
    
    function buyToken() payable public returns(uint amount){
        require(msg.value > 0,"No ether value provided");
        require(msg.value >= basePrice,"price very low must be greater then or equal to base token price");
        require(msg.sender != address(0), "buyer should have EOA");
        uint wei_unit = (1*10**uint256(decimals()))/basePrice;
        amount = ((msg.value*((wei_unit)))/(1 ether))*(10 ** uint256(decimals()));
        pendingWithdrawals[msg.sender] += msg.value;  
        _move(owner,owner,msg.sender, amount,"","");  
        return amount;
    }
    
    function withdraw(uint256 tokens) public returns(bool){
        require(tokens* 10**18 <= balanceOf(msg.sender),"you don't have enough tokens to withdraw");
        uint ethValue = tokens*basePrice; 
        payable(msg.sender).transfer(ethValue);
        pendingWithdrawals[msg.sender] -= ethValue;
        burn(tokens* 10**18,"");
        return true;
    }

    
    
    receive() external payable {
        buyToken();
    }

    fallback() external payable {
        buyToken();
    }
}