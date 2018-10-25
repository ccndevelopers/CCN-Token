import "../ERC20/erc20.sol";
import "../safemath/SafeMath.sol";

contract OnlyOwner {
  address public owner;
  address private controller;
  //log the previous and new controller when event  is fired.
  event SetNewController(address prev_controller, address new_controller);
  /** 
   * @dev The Ownable constructor sets the original `owner` of the contract to the sender
   * account.
   */
  constructor() public {
    owner = msg.sender;
    controller = owner;
  }


  /**
   * @dev Throws if called by any account other than the owner. 
   */
  modifier isOwner {
    require(msg.sender == owner);
    _;
  }
  
  /**
   * @dev Throws if called by any account other than the controller. 
   */
  modifier isController {
    require(msg.sender == controller);
    _;
  }
  
  function replaceController(address new_controller) isController public returns(bool){
    require(new_controller != address(0x0));
	controller = new_controller;
    emit SetNewController(msg.sender,controller);
    return true;   
  }

}