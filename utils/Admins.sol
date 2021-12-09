// SPDX-License-Identifier: MIT
pragma solidity  >0.8.0 <0.9.0;

import "@openzeppelin/contracts/utils/structs/EnumerableSet.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Admins is Ownable {

    /**
     * @dev Using EnumrableSet
     */
    using EnumerableSet for EnumerableSet.AddressSet;

    /**
     * @dev admin accounts
     */
    EnumerableSet.AddressSet private _admins;

    modifier onlyAdmin {
        require(_admins.contains(_msgSender()), "only admin");
        _;
    }

    constructor() {
        addAdmin(_msgSender());
    }


    /**
     * @dev Check account is admin
     * @param account_ origin token address
     * @return if account_ is admin return true, else false
     */
    function isAdmin(address account_) public view returns(bool) {
        return _admins.contains(account_);
    }

    /**
     * @dev add admin account
     * @param account_ address
     * @return if add success return true, else false
     */
    function addAdmin(address account_) public onlyOwner returns(bool) {
        require(account_ != address(0), "account is zero address");
        return _admins.add(account_);
    }

    /**
     * @dev Check account is admin
     * @param account_ admin address
     * @return if remove success return true, else false
     */
    function removeAdmin(address account_) public onlyOwner returns(bool) {
        return _admins.remove(account_);
    }
  
}