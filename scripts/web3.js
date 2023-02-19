import Web3 from "web3";

let web3;

if(typeof window !== "undefined" && typeof window.ethereum !== "undefined"){
    //we are in the browser and metamask is installed
    window.ethereum.request({method: "eth_requestAccounts"});
    web3 = new web3(window.ethereum);
} else{
    //we are on the server or metmask not installed
    const provider = Web3.providers.HttpProvider(
        "https://boldest-bitter-bird.ethereum-goerli.discover.quiknode.pro/1c25dad2589f635c843879a1a672b84fc3626628/"
    );
    web3 = new web3(provider);
}

export default web3;