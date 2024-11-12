require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config();

module.exports = {
  solidity: "0.8.27",
  networks: {
    ganache: {
      url: "http://127.0.0.1:8545",
      accounts: ["10929948d42a4adeecb170fd8cfb0cbbafd2d696f5f59df5244292db9db83215"],
    },
  },
};
