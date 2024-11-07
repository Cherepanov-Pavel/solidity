// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract EsportsNFT is ERC721Enumerable, Ownable {
    string public baseURI;
    uint256 public nextTokenId;
    mapping(address => bool) public hasMinted;

    event Minted(address indexed owner, uint256 tokenId);

    // Constructor with name and symbol parameters for ERC721
    constructor(string memory name, string memory symbol, string memory _baseURI) 
        ERC721(name, symbol) {
        baseURI = _baseURI;
        nextTokenId = 1; // Start token IDs from 1
    }

    function mintNFT() external {
        require(!hasMinted[msg.sender], "You have already minted an NFT.");
        hasMinted[msg.sender] = true;

        uint256 tokenId = nextTokenId;
        nextTokenId++;
        _safeMint(msg.sender, tokenId);
        
        emit Minted(msg.sender, tokenId);
    }

    function _baseURI() internal view override returns (string memory) {
        return baseURI;
    }

    function setBaseURI(string memory _baseURI) external onlyOwner {
        baseURI = _baseURI;
    }

    function totalSupply() public view returns (uint256) {
        return nextTokenId - 1; // Adjust for the starting token ID
    }
}
