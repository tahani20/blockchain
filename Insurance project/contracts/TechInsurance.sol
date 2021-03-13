//SPDX-License-Identifier: MIT
pragma solidity ^0.7.0;

//import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC721/ERC721.sol";

/**
 * @title Tech Insurance tor
 * @dev complete the functions
 */
 
contract TechInsurance {  //is ERC721("Tahani", "CryptoNinja") 
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
    
    address public insOwner;
    
    
    mapping(address => uint256)private _balances;
    mapping (uint256 => address) private _owners;
    
    
    //event transfer(address from, address to, uint tokenId);
    
    function transferFrom(address to, uint256 _Id) public{
       require(msg.sender != to," You are the owner of this Insurance ");
       require(ownerOf(_Id) == msg.sender," Your not the Owner ");
       _transfer(msg.sender, to, _Id);

    }
    
   function balanceOf(address owner)public view returns(uint256){
         require(owner != address(0));
         return _balances[owner];
     }
     
     function ownerOf(uint256 _id)public view returns(address){
         address owner = _owners[_id];
         require(owner != address(0));
         return _owners[_id];
     }
     
     
     function _transfer(address from, address to, uint256 tokenId) public {
        require(to != address(0));

        _balances[from] -= 1;
        _balances[to] += 1;
        _owners[tokenId] = to;
    }
    
    
    constructor() public{
        insOwner = msg.sender;
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
    
    modifier change_Price(){
        require(insOwner == msg.sender, "you are not the owner");
        _;
    }

    function changePrice(uint _productIndex, uint _price) public change_Price { //inherit modifier 
       productIndex[_productIndex].price = _price;
    }
        
    uint256 public start = block.timestamp ;
    
    function buyInsurance( uint _productIndex) public payable{ //uint dayAfter
        require(productIndex[_productIndex].offered == true, "Tha Insurance is available");
        require(msg.value  == productIndex[_productIndex].price, "check the amount of the Insurance");
        
        Client memory newClient = Client (true, block.timestamp);
        client[msg.sender][_productIndex] =   newClient ;
        uint256 price = productIndex[_productIndex].price;
        payable(msg.sender).transfer(price);
        
       
    } 
    
    
}