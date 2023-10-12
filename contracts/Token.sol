 // SPDX-License-Identifier: MIT
 pragma solidity ^0.8.19;
import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
contract ERC20Token is ERC20{
    
    address tokenaaddr;

     constructor() ERC20("TOKENA", "TKNA"){
        tokenaaddr = msg.sender; 
    }
    function mint(uint amount) public {
        _mint(msg.sender, amount);
    }

}