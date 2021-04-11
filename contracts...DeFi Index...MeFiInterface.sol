pragma solidity ^0.6.7;


interface MeFiInterface {

    // Functions that should be callable from outside the function. 
    
    function buyIndex(address indexToken) external payable returns (uint); 
    function redeemIndex(address indexToken) external returns (uint); 
    
    //Policy Hooks. Helper functions to determine if a certain action is allowed. 
    
    function mintAllowed(address indexToken, address minter, uint mintAmount)  external returns (uint);
    function mintVerify(address indexToken, address minter, uint mintAmount, uint mintTokens) external returns (uint);

    function redeemAllowed(address indexToken, address redeemer, uint redeemTokens) external returns (uint);
    function redeemVerify(address indexToken, address redeemer, uint redeemAmount, uint redeemTokens) external;



    function isIndexController() external returns (bool); 
}