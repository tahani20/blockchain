//SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 <0.8.1;

/**
 * @title Tech Insurance tor
 * @dev complete the functions
 */
contract TechInsurance {
    
    
    /** 
     * Define two structs
     * 
     * 
     */
    struct Product {
        uint productId;
        string productName;
        uint price;
        bool offered;
    }
     
    struct Client {
        bool isValid;
        uint time;
    }
    
    
    mapping(uint => Product) public productIndex;
    mapping(address => mapping(uint => Client)) public client;
    
    uint productCounter;
    
    address payable insOwner;
    constructor(address payable _insOwner) public{
        insOwner = _insOwner;
    }
 
    function addProduct(uint _productId, string memory _productName, uint _price ) public {
        
        Product memory newproduct = Product(_productId, _productName, _price, true);
        productIndex [_productId] = newproduct;
     // productCounter++;
    }
    
    
    function changeFalse(uint _Index) public {
     productIndex[_Index].offered = false;
    }
    
    function changeTrue(uint _Index) public {
        productIndex[_Index].offered = true;
  
    }
    
    function changePrice(uint _productIndex, uint _price) public {
       productIndex[_productIndex].price = _price;
    }
        modifier _price(){
        require(insOwner == msg.sender, "you are not the owner");
        _;
        }

    
    
    function clientSelect(uint _productIndex) public payable {
        //function clientSelect(uint _productIndex) public payable {
       // require(block.timestamp+2, "not allowed")}
        Client memory newClient;
        newClient.isValid = true;
        newClient.time = block.timestamp;
        
    } 
    
}