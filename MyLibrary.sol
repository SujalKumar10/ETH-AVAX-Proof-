// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract Library{

    address private Owner;
    mapping (string => bool) private available;
    mapping (address => string) private borrow;
    mapping (string => uint) public Units;
    mapping (string => bool) private byOwner;

    constructor() {
        Owner = msg.sender;
    }

    modifier onlyOwner{
        require(msg.sender == Owner,"This function is only for the owner");
        _;
    }

    function Add_Book(string memory Name) public onlyOwner{
        available[Name] = true;
        byOwner[Name] = true;
        Units[Name]++; 
    }

    function Borrow_Book(string memory Name) public payable {
        require(available[Name],"Book is not available now");
        Units[Name]--; 
        borrow[msg.sender] = Name;
        assert(Units[Name]<=0);
        available[Name] = false;
    }

    function Return_Book(string memory Name) public {
        string memory borrowedBook = borrow[msg.sender];
        require(bytes(borrowedBook).length != 0, "You have not borrowed any book");

        if(!byOwner[Name]){
            revert("This book is not from this liberary");
        }
        Units[Name]++;
        available[Name] = true;
    }


}
