//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC721/ERC721.sol";
//import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC721/IERC721.sol";
/**
 * @title Tech Insurance tor
 * @dev complete the functions
 */
contract TechInsurance is ERC721("Taha", "Ninja") {
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
        productIndex [productCounter++] = newproduct;
        productCounter++;
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
        modifier change_Price(){
        require(insOwner != msg.sender, "you are not the owner");
        _;
        }
        
    uint256 public start = block.timestamp ;
    function clientSelect( uint _productIndex, uint dayAfter) public payable { //uint _productIndex
        //function clientSelect(uint _productIndex) public payable {
       // require(block.timestamp+2, "not allowed")
        require(productIndex[_productIndex].price == msg.value, "Product is soldout" );
        require(block.timestamp < start + dayAfter * 3 days,"not allowed");
        Client memory newClient;
        newClient.isValid = true;
        newClient.time = block.timestamp;
    } 
    
    function buyInsurance(uint _Index) public payable { //,uint secAfter
        require(productIndex[_Index].offered == true, "InsuranceId already exists");
        //require(block.timestamp < start + secAfter * 12 weeks ,"insurance expaired");
        //productIndex[_Index].;
    } 
    
}