// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

contract ContractHandler {
    uint public cBalance_;  // Contract Handler Balance
    address public cHandler_; // Contract Handler User


    constructor() { 
        cHandler_ = msg.sender;
    
    }

    modifier contOwner_() { // Contract Owner (Handler)
        require(cHandler_ == msg.sender, 
            "User Handler is Unauthorized");
        _;
    }

    function depoBalance_() //deposit value (funds)
    public payable contOwner_ {
        cBalance_ += msg.value;
    }

    function widrawBalance(uint amount) //withdrawal value (funds)
    public contOwner_ {
        require(cBalance_ >= amount, 
            "Insufficient Amount of Balance");
           
            cBalance_ -= amount;
        
        payable(cHandler_).transfer(amount);
    }
}
