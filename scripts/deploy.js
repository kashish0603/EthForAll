const HDWalletProvider  = require("@truffle/hdwallet-provider");
const Web3 = require("web3");
const compiledNFTMinter = require("../artifacts/contracts/Bond.sol/Bond_minter.json")


const provider = new HDWalletProvider(
  env.process.YOUR_MNEMONIC,
  'https://boldest-bitter-bird.ethereum-goerli.discover.quiknode.pro/1c25dad2589f635c843879a1a672b84fc3626628/' );

const web3 = new Web3(provider);

const deploy = async () => {
  const accounts = await web3.eth.getAccounts();

  console.log("Attempting to deploy from account", accounts[0]);

  const result = await new web3.eth.Contract(compiledNFTMinter.abi)
    .deploy({ data: compiledNFTMinter.bytecode })
    .send({ gas: "4000000", from: accounts[0] });

  console.log("Contract deployed to", result.options.address);
  provider.engine.stop();
};
deploy();