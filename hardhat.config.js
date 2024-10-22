require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config();

module.exports = {
  solidity: "0.8.27",
  networks: {
    ganache: {
      url: "http://127.0.0.1:7545",
      accounts: ["63a3e8be21c97fdc610ac9048460497abc770e51d7dc60317b70c01de3988703"],
    },
  },
};
