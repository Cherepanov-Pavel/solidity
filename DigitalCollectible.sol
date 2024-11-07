// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DigitalCollectible {
    string public name = "Digital Collectible";
    string public symbol = "DCO";
    
    mapping(uint256 => address) public owners;
    mapping(address => uint256) public balances;
    uint256 public totalSupply;

    event Transfer(address indexed from, address indexed to, uint256 tokenId);

    function mint(address to, uint256 tokenId) public {
        require(owners[tokenId] == address(0), "Token already minted");
        
        owners[tokenId] = to;
        balances[to] += 1;
        totalSupply += 1;

        emit Transfer(address(0), to, tokenId);
    }

    function transfer(address to, uint256 tokenId) public {
        require(owners[tokenId] == msg.sender, "You do not own this token");
        
        owners[tokenId] = to;
        balances[msg.sender] -= 1;
        balances[to] += 1;

        emit Transfer(msg.sender, to, tokenId);
    }

    function ownerOf(uint256 tokenId) public view returns (address) {
        return owners[tokenId];
    }
}