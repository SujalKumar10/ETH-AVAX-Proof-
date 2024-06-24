# Wallet Management Contract
## Description

This is Solidity based smart contract defines which is used to manage the library by doing functions like adding, borrowing, returning and counting the books. The contract includes error handeling using solidity's **require()**, **assert()**, **revert()** statements. 
## Contents
**Variable**

 - `Owner` :Used as the owner of the library.
   
    ```solidity
   address private Owner;
  
**Mapping**

 - `available` :A mapping from name of the book to the availability of the book.
   
    ```solidity
   mapping (string => bool) private available;

- `borrow` :A mapping from address to check if the book is borrowed.
   
    ```solidity
   mapping (address => string) private borrow;
    
- `Units` :A mapping from name of the book to the number of units present.
   
    ```solidity
   mapping (string => uint) public Units;

 - `byOwner` :A mapping from name of the book to if the book was added by the owner.
   
    ```solidity
   mapping (string => bool) private byOwner;   


**Functions:**

- `Add_Book` : Used to add books by the owner.
   
   ```solidity
   function Add_Book(string memory Name) public onlyOwner{
        available[Name] = true;
        byOwner[Name] = true;
        Units[Name]++; 
    }
- `Borrow_Book` : Used to borrow available books from the owner.
    ```solidity
   function Borrow_Book(string memory Name) public payable {
        require(available[Name],"Book is not available now");
        Units[Name]--; 
        borrow[msg.sender] = Name;
        assert(Units[Name]<=0);
        available[Name] = false;
    }
- `Return_Book` : Used to return the borrowed books to the library.
    ```solidity
    function Return_Book(string memory Name) public {
        string memory borrowedBook = borrow[msg.sender];
        require(bytes(borrowedBook).length != 0, "You have not borrowed any book");

        if(!byOwner[Name]){
            revert("This book is not from this library");
        }
        Units[Name]++;
        available[Name] = true;
    }

   
**Modifiers**
  - `onlyOwner` : Make sure the task is only done by the owner.
   
    ```solidity
    modifier onlyOwner{
        require(msg.sender == Owner,"This function is only for the owner");
        _;
    }
## Functionalities

1. **Adding the books :**
  - Owner can add the books to the library.
2. **Borrow books :**
  - We can borrow the available books from the library.
3. **Returning books :**
  - Borrowed books can be returned to the library.

## Getting Started

**Steps to run this code :** 

1. Open remix IDE.
2. Create a new file.
3. Copy the code from MyLibrary.sol.
4. Paste that code in your new file.
5. Compile the code.
6. Deploy the contract.

## License

This project is UNLICENSED.
