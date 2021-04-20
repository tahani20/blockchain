//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
/*contract CampaignFactory{
    // ==== Fields ====
    address[] public deployedCampaigns;
    address contractOwner;
    constructor(){
    contractOwner = msg.sender;     
    }
    // ==== Modifier ====
    // ==== create a new contract ====
    function createCampaign(uint minimum) public  {
        require(contractOwner == msg.sender, "Only onwer");
        address newCampaign =address (new Campaign(minimum,msg.sender));
        deployedCampaigns.push(newCampaign);
    }
    // ==== returning all the address of the deployed contract
    function getDeployedCampaigns() public view returns (address[]memory){
        return deployedCampaigns;
    }
}*/
contract Campaign{
        //erc20 function start from here
    mapping (address => uint256) private _balances;
    uint256 private _totalSupply;
    string private _name = "token";
    string private _symble = "HL";
    function decimals() public pure returns(uint8){
        return 18;
    }
    function balanceOf() public view returns(uint){
        return _balances[msg.sender];
    }
    function _mint(address account, uint256 amount) internal {
        require(account != address(0), "HL: mint to the zero address");
        //_beforeTokenTransfer(address(0), account, amount);
        _totalSupply += amount;
        _balances[account] += amount;
        //emit Transfer(address(0), account, amount);
    }
    function _burn(address account, uint256 amount) internal {
        require(account != address(0), "HL: mint to the zero address");
        //_beforeTokenTransfer(address(0), account, amount);
        uint256 accountBalance = _balances[account];
        require(accountBalance >= amount);
        _totalSupply -= amount;
        _balances[account] = accountBalance - amount;
    }
    /* function transfer(address recipient, uint256 amount) public virtual override returns (bool) {
        _transfer(_msgSender()
, recipient, amount);
        return true;
    }*/
        function _transfer(address sender, address recipient, uint256 amount) internal {
        require(sender != address(0), "ERC20: transfer from the zero address");
        require(recipient != address(0), "ERC20: transfer to the zero address");
        uint256 senderBalance = _balances[sender];
        require(senderBalance >= amount, "ERC20: transfer amount exceeds balance");
        _balances[sender] = senderBalance - amount;
        _balances[recipient] += amount;
}
    // collection of key value pairs
    // end point factory contract address :  => map --> (add, true)
    struct Request{
        string description;
        uint value;
        address payable recipient;
        bool complete;
        uint approvalCount;
        mapping(address => bool) approvals;
        uint collection;
        // mapping(address => mapping(bool=>uint)) approvals;
    }
    // === Fields ===
    Request[] public requests;
    address public manager;
    uint public minimumContribution;
    mapping(address => bool) public approvers;
    uint public approversCount;
    mapping(address => uint) public ethBalance;
    mapping(uint => Request) public requestInfo;
    // === Methods ===
    // == Modifier ==
    modifier authorization(){
        require(msg.sender == manager);
        _;
    }
    /// 0xdD870fA1b7C4700F2BD7f44238821C26f7392148
    // == constructor ==
    //Setting the manager and minimum amount to contribute
      constructor()  {
        manager = msg.sender;
        //minimumContribution = minimum;
    }
   // function seteminimum (uint mini)public{
   //  minimumContribution = mini;
   // }
   // function deposit() public payable{
     // ->   _mint(msg.sender, msg.value); // 1 ether == 10000000000000000 ; 100000000000000000 token = 1 ethe
//        ethBalance[msg.sender] = msg.value;
  //  }
    //donate money to compaign and became an approver
    function contribute() public payable {
       // require(msg.value > minimumContribution);
        if(approvers[msg.sender]!= true){
           approvers[msg.sender] = true;
           //payable(address(th


        //_balances[msg.sender] -= _amount;
          //  _transfer(msg.sender, address(this), _balances[msg.sender] - _amount );
           // approversCount++;
            //requests[].collection =+ _amount;
        }
        //0x03C6FcED478cBbC9a4FAB34eF9f40767739D1Ff7
    }
    //creating a new request by the manager
   /* function createRequest(string memory description, uint value, address recipient)
        public authorization{
            Request memory newReq = Request({
                description : description,
                value : value,
                recipient : recipient,
                complete : false,
                approvalCount : 0
            });
            requests.push(newReq);
        }*/
        function createRequest(string memory _description, uint _value, address  payable _recipient) public authorization {
            uint256 idx = requests.length;
           requests.push();
        Request storage newReq = requests[idx];
        newReq.description=_description;
        newReq.value=_value;
        newReq.recipient=_recipient;
        newReq.complete=false;
        newReq.approvalCount=0;
        }
    //approving a particular request by the user
    function approveRequest(uint index) public {
        Request storage request = requests[index];
        require(approvers[msg.sender]);
        require(!request.approvals[msg.sender]);
        request.approvals[msg.sender] = true;
        request.approvalCount++;
    }
    //final approval of request by the manager and sending the amount
    function finalizeRequest(uint index) public payable authorization{
        Request storage request = requests[index];
        //require(request.approvalCount > (approversCount/2));
        //require(!request.complete);
       // request.recipient.transfer(request.value);
       //_balances[address(this)] -= request.collection;
       //_transfer(address(this), request.recipient, request.collection );
       request.recipient.transfer(address(this).balance);
        request.complete = true;
    }
    // function to retrieve Campaign balance, minimumContribution , no of requests , no of Contributors and manager address
    function getSummary() public view returns (
        uint, uint, uint, uint, address
        ) {
        return (
            minimumContribution,
            address(this).balance,
            requests.length,
            approversCount,
            manager
            ); 
    }
// returing no of requests
    function getRequestsCount() public view returns (uint) {
        return  requests.length;
    }
}