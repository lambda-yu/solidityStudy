// contracts/GameItems.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";

contract Items is ERC1155 {
    address Contract_owner;
    mapping(uint => string) tokenUris;
    mapping(uint => string) tokenNames;
    mapping(string => mapping(string => uint)) public tokenIds;
    mapping(uint => uint) public circulation;
    uint current_id = 1;
    
    constructor() ERC1155("") {
        Contract_owner = msg.sender;
    }
    
    function mint(string memory uri, uint amount, string memory name) public  {
        require(msg.sender == Contract_owner, "you have no authority");
        uint id = tokenIds[name][uri];
        if (id == 0) {
            id = current_id;
            current_id ++;
        }
        _mint(msg.sender, id, amount, "");
        circulation[id]  += amount;
        tokenUris[id] = uri;
        tokenNames[id] = name;
        tokenIds[name][uri] = id;
    }
    
    function uri(uint256 tokenId) public view override returns (string memory) {
        return tokenUris[tokenId];
    }
    
    function name(uint256 tokenId) public view  returns (string memory) {
        return tokenNames[tokenId];
    }
    
    function burn(address _address, uint tokenId, uint amount) public {
        _burn(_address, tokenId, amount);
        if (circulation[current_id] == 0) {
            delete tokenUris[tokenId];
            delete tokenNames[tokenId];
            delete tokenIds[tokenNames[tokenId]][tokenUris[tokenId]];
        }

    }
}