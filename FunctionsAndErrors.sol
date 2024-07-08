// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

contract Email_Handling {
    address public handler;
    uint256 public mails;

    event Deploy(address indexed sender, uint256 amount);
    event Reply(address indexed recipient, uint256 amount);
    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    modifier onlyOwner() {
        require(msg.sender == handler, "Handler is not the owner");
        _;
    }

    constructor() {
        handler = msg.sender;
    }

    function inbox() external payable {
        require(msg.value > 0, "Inbox must be greater than zero");
        mails += msg.value;
        assert(mails >= msg.value);
        emit Deploy(msg.sender, msg.value);
    }

    function sent (uint256 replied) external onlyOwner {
        require(replied <= mails, "ERROR: Incorrect Amount");

        mails -= replied;
        payable(handler).transfer(replied);
        emit Reply(handler, replied);
    }

    function changeHandler(address newOwner) external onlyOwner {
        require(newOwner != address(0), "New Owner, Handler is Changed");
        emit OwnershipTransferred(handler, newOwner);
        handler = newOwner;
    }

    function reviewed (uint256 open) external {
        if (open > mails) {
            revert("ERROR: Value exceeds current amount");
        }
        
        mails -= open;
    }
}
