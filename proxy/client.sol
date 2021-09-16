pragma solidity >= 0.8.0;




interface A {
    function get(address _address) external view returns(uint);
    function set(address _address, uint _amount) external payable;
    function burn(address _address, uint _amount) external payable;
    
}

contract B{
    A a;
    
    function setContract(address _address) public {
        a = A(_address);
        
    }
    
    function getA(address _address) public view returns(uint) {
        return a.get(_address);
    }
    
    function setA(address _address, uint _amount) public payable{
        a.set(_address, _amount);
    }
    
    function burnA(address _address, uint _amount) public{
        a.burn(_address, _amount);
    }
}

