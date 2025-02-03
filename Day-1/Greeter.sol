// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

/**
 * @title Greeter
 * @dev A simple contract to store and update a greeting message
 */
contract Greeter {
    // State variable to store the greeting message
    string public greeting;

    // Event that will be emitted when greeting changes
    event GreetingChanged(string newGreeting);

    // Constructor that sets initial greeting
    constructor(string memory _greeting) {
        greeting = _greeting;
    }

    // Function to get the current greeting
    function getGreeting() public view returns (string memory) {
        return greeting;
    }

    // Function to update the greeting
    function setGreeting(string memory _newGreeting) public {
        // Make sure the new greeting is not empty
        require(bytes(_newGreeting).length > 0, "Greeting cannot be empty");
        
        // Update the greeting
        greeting = _newGreeting;
        
        // Emit event
        emit GreetingChanged(_newGreeting);
    }

    // Function to get greeting length
    function getGreetingLength() public view returns (uint) {
        return bytes(greeting).length;
    }

    // Function to check if greeting contains a word
    function containsWord(string memory _word) public view returns (bool) {
        // Convert both strings to bytes for comparison
        bytes memory greetingBytes = bytes(greeting);
        bytes memory wordBytes = bytes(_word);
        
        // If word is longer than greeting, it can't be contained
        if(wordBytes.length > greetingBytes.length) {
            return false;
        }
        
        // Simple check if bytes match
        // Note: This is a basic implementation for learning purposes
        bool found = false;
        for(uint i = 0; i <= greetingBytes.length - wordBytes.length; i++) {
            found = true;
            for(uint j = 0; j < wordBytes.length; j++) {
                if(greetingBytes[i + j] != wordBytes[j]) {
                    found = false;
                    break;
                }
            }
            if(found) {
                return true;
            }
        }
        return false;
    }
}