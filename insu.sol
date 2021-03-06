//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC721/ERC721.sol";

/**
 * @title Tech Insurance tor
 * @dev complete the functions
 */
 
contract TechInsurance is ERC721("Tahani", "CryptoNinja") {
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
    
    address payable public insOwner;
    
    mapping (uint256 => address) private _owners;
    
    event transfer(address from, address to, uint tokenId);
    
    function transferFrom(address from, address to, uint256 tokenId) public virtual override {
        require(_isApprovedOrOwner(_msgSender(), tokenId), "ERC721: transfer caller is not owner nor approved");

        _transfer(from, to, tokenId);
    }
    
    
    function ownerOf(uint256 tokenId) public view virtual override returns (address) {
        address owner = _owners[tokenId];
        require(owner != address(0), "ERC721: owner query for nonexistent token");
        return owner;
    }
    
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
    
    modifier change_Price(){
        require(insOwner == msg.sender, "you are not the owner");
        _;
    }

    function changePrice(uint _productIndex, uint _price) public change_Price { //inherit modifier 
       productIndex[_productIndex].price = _price;
    }
        
    uint256 public start = block.timestamp ;
    
    function buyInsurance( uint _Index, uint dayAfter) public payable {
        require(productIndex[_Index].offered == true, "InsuranceId already exists");
        require(block.timestamp < start + dayAfter * 3 days,"not allowed");
        Client memory newClient;
        newClient.isValid = true;
        newClient.time = block.timestamp;
        uint256 price = productIndex[_Index].price;
        payable(msg.sender).transfer(price);
    } 
    
    
}