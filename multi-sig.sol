//SPDX-License-Identifier: MIT
pragma solidity ^0.7.0;

//import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC721/ERC721.sol";

 
contract TechInsurance {  //is ERC721("Tahani", "CryptoNinja") 

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
    mapping(address => uint256)private _balances;
    mapping (uint256 => address) private _owners;
    
    
    uint productCounter;
    //address public insOwner;
    
    
    
    //multisig vars
    
    address private contractOwner;
    uint M = 2;
    address [] public authenticators ;
    address [] public n_Authenticators; //who are those

    mapping (address => bool) public isAuther;

    mapping (uint => mapping (address => bool)) public confirmations;
    
    constructor() public {
        contractOwner = msg.sender;
       // authenticators.push(msg.sender);
        isAuther[msg.sender] = false; //is it should be true?
    }
 
     modifier onlyContractOwner() {
        require(msg.sender == contractOwner, "Not contract owner");
        _;
    }
    
    modifier notNull() {
    require(msg.sender != address(0)); //0 mean no owner
        _;
    }
    
    
    modifier AuthenticatorExist(address _address){
        require(isAuther[_address] == false, "already added!");
        _;
   }
   
   function getAuths() public view returns (address[] memory)
    {
        return authenticators;
        
    }
    
    function addAuths(address _address) public onlyContractOwner() AuthenticatorExist(_address) notNull() {
         isAuther[_address] = true; 
        
    }
    
    function Authrize() public notNull() returns (uint _x) { //may add inherit onlyowner!
        require(isAuther[msg.sender] == true, "no you can't");
        authenticators.push(msg.sender);
        return (authenticators.length);
    }
  
    
    //event transfer(address from, address to, uint tokenId);
    //my contract
    function transferFrom(address to, uint256 tokenId) public  onlyContractOwner(){
       require(msg.sender != to," You are the owner of this Insurance "); 
       //require(ownerOf(tokenId) == msg.sender," Your not the Owner "); //still need it?
       _transfer(msg.sender, to, tokenId);
    }
    
    function _transfer(address from, address to, uint256 tokenId) public { 
        require(to != address(0));

        _balances[from] -= 1;
        _balances[to] += 1;
        _owners[tokenId] = to;
    }
    
    
   function balanceOf(address owner)public view returns(uint256){
         require(owner != address(0));
         return _balances[owner];
     }
     
     function ownerOf(uint256 tokenId)public view returns(address){
         address owner = _owners[tokenId];
         require(owner != address(0));
         return _owners[tokenId];
     }
     
     
     
    
    //constructor() public{
      //  insOwner = msg.sender;
    //}
    
    function addProduct(uint _productId, string memory _productName, uint _price ) public onlyContractOwner() {
        Product memory newproduct = Product(_productId, _productName, _price, true);
        productIndex [productCounter++] = newproduct;
        productCounter++;
    }
    
    function changeFalse(uint _Index) public  { // should add onlyowner??
     productIndex[_Index].offered = false;
    }
    
    function changeTrue(uint _Index) public{
        productIndex[_Index].offered = true;
    }
    
    //modifier change_Price(){
      //  require(insOwner == msg.sender, "you are not the owner");
     // _;
    //}

    function changePrice(uint _productIndex, uint _price) public onlyContractOwner() { //inherit modifier 
       productIndex[_productIndex].price = _price;
    }
        
    //uint256 public start = block.timestamp ;
    
    function buyInsurance( uint _productIndex) public payable{ //uint dayAfter
        require(productIndex[_productIndex].offered == true, "Tha Insurance is not available");
        require(msg.value  == productIndex[_productIndex].price, "check the amount of the Insurance");
        
        Client memory newClient = Client (true, block.timestamp);
        client[msg.sender][_productIndex] =   newClient ;

        payable(msg.sender).transfer(msg.value);
        
       
    } 
    
    
}