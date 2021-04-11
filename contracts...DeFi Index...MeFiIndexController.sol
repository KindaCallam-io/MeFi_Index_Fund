pragma solidity ^0.6.7;

import "./IndexToken.sol";
import "./ErrorReporter.sol";
import "./PriceOracle.sol";
import "./MeFiInterface.sol";
import "./IndexControllerStorage.sol";
// import "./UniIndexController.sol";
import "./MeFi.sol";
import "./IndexErc20.sol"; 


/**
 * @title MeFi Index Controller Contract 
 * @author MeFi
 */
contract IndexControllerV1 is  MeFiInterface, ExponentialNoError {
    
        // this should contain all the functions that MeFi will have as callable. 
    bool public constant isController = true; 
    address payable public admin; 

    // Functions that should be callable from outside the function. 
    
    function buyIndex(address _indexToken) external payable override returns (uint) {
        // should mint new tokens based on
    
        require(msg.value > 0); 
        
        // This should be optimized so that calculateWeightedMarketCap doesn't make mulitple calls to the oracles. 
        uint _tokenValue = IndexToken(_indexToken).tokenValue();  
        require(_tokenValue > 0); 

        // FIXME
        
        uint256 amountToBeMinted = uint256(msg.value / _tokenValue); 
        // Here I need to calculate the amount that needs to be minted. This possibly should be done somewhere else. 
        // to avoid calling the oracle twice. 
        require(mintAllowed(_indexToken, msg.sender, amountToBeMinted) == 0); 
        
        //FIXME : make sure that I multiply properly so that fractional divison is possible. 
        IndexErc20(_indexToken).mint(uint(msg.value / _tokenValue)); 
        IndexErc20(_indexToken).transfer(msg.sender, msg.value / _tokenValue); 
    } 
    
    
    function redeemIndex(address indexToken) external override returns (uint) {
        return 0; 
    }
    
    //Policy Hooks. Helper functions to determine if a certain action is allowed. 
    
    function mintAllowed(address indexToken, address minter, uint mintAmount) public override returns (uint) {
        return 0; 
        
    }
    
    function mintVerify(address _indexToken, address minter, uint mintAmount, uint mintTokens) external override returns (uint) {
        // Currently Unused. Will delete if no use is found. 

    }

    function redeemAllowed(address indexToken, address redeemer, uint redeemTokens) external override returns (uint) {
        
        return 0; 
    }
    
    function redeemVerify(address indexToken, address redeemer, uint redeemAmount, uint redeemTokens) external override {
        
    }
    
    function isIndexController() public override returns (bool) {
        return true; 
    }
    
    constructor () public {

        admin = msg.sender;
    }

}


















