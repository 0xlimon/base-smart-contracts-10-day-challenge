# Day 1: Basic Smart Contract Development

Welcome to Day 1 of our smart contract development journey! Today we'll explore two fundamental smart contracts: Counter and Greeter.

## Contract 1: Counter

The Counter contract demonstrates basic state management and function interactions.

### Complete Code Explanation

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

/**
 * @title Counter
 * @dev A simple contract to demonstrate state variables and basic functions
 */
contract Counter {
```
- `SPDX-License-Identifier`: Specifies the license for the code
- `pragma solidity ^0.8.17`: Defines the Solidity version to use
- Contract declaration with documentation

```solidity
    // This is a state variable that will be stored on the blockchain
    uint public count;
```
- `uint`: Unsigned integer type (only positive numbers)
- `public`: Creates an automatic getter function
- `count`: State variable stored permanently on blockchain

```solidity
    // This event will be emitted when count changes
    event CountChanged(uint newCount);
```
- `event`: Declares an event that can be monitored
- `CountChanged`: Event name with parameter `newCount`
- Used for frontend applications and monitoring

```solidity
    // Constructor runs when the contract is deployed
    constructor() {
        count = 0; // Initialize count to 0
    }
```
- `constructor`: Special function that runs once during deployment
- Initializes `count` to 0
- Cannot be called again after deployment

```solidity
    // Function to increase the counter by 1
    function increment() public {
        count += 1;
        emit CountChanged(count);
    }
```
- `public`: Anyone can call this function
- Increases `count` by 1
- Emits `CountChanged` event with new value

```solidity
    // Function to decrease the counter by 1
    function decrement() public {
        // Make sure count is greater than 0
        require(count > 0, "Count cannot be negative");
        count -= 1;
        emit CountChanged(count);
    }
```
- Checks if `count > 0` before decreasing
- `require`: Validates condition, reverts if false
- Decreases `count` by 1 if check passes
- Emits event with new value

```solidity
    // Function to get current count
    function getCount() public view returns (uint) {
        return count;
    }
```
- `view`: Doesn't modify state (gas-free when called externally)
- Returns current value of `count`
- Alternative to automatic getter

```solidity
    // Function to reset count to 0
    function reset() public {
        count = 0;
        emit CountChanged(count);
    }
```
- Resets counter to initial state
- Emits event to notify of change
- Can be called anytime

### Key Concepts Demonstrated

1. **State Variables**
   - Permanent storage on blockchain
   - Public visibility creates getters
   - Type safety with uint

2. **Functions**
   - Public accessibility
   - State modifications
   - View functions
   - Error handling

3. **Events**
   - Event declaration
   - Event emission
   - Parameter passing

4. **Error Handling**
   - Require statements
   - Custom error messages
   - State validation

## Contract 2: Greeter

The Greeter contract shows string handling and more complex interactions.

### Complete Code Explanation

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

/**
 * @title Greeter
 * @dev A simple contract to store and update a greeting message
 */
contract Greeter {
```
- Standard license and version declarations
- Contract documentation

```solidity
    // State variable to store the greeting message
    string public greeting;
```
- `string`: Dynamic string type
- `public`: Creates automatic getter
- Stored permanently on blockchain

```solidity
    // Event that will be emitted when greeting changes
    event GreetingChanged(string newGreeting);
```
- Event for tracking greeting changes
- Includes new greeting as parameter
- Useful for UI updates

```solidity
    // Constructor that sets initial greeting
    constructor(string memory _greeting) {
        greeting = _greeting;
    }
```
- Takes parameter for initial greeting
- `memory`: Temporary storage location
- Sets initial state

```solidity
    // Function to get the current greeting
    function getGreeting() public view returns (string memory) {
        return greeting;
    }
```
- Returns current greeting
- `view`: No state modification
- Returns string from storage

```solidity
    // Function to update the greeting
    function setGreeting(string memory _newGreeting) public {
        require(bytes(_newGreeting).length > 0, "Greeting cannot be empty");
        greeting = _newGreeting;
        emit GreetingChanged(_newGreeting);
    }
```
- Updates greeting message
- Validates input is not empty
- `bytes()`: Converts string to bytes for length check
- Emits event with new greeting

```solidity
    // Function to get greeting length
    function getGreetingLength() public view returns (uint) {
        return bytes(greeting).length;
    }
```
- Returns length of greeting
- Converts to bytes for length
- Useful for validation

```solidity
    // Function to check if greeting contains a word
    function containsWord(string memory _word) public view returns (bool) {
        bytes memory greetingBytes = bytes(greeting);
        bytes memory wordBytes = bytes(_word);
        
        if(wordBytes.length > greetingBytes.length) {
            return false;
        }
        
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
```
- Complex string manipulation example
- Converts strings to bytes for comparison
- Implements simple search algorithm
- Shows loops and comparisons in Solidity

### Key Concepts Demonstrated

1. **String Handling**
   - String storage
   - String comparison
   - Length checking
   - String searching

2. **Memory Management**
   - Memory vs Storage
   - Byte manipulation
   - Array operations

3. **Constructor Parameters**
   - Initial state setting
   - Parameter validation
   - Memory keywords

4. **Complex Logic**
   - Loops in Solidity
   - Boolean operations
   - Algorithm implementation

## Deployment and Testing

### Deploying Counter

1. Open Remix and create `Counter.sol`
2. Paste the Counter contract code
3. Compile with Solidity 0.8.17
4. Deploy to Base Sepolia:
   - Connect MetaMask to Base Sepolia
   - Deploy with no constructor parameters
   - Confirm transaction

5. Test functions:
```javascript
// Test increment
await counter.increment()
// Should return 1
await counter.count()

// Test decrement
await counter.decrement()
// Should return 0
await counter.count()

// Test reset
await counter.reset()
// Should return 0
await counter.count()
```

### Deploying Greeter

1. Create `Greeter.sol` in Remix
2. Paste Greeter contract code
3. Compile with Solidity 0.8.17
4. Deploy to Base Sepolia:
   - Set initial greeting (e.g., "Hello, Base!")
   - Confirm deployment transaction

5. Test functions:
```javascript
// Test getting greeting
await greeter.getGreeting()
// Should return "Hello, Base!"

// Test setting new greeting
await greeter.setGreeting("Welcome to Base Network!")
// Should emit GreetingChanged event

// Test length
await greeter.getGreetingLength()
// Should return correct length

// Test word search
await greeter.containsWord("Base")
// Should return true
```

## Common Issues and Solutions

1. **Transaction Failures**
   - Ensure enough gas
   - Check input parameters
   - Verify network connection

2. **String Operations**
   - Remember strings are expensive
   - Use bytes for manipulation
   - Check lengths before operations

3. **Event Monitoring**
   - Use web3.js/ethers.js to listen
   - Handle event data properly
   - Check transaction receipts

## Practice Exercises

1. **Counter Extensions**
   - Add maximum value
   - Add increment by amount
   - Add user permissions

2. **Greeter Extensions**
   - Add greeting history
   - Add language support
   - Add greeting restrictions

Remember to always test thoroughly on Base Sepolia before any mainnet deployment!
