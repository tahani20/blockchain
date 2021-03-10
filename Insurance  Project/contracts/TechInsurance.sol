
//SPDX-License-Identifier: MIT

pragma solidity ^0.7.0;

contract Cars {
    
    struct Car {
        string name;
        uint256 year;
        uint amount;
        bool forSale;
        address  carOwnerAdress;
        address buyerAddress;
    }
    
    event CarLoaded(
        string name,
        uint year,
        uint amount
        );
        
    event Sold(
        uint256 _carId);
    
    
    mapping(address=> uint256) private ownedCars;
    mapping(uint => Car) private carId; /* map the counter to a car */
    mapping (uint256 => address) private owners;
    
    
    modifier onlyCreator(uint256 _id){
        require(onlyOwner(_id) == msg.sender, "You are not authorized!");
        _;
    }
    
    function onlyOwner(uint256 _tokenId) public view returns (address) {
        address owner = owners[_tokenId];
        require(owner != address(0));
        return owner;
    }
    
    function mint(address _to, uint256 _tokenId) internal {
        owners[_tokenId] = _to;
        ownedCars[_to] += 1;
    }
    
    uint256 counter ; // increasment 
    
    /**
     * this function takes 3 args to input values to the struct Car
     */
    function addCar(string memory _name, uint256 _year, uint256 _amount) public{
    counter++;
    
    // require(owners[counter] != address(0), "Token already minted");
    carId[counter] = Car(_name, _year, _amount, true, msg.sender, address(0));
    mint(msg.sender, counter);
    emit CarLoaded(_name, _year, _amount);

    }
    
    /**
     * this function to check if it is for sale
     */
    function isItSold(uint256 _carId) public view returns(bool){
         return carId[_carId].forSale;
        
    }
    
     function lookup(uint256 _id) public view returns(string memory){
        return carId[_id].name;
        
    }
    
    function fatch(uint _carId) public view returns(string memory name, uint year, uint amount, bool status , address owner, address buyer){
        name = carId[_carId].name;
        year = carId[_carId].year;
        amount = carId[_carId].amount;
        status = carId[_carId].forSale;
        owner = carId[_carId].carOwnerAdress;
        buyer = carId[_carId].buyerAddress;

        
    }
    
    /**
     * A payable function to transfer the value 
     */
    function payment(uint256 _carId) public payable {
        address buyer = msg.sender;
        require(carId[_carId].forSale != false, "The car is sold");
        require(carId[_carId].forSale == true, "the car has to be listed for sale");
        require(msg.value >= carId[_carId].amount, " check the amount of the car");
        
        
        carId[_carId].forSale = false; // update the status of the car
        uint256 price = carId[_carId].amount;
        carId[_carId].buyerAddress = buyer; // update buyer address
        payable(carId[_carId].carOwnerAdress).transfer(price);
        carId[_carId].carOwnerAdress = buyer;  // update the owner address

        //9000000000000000000 = 9 ether
        emit Sold(_carId);
        
    
}
}