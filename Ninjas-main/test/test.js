const Campaign = artifacts.require("Campaign");



contract("Campaign", async function(accounts){
    it(
        "should create request", async function(){
            // let carId = 1; 9000000000000000000
            let instance = await Campaign.deployed()
            await instance.createRequest("cake", web3.utils.toWei('7', 'ether'), accounts[0],{from: accounts[0]});
    });

    it(
        "To finalize request", async function(){
           
            let instance = await Campaign.deployed()
            await instance.finalizeRequest(0,{from: accounts[0]});
    });

    it(
        "should create request", async function(){
           
            let instance = await Campaign.deployed()
            await instance.contribute({from: accounts[0]});
    });

});

