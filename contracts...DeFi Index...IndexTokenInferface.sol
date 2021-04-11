
pragma solidity ^0.6.7;
import "./MeFiInterface.sol";
import "./EIP20NonStandardInterface.sol";





interface IndexTokenInterface {
    /**
     * @notice Event emitted when tokens are minted
     */
    event Mint(address minter, uint mintAmount, uint mintTokens);

    /**
     * @notice Event emitted when tokens are redeemed
     */
    event Redeem(address redeemer, uint redeemAmount, uint redeemTokens);
    
    
        /*** Admin Events ***/

    /**
     * @notice Event emitted when pendingAdmin is changed
     */
    event NewPendingAdmin(address oldPendingAdmin, address newPendingAdmin);

    /**
     * @notice Event emitted when pendingAdmin is accepted, which means admin is updated
     */
    event NewAdmin(address oldAdmin, address newAdmin);

    /**
     * @notice Event emitted when Index controller is changed
     */
    event NewIndexController(MeFiInterface oldIndexController, MeFiInterface newIndexController);
    
    
    /**
     * !!!! THERE ARE SOME OTHER EVENTS THAT NEED TO BE ADDED REFER TO NOTES !!!!
     */
    
    /**
     * @notice EIP20 Transfer event
     */
    event Transfer(address indexed from, address indexed to, uint amount);

    /**
     * @notice EIP20 Approval event
     */
    event Approval(address indexed owner, address indexed spender, uint amount);

    /**
     * @notice Failure event
     */
    event Failure(uint error, uint info, uint detail);
    
    
    
    /*** User Interface ***/
    
    function transfer(address dst, uint amount) external returns (bool);
    function transferFrom(address src, address dst, uint amount) external returns (bool);
    function approve(address spender, uint amount) external returns (bool);
    function allowance(address owner, address spender) external view returns (uint);
    function balanceOf(address owner) external view returns (uint);
    function tokenValue() external returns(uint); 
    //ADD OTHER USER FUNCTIONS
    
    

    /*** Admin Interface ***/ 
    function _setPendingAdmin(address payable newPendingAdmin) external returns (uint);
    function _setPriceFeedList(address[] calldata priceFeedAddresses) external returns (uint); 
    function _setIndexDevisor(uint indexDevisor) external returns (uint);
    function _acceptAdmin() external returns (uint);
    function _setIndexController(MeFiInterface newIndexController) external returns (uint);
    //ADD OTHER ADMIN FUNCTIONS
    
    
    //** internal functions **// 
    
    
}

interface IndexErc20Interface {
    
    function mint(uint mintAmount) external returns (uint);
    function redeem(uint redeemTokens) external returns (uint);
    /** ADD Other Interface functions. **/ 
    
}

interface IndexDelegatorInterface {
    /**
     * @notice Emitted when implementation is changed
     */
    event NewImplementation(address oldImplementation, address newImplementation);

    /**
     * @notice Called by the admin to update the implementation of the delegator
     * @param implementation_ The address of the new implementation for delegation
     * @param allowResign Flag to indicate whether to call _resignImplementation on the old implementation
     * @param becomeImplementationData The encoded bytes data to be passed to _becomeImplementation
     */
    function _setImplementation(address implementation_, bool allowResign, bytes memory becomeImplementationData) external;
}



interface IndexDelegateInterface {
    /**
     * @notice Called by the delegator on a delegate to initialize it for duty
     * @dev Should revert if any issues arise which make it unfit for delegation
     * @param data The encoded bytes data for any initialization
     */
    function _becomeImplementation(bytes memory data) external;

    /**
     * @notice Called by the delegator on a delegate to forfeit its responsibility
     */
    function _resignImplementation() external;
}

















