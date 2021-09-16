pragma solidity >= 0.8.0;




contract A {
   
    mapping(address => uint256) balance;
    
    fallback() external payable {
        
    }
    
    receive() external payable {
        
    }
    
    function getbalance() public view returns(uint) {
        return address(this).balance;
    }
    
    function get(address _address) public view returns(uint) {
        return balance[_address];
    }
    
    function set(address _address, uint _amount) public{
        balance[_address] += _amount;
    }
    

}


