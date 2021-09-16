pragma solidity >= 0.8.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/proxy/Proxy.sol";


// **proxy smart contract like this** 
// contract Proxy {
//   address direction;

//   function update(address a) external {
//     direction= a;
//   }
// **proxy smart contract use fallback functions, because proxy have not any logic function** 
//   fallback() external {
//     address destination = direction;
//     assembly {
            // **copy call data**
//          calldatacopy(0, 0, calldatasize())
            // **call logic functions, use call data**
//          let result := delegatecall(gas(), destination, 0, calldatasize(), 0, 0)
            // **copy return data**
//          returndatacopy(0, 0, returndatasize())
            // **handle return data, if error result is 0 **
//          switch result
//          case 0 {revert(0, returndatasize())}
//          default {return (0, returndatasize())}
//      }
//   }
// }


contract testProxy is Proxy {
    address public implementation;
    
    function setImplementation(address _address) public {
        implementation = _address;
    }
    
    function _implementation() internal view override  returns (address) {
        return implementation;
    }
    
    
    function getbalance() public view returns(uint) {
        return address(this).balance;
    }
    
    
}


