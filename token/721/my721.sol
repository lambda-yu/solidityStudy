// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

contract CuteCatNFT is ERC721URIStorage {
    uint public counter;
    
    constructor() ERC721("BigTitsNft","BT") {
        counter = 0;
    }
    
    function createNFTs (string memory tokenURI) public returns (uint){
        uint tokenId = counter;
        _safeMint(msg.sender,tokenId);
        _setTokenURI(tokenId,tokenURI);
        counter++;
        return tokenId;
    }
    
    function burn(uint tokenId) public {
        require(_isApprovedOrOwner(_msgSender(), tokenId), "ERC721: transfer caller is not owner nor approved");
        super._burn(tokenId);
    }
}