import "Extras/OnlyOwner.sol";
import "Extras/StandardToken.sol";

contract CCN is StandardToken, OnlyOwner{
	uint256 public constant decimals = 18;
    string public constant name = "CustomContractNetwork";
    string public constant symbol = "CCN";
    string public constant version = "1.0";
    uint256 public constant totalSupply = 890000000000*10**18;
    uint256 private approvalCounts =0;
    uint256 private minRequiredApprovals =2;
    address public burnedTokensReceiver;
    
    constructor() public{
        balances[msg.sender] = totalSupply;
        burnedTokensReceiver = 0x0000000000000000000000000000000000000000;
    }

    /**
   * @dev Function to set approval count variable value.
   * @param _value uint The value by which approvalCounts variable will be set.
   */
    function setApprovalCounts(uint _value) public isController {
        approvalCounts = _value;
    }
    
    /**
   * @dev Function to set minimum require approval variable value.
   * @param _value uint The value by which minRequiredApprovals variable will be set.
   * @return true.
   */
    function setMinApprovalCounts(uint _value) public isController returns (bool){
        require(_value > 0);
        minRequiredApprovals = _value;
        return true;
    }
    
    /**
   * @dev Function to get approvalCounts variable value.
   * @return approvalCounts.
   */
    function getApprovalCount() public view isController returns(uint){
        return approvalCounts;
    }
    
     /**
   * @dev Function to get burned Tokens Receiver address.
   * @return burnedTokensReceiver.
   */
    function getBurnedTokensReceiver() public view isController returns(address){
        return burnedTokensReceiver;
    }
    
    
    function controllerApproval(address _from, uint256 _value) public isOwner returns (bool) {
        require(minRequiredApprovals <= approvalCounts);
		require(_value <= balances[_from]);		
        balances[_from] = balances[_from].safeSub(_value);
        balances[burnedTokensReceiver] = balances[burnedTokensReceiver].safeAdd(_value);
        emit Transfer(_from,burnedTokensReceiver, _value);
        return true;
    }
}