// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.8.0;

contract MappingCiteies {
    mapping(string => string) cities;
    
    function input(string memory _cityName, string memory _countryName) public{
        cities[_cityName] = _countryName;
    }
    function get(string memory _name) public view returns(string memory)
    {
        return cities[_name];
    }
    
}