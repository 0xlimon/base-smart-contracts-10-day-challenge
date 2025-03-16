// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

/**
 * @title SimpleStorage
 * @dev A minimal contract demonstrating structs and mappings
 */
contract SimpleStorage {
    // Define a simple struct
    struct Person {
        string name;
        uint age;
    }
    
    // Mapping from address to Person
    mapping(address => Person) public people;
    
    // Store a person's information
    function setPerson(string memory _name, uint _age) public {
        people[msg.sender] = Person(_name, _age);
    }
    
    // Get a person's information
    function getPerson(address _addr) public view returns (string memory, uint) {
        return (people[_addr].name, people[_addr].age);
    }
}