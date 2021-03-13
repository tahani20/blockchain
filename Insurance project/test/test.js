const TechInsurance = artifacts.require("./TechInsurance");



contract("TechInsurance", async function(accounts){

    it(
        "should add a procut", async function(){
             //let productId = 1; 9000000000000000000
             let instance = await TechInsurance.deployed()
             await instance.addProduct("Microsoft", 2020, web3.utils.toWei('7', 'ether'), {from: accounts[0]});
    });

    it(
        " check it is not offered", async function(){
            // let productId = 1; 9000000000000000000
            let instance = await TechInsurance.deployed()
            await instance.addProduct("Iphone", 2020, web3.utils.toWei('7', 'ether'), {from: accounts[0]});
            let getProduct = await instance.changeFalse(1); 
    });


});