// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract MyWallet{
    mapping(address => uint) private balances;
    mapping(address => bool) private account;
    mapping(address => uint) private WalletID;

    modifier walletID(){
        require(account[msg.sender] == true,"Enter Wallet ID");
        _;
    }

    function Wallet_ID(uint ID) public {
        WalletID[msg.sender] = ID;
        account[msg.sender] = true;
    }

    function deposit(uint Amount) public walletID{
        assert(balances[msg.sender] + Amount>= Amount);
        balances[msg.sender]+= Amount;
    }

    function withdraw(uint amount) public walletID{
        require(amount <= balances[msg.sender], "Insufficient Balance");
        balances[msg.sender] -= amount;
        
    }

    function CheckBalance(uint ID) public view returns(uint){
        if(ID != WalletID[msg.sender]){
            revert("Incorrct ID");
        }
        return balances[msg.sender];

    }


}
