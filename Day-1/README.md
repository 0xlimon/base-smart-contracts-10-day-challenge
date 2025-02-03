# Day 1: Introduction to Smart Contract Development

Welcome to Day 1 of our smart contract development journey on Base network! Today, we'll start with fundamental concepts by building two simple but essential smart contracts.

## What You'll Learn

- Basic Solidity syntax
- State variables and functions
- Events and their importance
- Constructor usage
- String manipulation
- Basic error handling
- How to deploy and interact with contracts

## Basic Concepts

Before diving into the contracts, let's understand some fundamental concepts:

### State Variables
- Permanently stored in contract storage
- Persist between function calls
- Cost gas to modify
- Different types: uint, string, bool, address, etc.

### Functions
- `public`: Accessible by anyone
- `view`: Read-only, no state modification
- `pure`: No state access or modification
- `external`: Can only be called from outside
- `internal`: Only accessible within contract

### Events
- Log important contract changes
- Useful for frontend applications
- Cannot be accessed by contracts
- Cost less gas than storage

## Contract 1: Counter

A simple counter contract demonstrating basic state management and function calls.

### Features
- Store a number
- Increment/decrement functions
- Reset functionality
- Event emission

### Code Explanation

```solidity
uint public count;
```
**What it does:**
- Declares a public state variable
- Type `uint` (unsigned integer)
- Automatically creates a getter function
- Initial value is 0

```solidity
constructor() {
    count = 0;
}
```
**What it does:**
- Executes when contract is deployed
- Initializes counter to zero
- Sets up initial state

```solidity
function increment() public {
    count += 1;
    emit CountChanged(count);
}
```
**What it does:**
- Public function anyone can call
- Increases count by 1
- Emits event for tracking

### Key Learning Points
1. State variable declaration
2. Function visibility
3. Basic arithmetic operations
4. Event emission
5. Error handling with require

## Contract 2: Greeter

A contract that manages greeting messages, demonstrating string handling and more complex functions.

### Features
- Store and update greeting message
- String length checking
- Word search functionality
- Event tracking

### Code Explanation

```solidity
string public greeting;
```
**What it does:**
- Stores greeting message
- Public variable with automatic getter
- Uses string data type

```solidity
constructor(string memory _greeting) {
    greeting = _greeting;
}
```
**What it does:**
- Takes initial greeting as parameter
- Uses memory keyword for string
- Sets initial state

```solidity
function setGreeting(string memory _newGreeting) public {
    require(bytes(_newGreeting).length > 0, "Greeting cannot be empty");
    greeting = _newGreeting;
    emit GreetingChanged(_newGreeting);
}
```
**What it does:**
- Updates greeting message
- Validates input
- Emits change event
- Uses require for validation

### Key Learning Points
1. String handling
2. Constructor parameters
3. Memory vs Storage
4. Input validation
5. String manipulation

## Deployment Guide

### Step 1: Access Remix IDE
1. Visit [Remix IDE](https://remix.ethereum.org/)
2. Create two new files:
   - `Counter.sol`
   - `Greeter.sol`
3. Copy respective code into each file

### Step 2: Compile Contracts
1. Select Solidity Compiler (0.8.17)
2. Click "Compile" for each contract
3. Ensure no errors appear

### Step 3: Deploy Counter
1. Go to "Deploy & Run Transactions"
2. Select "Counter"
3. Click "Deploy"
4. Test functions:
   - Click "increment"
   - Click "decrement"
   - Check "count"

### Step 4: Deploy Greeter
1. Select "Greeter"
2. Enter initial greeting (e.g., "Hello, Base!")
3. Deploy and test:
   - Read current greeting
   - Set new greeting
   - Check greeting length

## Practice Exercises

### Counter Exercises
1. Add these features:
   - Increment by specific number
   - Add maximum limit
   - Add minimum limit
   - Track number of updates

2. Bonus challenges:
   - Add user permissions
   - Implement time-based restrictions
   - Add batch operations

### Greeter Exercises
1. Add these features:
   - Greeting history array
   - Get previous greeting
   - Maximum greeting length
   - Greeting blacklist

2. Bonus challenges:
   - Multiple language support
   - Timed greetings
   - Access control

## Common Issues and Solutions

### 1. Deployment Issues
- **Problem**: Transaction fails
  **Solution**: Check Base Goerli ETH balance

- **Problem**: Contract not found
  **Solution**: Ensure proper compilation

### 2. Function Calls
- **Problem**: Function reverts
  **Solution**: Check input parameters

- **Problem**: Gas errors
  **Solution**: Optimize function calls

### 3. State Changes
- **Problem**: State not updating
  **Solution**: Verify transaction confirmation

## Best Practices

1. **Code Organization**
   - Clear function names
   - Proper commenting
   - Consistent formatting

2. **Gas Optimization**
   - Use appropriate data types
   - Minimize storage operations
   - Batch operations when possible

3. **Security**
   - Validate all inputs
   - Check function requirements
   - Use require statements

## Next Steps

After completing these contracts, you'll be ready to learn:
1. Advanced data structures
2. Contract inheritance
3. Interface implementation
4. Library usage
5. Advanced security patterns

## Testing Tips

1. **Counter Testing**
   - Test increment/decrement
   - Verify event emissions
   - Check error conditions

2. **Greeter Testing**
   - Test empty strings
   - Verify string storage
   - Check event accuracy

Remember: Start simple, test thoroughly, and gradually add complexity. These fundamentals will serve as building blocks for more advanced smart contract development.

Happy coding! 🚀