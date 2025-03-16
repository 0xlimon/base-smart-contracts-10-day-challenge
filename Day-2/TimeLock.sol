// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

/**
 * @title TimeLock
 * @dev A minimal contract demonstrating function modifiers and time operations without ETH deposits
 */
contract TimeLock {
    // Owner of the contract
    address public owner;
    
    // Data that will be locked
    string public lockedData;
    
    // Unlock time
    uint public unlockTime;
    
    // Lock status
    bool public isLocked;
    
    // Minimum lock time (1 day in seconds)
    uint public constant MIN_LOCK_TIME = 1 days;
    
    // Constructor sets the owner
    constructor() {
        owner = msg.sender;
        isLocked = false;
    }
    
    // Modifier to restrict access to owner
    modifier onlyOwner() {
        require(msg.sender == owner, "Not the owner");
        _;
    }
    
    // Modifier to check if time lock has expired
    modifier lockExpired() {
        require(block.timestamp >= unlockTime, "Time lock not expired");
        _;
    }
    
    // Modifier to check if data is locked
    modifier dataIsLocked() {
        require(isLocked, "No data is locked");
        _;
    }
    
    // Lock data with a time delay
    function lockData(string memory _data, uint _lockTime) public {
        require(_lockTime >= MIN_LOCK_TIME, "Lock time too short");
        require(!isLocked, "Data is already locked");
        
        lockedData = _data;
        unlockTime = block.timestamp + _lockTime;
        isLocked = true;
    }
    
    // Retrieve data after time lock expires
    function retrieveData() public dataIsLocked lockExpired returns (string memory) {
        isLocked = false;
        return lockedData;
    }
    
    // Check remaining lock time
    function getRemainingTime() public view dataIsLocked returns (uint) {
        if (block.timestamp >= unlockTime) {
            return 0;
        }
        return unlockTime - block.timestamp;
    }
    
    // Emergency unlock (only owner)
    function emergencyUnlock() public onlyOwner dataIsLocked {
        isLocked = false;
    }
}