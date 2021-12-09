// SPDX-License-Identifier: MIT
pragma solidity  >0.8.0 <0.9.0;


/**
* @title OrderList
* @dev 
*/
contract OrderList {
    mapping(address => bytes32) public userCode;
    mapping(address => address) private _nextUsers;
    uint256 internal listSize;
    address constant firstAddress = address(1);

    constructor() {
        _nextUsers[firstAddress] = firstAddress;
    }
    
    function addElement(address user_, bytes32 code_) internal {
        require(user_ != address(0), "orderList: zero address");
        require(_isNotExists(user_), "is exists");
        address candidateAddress = _findIndex(code_);
        require(candidateAddress != address(0), "orderList: user is not exists");
        userCode[user_] = code_;
        _nextUsers[user_] = _nextUsers[candidateAddress];
        _nextUsers[candidateAddress] = user_;
        listSize++;
    }

    function removeElement(address user_) internal {
        require(!_isNotExists(user_), "is not exists");
        address preAddress = _findPreIndex(user_);
        require(preAddress != address(0), "orderList: user is not exists");
        _nextUsers[preAddress] = _nextUsers[user_];
        _nextUsers[user_] = address(0);
        userCode[user_] = 0;
        listSize--; 
    }

    function updateElement(address user_, bytes32 code_) internal {
        if (_isNotExists(user_)) {
            addElement(user_, code_);
            return;
        } 
        address preAddress = _findPreIndex(user_);
        require(preAddress != address(0), "orderList: user is not exists");
        _nextUsers[preAddress] = _nextUsers[user_];
 
        address candidateAddress = _findIndex(code_);
        require(candidateAddress != address(0), "orderList: user is not exists");
        _nextUsers[user_] = _nextUsers[candidateAddress];
        _nextUsers[candidateAddress] = user_;
        userCode[user_] = code_;
    }

    function getTop(uint256 k) internal view returns(address[] memory userLists) {
        require(k <= listSize);
        userLists = new address[](k);
        address currentAddress = _nextUsers[firstAddress];
        for(uint256 i = 0; i < k; ++i) {
            userLists[i] = currentAddress;
            currentAddress = _nextUsers[currentAddress];
        }
    }

    function _isNotExists(address user_) private view returns(bool) {
        return _nextUsers[user_] == address(0) && userCode[user_] == bytes32("");
    }

    function _findIndex(bytes32 code) private view returns(address candidateAddress) {
        candidateAddress = firstAddress;
        while(true) {
            if(_verifyIndex(candidateAddress, code, _nextUsers[candidateAddress]))
                break;
            candidateAddress = _nextUsers[candidateAddress];
            if (candidateAddress == address(0))
                break;
        }
    }

    function _findPreIndex(address user_) private view returns(address candidateAddress) {
        candidateAddress = firstAddress;
        while(true) {
            if(_nextUsers[candidateAddress] == user_)
                break;
            candidateAddress = _nextUsers[candidateAddress];
            if (candidateAddress == address(0))
                break;
        }
    }

    function _verifyIndex(address prevUser, bytes32 newValue, address nextUser) private view returns(bool) {
        return (prevUser == firstAddress || userCode[prevUser] >= newValue) && (nextUser == firstAddress || newValue > userCode[nextUser]);
    }

}
