// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

/**
 * @title Counter
 * @dev A simple contract to demonstrate state variables and basic functions
 */
contract Counter {
    // This is a state variable that will be stored on the blockchain
    uint public count;

    // This event will be emitted when count changes
    event CountChanged(uint newCount);

    // Constructor runs when the contract is deployed
    constructor() {
        count = 0; // Initialize count to 0
    }

    // Function to increase the counter by 1
    function increment() public {
        count += 1;
        emit CountChanged(count);
    }

    // Function to decrease the counter by 1
    function decrement() public {
        // Make sure count is greater than 0
        require(count > 0, "Count cannot be negative");
        count -= 1;
        emit CountChanged(count);
    }

    // Function to get current count
    function getCount() public view returns (uint) {
        return count;
    }

    // Function to reset count to 0
    function reset() public {
        count = 0;
        emit CountChanged(count);
    }
}