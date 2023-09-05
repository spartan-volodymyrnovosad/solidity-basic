# solidity-basic

## Steps:
### Deploy token for the localhost network
 1) After project setup and tests completed
 2) `npx hardhat node `- launch local hardhat net
 3) open new terminal window and prepare deploy file
 4) Choose the network for token and run this `command npx hardhat run scripts\(deploy file name) --network localhost`

### For real testnet(Polygon in my case):
 1) Create API key on https://polygonscan.com/;
 2) Get Metamask account private key;
 3) Create .env file to store private data inside and add it to .gitignore;
 4) Install dotenv using `npm i dotenv` command and add `require("dotenv").config();` to config file;
 5) Run this command `npx hardhat run scripts/deploy.js --network polygon_mumbai`;

### Example of config file:
```
require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config();

module.exports = {
  defaultNetwork: "polygon_mumbai",
  networks: {
    hardhat: {
    },
    polygon_mumbai: {
      url: "https://rpc-mumbai.maticvigil.com",
      accounts: [process.env.METAMASK_PRIVATE_KEY]
    }
  },
  etherscan: {
    apiKey: process.env.POLYGONSCAN_PRIVATE_KEY
  },
  solidity: {
    version: "0.8.9",
    settings: {
      optimizer: {
        enabled: true,
        runs: 200
      }
    }
  },
}
```

Add token to metamask account(click import token):
<img width="1385" alt="Token" src="https://github.com/spartan-volodymyrnovosad/solidity-basic/assets/133329312/a6ffa1ef-aa7e-4038-908a-2a46bf60c0d9">

Check data about token on https://mumbai.polygonscan.com/address/:
<img width="1390" alt="Token data" src="https://github.com/spartan-volodymyrnovosad/solidity-basic/assets/133329312/a24b2630-65b8-47fb-978c-c163b4aa0086">
