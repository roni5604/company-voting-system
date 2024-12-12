# Company Voting System

This project is a blockchain-based voting system developed using Solidity and Hardhat. The project includes smart contracts for creating and managing votes, user roles, and financial transactions, and it is integrated with a frontend interface.

## Project Structure

```
company-voting-system/
├── artifacts/          # Compiled contracts and deployment data
├── cache/              # Cache files from Hardhat
├── contracts/          # Solidity smart contracts
│   └── VotingSystem.sol
├── frontend/           # React-based frontend (if applicable)
├── node_modules/       # Project dependencies
├── scripts/            # Deployment and interaction scripts
│   └── deploy.js
├── hardhat.config.js   # Hardhat configuration file
├── package.json        # Project metadata and dependencies
├── package-lock.json   # Dependency lock file
```

## Prerequisites

Ensure the following are installed on your system:

1. [Node.js and npm](https://nodejs.org/)
2. [Hardhat](https://hardhat.org/)
3. [Ganache](https://trufflesuite.com/ganache/) (optional, for local blockchain testing)
4. [MetaMask](https://metamask.io/) (for interacting with the blockchain)

## Setup Instructions

1. Clone the repository:
   ```bash
   git clone <repository-url>
   cd company-voting-system
   ```

2. Install dependencies:
   ```bash
   npm install
   ```

3. Compile the smart contracts:
   ```bash
   npx hardhat compile
   ```

4. (Optional) Start a local blockchain using Ganache:
   ```bash
   ganache
   ```

5. Deploy the smart contract:
   ```bash
   npx hardhat run scripts/deploy.js --network localhost
   ```
   Replace `localhost` with the appropriate network configuration.

6. Note the deployed contract address printed in the console.

## Smart Contract Overview

### VotingSystem.sol

This contract includes:
- **User Roles**: Manager, Customer
- **Vote Management**: Create, close, and participate in votes
- **Financial Management**: Manage funds and withdrawal requests

### Events
- `UserAdded`: Triggered when a new user is added.
- `VoteCreated`: Triggered when a new vote is created.
- `FundsAdded`: Triggered when funds are added to the company account.

## Running the Frontend

If a frontend is available:

1. Navigate to the `frontend` directory:
   ```bash
   cd frontend
   ```

2. Install frontend dependencies:
   ```bash
   npm install
   ```

3. Start the development server:
   ```bash
   npm start
   ```

4. Access the application in your browser at `http://localhost:3000`.

## Testing

Run tests for the smart contracts:
```bash
npx hardhat test
```

## Deployment

To deploy the application to a live network, update the network configuration in `hardhat.config.js` and run:
```bash
npx hardhat run scripts/deploy.js --network <network-name>
```

## Author

**Roni Michaeli**  
Computer Science and Mathematics Student  
[GitHub Profile](https://github.com/roni5604)

## License

This project is licensed under the MIT License. See the LICENSE file for details.
