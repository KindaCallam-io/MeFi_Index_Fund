pragma solidity ^0.6.7;

//contract Exponential {} from Exponential.sol

import "./MeFiInterface.sol"; 
import "./IndexTokenInferface.sol";
import "./ErrorReporter.sol";
import "./Exponential.sol";
import "./EIP20StandardInterface.sol";
import "./PriceOracle.sol"; 


contract IndexToken is IndexTokenInterface, Exponential {
    
    /**This will initialize a new index token meaning that it will create a new index. 
      *This means that it will need to access the list for price feeds that it will be drawing from.
      *It will also need to initalize that new Index devisior or a way of calculating that index devisor. 
      *As well as a new IndexController. 
      **/
      
      
      /**
     * @dev Guard variable for re-entrancy checks
     */
    bool internal _notEntered;

    /**
     * @notice EIP-20 token name for this token
     */
    string public name;

    /**
     * @notice EIP-20 token symbol for this token
     */
    string public symbol;

    /**
     * @notice EIP-20 token decimals for this token
     */
    uint8 public decimals;
    
    /**
     * @notice Administrator for this contract
     */
    address payable public admin;

    /**
     * @notice Pending administrator for this contract
     */
    address payable public pendingAdmin;

    /**
     * @notice Contract which oversees inter-indexToken operations
     */
    MeFiInterface public IndexController;

    /**
     * @notice Initial exchange rate used when minting the first IndexTokens (used when totalSupply = 0)
     */
    uint internal initialExchangeRateMantissa;
    
    /**
     * @notice Total number of tokens in circulation
     */
    uint public totalSupply;

    /**
     * @notice Official record of token balances for each account
     */
    mapping (address => uint) internal accountTokens;

    /**
     * @notice Approved token transfer amounts on behalf of others
     */
    mapping (address => mapping (address => uint)) internal transferAllowances;
      
    
      
    uint weightedMarketCap = 5000000000000; 
    uint indexDevisor;
    
    MeFiInterface indexController;
    address[] priceFeedList; 
    
    address[] coinAddresses; 
    PriceConsumerV3 priceOracle; 
    
    constructor() public{
        admin = msg.sender; 
    }
    
    
    function initialize(MeFiInterface indexController_,
                        string memory name_,
                        string memory symbol_,
                        uint8 decimals_, 
                        uint IndexDevisor_,
                        address[] calldata priceFeedList_) public {
        require(msg.sender == admin, "only admin may create a new index");
        
        
        
         // Set the IndexController
        uint err = _setIndexController(indexController_);
        // require(err == uint(Error.NO_ERROR), "setting IndexController failed");
        
        
        // Set priceFeedList
        err = _setPriceFeedList(priceFeedList_);
        // require(err == uint(Error.NO_ERROR), "setting PriceFeed List failed");
        
        
        // Set the index Divisor rate model (depends on block number / borrow index)
        err = _setIndexDevisor(IndexDevisor_);
        require(err == uint(IndexControllerErrorReporter.Error.NO_ERROR), "setting IndexDevisor failed");
        
        
        name = name_;
        symbol = symbol_;
        decimals = decimals_;
    }  
    
    
        /**
      * @notice Sets a new IndexController for the market
      * @dev Admin function to set a new IndexController
      * @return uint 0=success, otherwise a failure (see ErrorReporter.sol for details)
      */
    function _setIndexController(MeFiInterface newIndexController) public override returns (uint) {
        // Check caller is admin
        if (msg.sender != admin) {
            // return fail(Error.UNAUTHORIZED, FailureInfo.SET_INDEXCONTROLLER_OWNER_CHECK);
            return 0; 
        }

        MeFiInterface oldIndexController = indexController;
        // Ensure invoke newIndexController.isIndexController() returns true
        require(newIndexController.isIndexController(), "marker method returned false");

        // Set market's indexController to newIndexController
        IndexController = newIndexController;

        // Emit NewIndexController(oldIndexController, newIndexController)
        emit NewIndexController(oldIndexController, newIndexController);

        return 1; 
    }
    
    
    // User Functions ------------------------------------------------------------------------------------------
    
    function transfer(address dst, uint amount) external override returns (bool) {
        
        
        return true;
        
    }
    function transferFrom(address src, address dst, uint amount) external override returns (bool) {
        return true; 
    }
    function approve(address spender, uint amount) external override returns (bool) {
        return true; 
    }
    function allowance(address owner, address spender) external override view returns (uint) {
        return 1; 
    }
    function balanceOf(address owner) external override view returns (uint) {
        return 1;
    }
    
    function tokenValue() public override returns (uint) {
        require(indexDevisor > 0); 
        calculateWeightedMarketCap(); 
        require(weightedMarketCap > 0); 
        //FIXME 
        return weightedMarketCap / indexDevisor; 
    }
    
    
    
    
    // Admin Functions -----------------------------------------------------------------------------------------
    
    
        
    /**
     * @notice creates sets the new priceFeeds address that need to be check in order to create
     * evaluate which coins to buy and sell. 
     * @dev Admin function to initialize a new list of price feed averages. 
     * @return uint 0=success, otherwise a failure (see ErrorReport.sol for details)
     */
    function _setPriceFeedList(address[] calldata priceFeedAddresses) public override returns (uint) {
        // Check caller is admin
        if (msg.sender != admin) {
            return 1; 
        }
        
        priceFeedList = priceFeedAddresses; 
        // FIXME: IMPLEMENT LOGIC TO SET PRICE FEEDS. 
        return 0; 
    }

    
        /**
     * @notice Sets the new indexDevisor;
     * @dev Admin function to initialize a the index devisior. 
     * @return uint 0=success, otherwise a failure (see ErrorReport.sol for details)
     */
    function _setIndexDevisor(uint _indexDevisor) public override returns (uint) {
        // FIXME
        if (msg.sender != admin) {
            return 0; 
        }
        indexDevisor = _indexDevisor; 
        return 0; 
    }
    
    
    function _setPendingAdmin(address payable newPendingAdmin) public override returns (uint) {
        // FIXME
        
        return 0; 
    }
    
    
    function _acceptAdmin() external override returns (uint) {
        // FIXME
        return 0; 
    }
    

    
    function _setPriceOracle(address _priceOracleAddress) public  returns (bool) {
        if (msg.sender != admin) {
            return false;
        }
        priceOracle = PriceConsumerV3(_priceOracleAddress); 
    }
    
    
    //** Internal Functions **//
    
    /* 
     * This will create a call the price oracles can create the get the weights for each token. 
     * for this project it will be worth while to start with preset weights that are set in the 
     * constructor. 
     */
    function calculateWeightedMarketCap() internal returns (uint) {
        // FIXME
        // weightedMarketCap = 0; 
        for (uint i = 0; i < priceFeedList.length; i++) {
            // FIXME: need to multiply by the proper weight. This can be done by dividing by the weight. 
            
            uint weight = 4; 
            priceOracle.updatePriceFeed(priceFeedList[i]); 
            int256 price = priceOracle.getThePrice(); 
            EIP20Interface coin = EIP20Interface(coinAddresses[i]); 
            uint256 _totalSupply = coin.totalSupply(); 
            
            weightedMarketCap += uint(price) * uint(_totalSupply) / uint(weight); 
            
            // get price from oracle
            // get totalsupply from ERC-20 contract. 
            // weight by 1 / priceFeedList 
        }
        return 0; 
    }
    
    
    //  /**
    //  * @notice Sender supplies assets into the market and receives cTokens in exchange
    //  * @dev Accrues interest whether or not the operation succeeds, unless reverted
    //  * @param mintAmount The amount of the underlying asset to supply
    //  * @return (uint, uint) An error code (0=success, otherwise a failure, see ErrorReporter.sol), and the actual mint amount.
    //  */
    function mintInternal(uint mintAmount) internal returns (uint, uint) {
        //FIXME

        // mintFresh emits the actual Mint event if successful and logs on errors, so we don't need to
        return mintFresh(msg.sender, mintAmount);
    }
    
    
    // /**
    //  * @notice User supplies assets into the market and receives cTokens in exchange
    //  * @dev Assumes interest has already been accrued up to the current block
    //  * @param minter The address of the account which is supplying the assets
    //  * @param mintAmount The amount of the underlying asset to supply
    //  * @return (uint, uint) An error code (0=success, otherwise a failure, see ErrorReporter.sol), and the actual mint amount.
    //  */
    function mintFresh(address minter, uint mintAmount) internal returns (uint, uint) {
       //FIXME
       return (0, 1);
    }
    
    
    
    //  /**
    //  * @notice Sender redeems cTokens in exchange for the underlying asset
    //  * @dev Accrues interest whether or not the operation succeeds, unless reverted
    //  * @param redeemTokens The number of cTokens to redeem into underlying
    //  * @return uint 0=success, otherwise a failure (see ErrorReporter.sol for details)
    //  */
    function redeemInternal(uint redeemTokens) internal  returns (uint) {
        return 0; 
    }
    
    
    /**
     * @notice Sender redeems cTokens in exchange for a specified amount of underlying asset
     * @dev Accrues interest whether or not the operation succeeds, unless reverted
     * @param redeemAmount The amount of underlying to receive from redeeming cTokens
     * @return uint 0=success, otherwise a failure (see ErrorReporter.sol for details)
     */
    function redeemUnderlyingInternal(uint redeemAmount) internal  returns (uint) {
        return 0; 
    }
    
    
    /**
     * @notice Accrues interest and reduces reserves by transferring from msg.sender
     * @param addAmount Amount of addition to reserves
     * @return uint 0=success, otherwise a failure (see ErrorReporter.sol for details)
     */
    function _addReservesInternal(uint addAmount) internal returns (uint) { 
    
        return 0;
    }

}
























