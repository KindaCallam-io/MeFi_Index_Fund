pragma solidity ^0.6.7;

import "./IndexToken.sol";
// import "./PriceOracle.sol";

//FIXME

contract UnitrollerAdminStorage {
    /**
    * @notice Administrator for this contract
    */
    address public admin;

    /**
    * @notice Pending administrator for this contract
    */
    address public pendingAdmin;

    /**
    * @notice Active brains of Unitroller
    */
    address public indexControllerImplementation;

    /**
    * @notice Pending brains of Unitroller
    */
    address public pendingIndexControllerImplementation;
}

contract IndexControllerV1Storage is UnitrollerAdminStorage {
    
    
    //FIXME

    /**
     * @notice Per-account mapping of "assets you are in", capped by maxAssets
     */
    mapping(address => IndexToken[]) public accountAssets;

}

