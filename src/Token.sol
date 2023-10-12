 // SPDX-License-Identifier: MIT
 pragma solidity ^0.8.19;
import "../lib/solmate/src/tokens/ERC20.sol";
contract ERC20Token is ERC20{
    
    address tokenaaddr;

     constructor() ERC20("TOKENA", "TKNA", 18){
        tokenaaddr = msg.sender; 
    }
    function mint(address to, uint amount) public {
        _mint(to, amount);
    }

}