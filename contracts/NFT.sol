 // SPDX-License-Identifier: MIT
 pragma solidity ^0.8.19;

 import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";

 contract ERC721NFT is ERC721 {
    
        constructor() ERC721("TOKENA", "TKNA"){
        tokenaaddr = msg.sender; 
    }
    function mint(uint id) public {
        _mint(msg.sender, id);
    }
 
 }