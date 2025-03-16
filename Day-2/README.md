# Day 2: Structs, Mappings, and Function Modifiers

Welcome to Day 2 of our smart contract development journey! Today we'll explore two fundamental concepts in Solidity: data structures (structs and mappings) and function modifiers.

## Contract 1: SimpleStorage

The SimpleStorage contract demonstrates how to use structs and mappings to store and retrieve data.

### Complete Code Explanation

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

/**
 * @title SimpleStorage
 * @dev A minimal contract demonstrating structs and mappings
 */
contract SimpleStorage {
```
- Standard license and version declarations
- Contract documentation via NatSpec comments

```solidity
    // Define a simple struct
    struct Person {
        string name;
        uint age;
    }
```
- `struct`: A custom data type that groups together related variables
- Combines a string (name) and uint (age) into a single data structure
- Allows us to represent a person with multiple attributes

```solidity
    // Mapping from address to Person
    mapping(address => Person) public people;
```
- `mapping`: A key-value data structure similar to a hash table
- Keys are Ethereum addresses, values are Person structs
- `public`: Automatically creates a getter function
- Each address can have one associated Person record

```solidity
    // Store a person's information
    function setPerson(string memory _name, uint _age) public {
        people[msg.sender] = Person(_name, _age);
    }
```
- Function to store a Person struct in the mapping
- `msg.sender`: The address of the account calling the function
- Creates a new Person struct with the provided name and age
- Associates the Person with the caller's address in the mapping

```solidity
    // Get a person's information
    function getPerson(address _addr) public view returns (string memory, uint) {
        return (people[_addr].name, people[_addr].age);
    }
}
```
- Function to retrieve a Person's information from the mapping
- `view`: Indicates the function doesn't modify state
- Returns multiple values (name and age) as a tuple
- Accesses struct fields with dot notation (`.name`, `.age`)

### Key Concepts Demonstrated

1. **Structs**
   - Custom data types that combine multiple variables
   - Creating and initializing structs
   - Accessing struct fields with dot notation
   - Storing structs in variables and mappings

2. **Mappings**
   - Key-value data structure for storing associations
   - Using address as a key for user data
   - Default values for non-existent keys
   - Automatic getter for public mappings

3. **Basic Data Management**
   - Storing and retrieving user data
   - Using caller's address as an identifier
   - Returning multiple values from functions
   - Using memory for string return types

## Contract 2: TimeLock

The TimeLock contract demonstrates function modifiers and time-based operations.

### Complete Code Explanation

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

/**
 * @title TimeLock
 * @dev A minimal contract demonstrating function modifiers and time operations without ETH deposits
 */
contract TimeLock {
```
- Standard license and version declarations
- Contract documentation

```solidity
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
```
- State variables to track owner, locked data, unlock time, and lock status
- `constant`: Value cannot be changed after declaration
- `1 days`: Solidity time unit (automatically converts to 86400 seconds)

```solidity
    // Constructor sets the owner
    constructor() {
        owner = msg.sender;
        isLocked = false;
    }
```
- `constructor`: Special function that runs once during deployment
- Sets the contract deployer as the owner
- Sets the initial lock status to false

```solidity
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
```
- `modifier`: Reusable code that can be attached to functions
- `onlyOwner`: Ensures only the owner can call certain functions
- `lockExpired`: Checks if the time lock period has passed
- `dataIsLocked`: Verifies that data is currently locked
- `_`: Placeholder for the function body where the modifier is used

```solidity
    // Lock data with a time delay
    function lockData(string memory _data, uint _lockTime) public {
        require(_lockTime >= MIN_LOCK_TIME, "Lock time too short");
        require(!isLocked, "Data is already locked");
        
        lockedData = _data;
        unlockTime = block.timestamp + _lockTime;
        isLocked = true;
    }
```
- Takes a string and a lock time as parameters
- Validates that the lock time is valid and no data is currently locked
- Stores the data and calculates the unlock time
- Sets the lock status to true

```solidity
    // Retrieve data after time lock expires
    function retrieveData() public dataIsLocked lockExpired returns (string memory) {
        isLocked = false;
        return lockedData;
    }
```
- Uses multiple modifiers to enforce conditions
- Can only be called if data is locked and the lock time has expired
- Changes the lock status to false
- Returns the locked data

```solidity
    // Check remaining lock time
    function getRemainingTime() public view dataIsLocked returns (uint) {
        if (block.timestamp >= unlockTime) {
            return 0;
        }
        return unlockTime - block.timestamp;
    }
```
- Calculates time remaining until locked data can be retrieved
- Returns 0 if the time lock has already expired
- Uses the `dataIsLocked` modifier to ensure data is actually locked

```solidity
    // Emergency unlock (only owner)
    function emergencyUnlock() public onlyOwner dataIsLocked {
        isLocked = false;
    }
}
```
- Only the owner can call this function
- Provides a way to unlock data before the time lock expires
- Does not return the data, just unlocks it

### Key Concepts Demonstrated

1. **Function Modifiers**
   - Code reuse for function preconditions
   - Access control with `onlyOwner`
   - State validation with `lockExpired` and `dataIsLocked`
   - Using `_;` to continue function execution
   - Combining multiple modifiers on a single function

2. **Time-Based Operations**
   - Using `block.timestamp` for current time
   - Time units in Solidity (`days` converts to seconds)
   - Calculating future timestamps
   - Time-dependent conditions
   - Checking remaining time

3. **Access Control**
   - Owner-only functions with modifiers
   - State-based restrictions
   - Emergency override functionality
   - Balancing automation with human controls

## Deployment and Testing

### Deploying SimpleStorage

1. Open Remix and create `SimpleStorage.sol`
2. Paste the SimpleStorage contract code
3. Compile with Solidity 0.8.17
4. Deploy to Base Sepolia:
   - Connect MetaMask to Base Sepolia
   - Deploy with no constructor parameters
   - Confirm transaction

5. Test functions:
```javascript
// Set your own information
await simpleStorage.setPerson("Alice", 30)

// Get information using your address
await simpleStorage.getPerson("0xYourAddress")
// Should return ["Alice", 30]

// Use the automatic getter for the mapping
await simpleStorage.people("0xYourAddress")
// Should return ["Alice", 30]
```

### Deploying TimeLock

1. Create `TimeLock.sol` in Remix
2. Paste TimeLock contract code
3. Compile with Solidity 0.8.17
4. Deploy to Base Sepolia:
   - Connect MetaMask to Base Sepolia
   - No constructor parameters needed
   - Confirm deployment transaction

5. Test functions:
```javascript
// Lock some data for 1 day
await timeLock.lockData("Secret message", 86400)

// Check remaining time
await timeLock.getRemainingTime()
// Should return seconds remaining

// Try to retrieve data early (should fail)
await timeLock.retrieveData()
// Should revert with "Time lock not expired"

// After lock period ends (or using emergencyUnlock):
await timeLock.retrieveData()
// Should return "Secret message"
```

## Common Issues and Solutions

1. **Struct Handling**
   - Remember all struct fields must be initialized
   - Use constructor syntax `Person(_name, _age)` for clean initialization
   - Structs alone don't provide iteration capabilities

2. **Mapping Limitations**
   - Mappings don't track their keys or have a length
   - All keys exist (return default values if not set)
   - Can't iterate through mapping keys without additional tracking
   - Can't delete mapping entirely, only individual entries

3. **Function Modifiers**
   - Place `_;` carefully to control execution flow
   - Modifiers can stack - order matters
   - Keep modifier logic simple and focused
   - Consider gas costs when using multiple modifiers

4. **Time-Based Logic**
   - Block timestamps can be slightly manipulated by miners
   - Don't rely on precise second-level timing for high-value operations
   - Consider block numbers for longer timeframes
   - Test time-dependent functions thoroughly

## Practice Exercises

1. **SimpleStorage Extensions**
   - Add a function to update only a person's age
   - Create a mapping to track multiple persons per address
   - Add a function to delete a person's information
   - Track the total number of registered persons

2. **TimeLock Extensions**
   - Add the ability to lock multiple data items at once
   - Implement different access levels for different users
   - Create a function to extend the lock time
   - Add an event system to notify when locks expire

Remember to always test thoroughly on Base Sepolia before any mainnet deployment!