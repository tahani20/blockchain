//SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 <0.8.1;

 //import "../github/OpenZeppelin/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol";


contract TechInsurance {
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
       
    uint productCounter;
  
    address public insOwner;
    constructor() public{
        insOwner = msg.sender;
    }
    
    mapping(uint => Product) public productIndex;
    mapping(address => mapping(uint => Client)) public client;
    
    
   mapping(address => uint256) private _balance;
   mapping(uint256 => address) private _owners;
   
   
   function _balanceOf(address owner) public view returns(uint256){
       require(owner !=address(0));
       return _balance[owner];
   }
   
    function _ownerOf(uint256 _id) public view returns(address){
       address owner = _owners[_id];
       require(owner != address(0));
       return _owners[_id];
   }
   
    function addProduct(uint _productId, string memory _productName, uint _price ) public  {
        Product memory newProduct = Product (_productId, _productName, _price, true);
        productIndex[productCounter++] = newProduct;
        productCounter++;
        _mint(msg.sender, productCounter);
    }
    
    function changeFalse(uint _Index) public  onlyOwner {
        productIndex[_Index].offered = false;
    }
    
    function changeTrue(uint _Index) public  onlyOwner{
        productIndex[_Index].offered = true;
    }
    
    modifier onlyOwner {
      require(msg.sender == insOwner, "you are not the owner" );
      _;
      revert("do not run this function again it cost you some fees");
     }
     
    function changePrice(uint _productIndex, uint _price) public  onlyOwner{ // inherit modifier
        productIndex[_productIndex].price = _price;
    }
    
    function buyInsurance(uint _productIndex) public  payable {
        require(productIndex[_productIndex].offered == true, "Tha Insurance is not available");
        Client memory newClient = Client (true, block.timestamp);
        client[msg.sender][_productIndex] =   newClient ;
        require(msg.value  == productIndex[_productIndex].price, "check the amount of the Insurance");
        uint256 price = productIndex[_productIndex].price;
        payable(msg.sender).transfer(price);
    } 
    
   function transferInsurance( address to, uint256 _id) public {
       require(msg.sender != to," You are the owner of this Insurance ");
       require(_ownerOf(_id) == msg.sender," Your not the Owner ");
        _transfer(msg.sender, to, _id);
    }
    
    function _transfer(address from, address to, uint256 tokenId) public {
        require(to != address(0));
        _balance[from] -= 1;
        _balance[to] += 1;
        _owners[tokenId] = to;
    }
    
    function _mint(address to, uint256 tokenId) public {
        require(to != address(0));
        _balance[to] += 1;
        _owners[tokenId] = to;
    }
}