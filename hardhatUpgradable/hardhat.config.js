// hardhat.config.js
// const { alchemyApiKey, mnemonic } = require('./secrets.json');

require("@nomiclabs/hardhat-ethers");
require('@openzeppelin/hardhat-upgrades');

/**
 * @type import('hardhat/config').HardhatUserConfig
 */
module.exports = {
  solidity: "0.8.0",
  networks: {
    rinkeby: {
      url: `https://eth-rinkeby.alchemyapi.io/v2/SQRK_nTYMzysVzqhFeDWY6pkSwMaFKgh`,
      accounts: {mnemonic: "diesel under soon salute rhythm labor quarter behave cupboard route affair artefact"}
    },
    maticTestnet: {
      url: "https://rpc-mumbai.maticvigil.com/",
      accounts: {mnemonic: "diesel under soon salute rhythm labor quarter behave cupboard route affair artefact"},
      chainId: 80001,
    }
  }
};