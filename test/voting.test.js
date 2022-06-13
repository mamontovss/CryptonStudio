const {expect}= require ("chai")
const {ethers}= require ("hardhat")

describe ("Voting", function(){  // анонимная асинхронная функция
    let acc1
    let acc2
    let voting
    
    
    beforeEach (async function(){
        [acc1, acc2] =await ethers.getSigners()
        const Voting = await ethers.getContractFactory ("Voting",acc1)
        voting = await Voting.deploy()
        await voting.deployed()
    })
    it ("should be deployed", async function(){
        console.log("success")
    })

})