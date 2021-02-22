// SPDX-License-Identifier: MIT


/**
 * @title Reinforcement 1 - Exercises
 * @ Question 1) This is a short solidity function, isMultiple(n, m), 
 * that takes two integer values and returns True if n is a multiple of m, 
 * and False otherwise.
 * 
 * @ Question 2) A short solidity function takes two integer values
 * and returns the maximum element between two integers
 * 
 */


pragma solidity >=0.6.0 <0.8.0;

contract Math{


    function isMultiple(uint8 _n, uint8 _m) public pure returns(bool) {
        
        // Write your code here
         return(_n% _m==0);
         
            //if (_n%_m == 0){
            //return true;}
            //else{
            //return false;
            //}
        }
    
    function max(uint256 _n, uint256 _m) public pure returns(uint256) {
        // Write your code here

       if (_n>_m){
           return _n;
       }
        else{
            return _m;  
        }
}
}