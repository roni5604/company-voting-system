// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

contract VotingSystem {
   enum Role { None, Manager, Customer }

   struct User {
       string username;
       Role role;
   }
   

   struct Vote {
       uint256 id;
       string question;
       string[] options;
       uint256[] votesPerOption;
       uint256 closingDate;
       bool isOpen;
       mapping(address => bool) hasVoted;
   }

   address public owner;
   uint256 public voteCount;
   mapping(address => User) public authorizedUsers;
   mapping(address => bool) public admins; // Mapping for admin roles
   mapping(uint256 => Vote) public votes;
   address[] public userAddresses;

   modifier onlyOwner() {
       require(msg.sender == owner, "Not contract owner");
       _;
   }

   modifier onlyManager() {
       require(
           authorizedUsers[msg.sender].role == Role.Manager,
           "Not a manager"
       );
       _;
   }

   modifier onlyAuthorized() {
       require(
           authorizedUsers[msg.sender].role != Role.None,
           "Not authorized"
       );
       _;
   }

   event UserAdded(address user, string username, Role role);
   event UserRemoved(address user);
   event VoteCreated(uint256 voteId, string question);
   event VoteClosed(uint256 voteId);
   event Voted(uint256 voteId, address voter, uint256 option);

   constructor() {
       owner = msg.sender;
       authorizedUsers[msg.sender] = User("Owner", Role.Manager);
       admins[msg.sender] = true; // Set owner as an admin
       userAddresses.push(msg.sender);
   }

   // Owner functions
   function addUser(
       address _user,
       string memory _username,
       Role _role
   ) public onlyManager {
       require(
           authorizedUsers[_user].role == Role.None,
           "User already exists"
       );
       authorizedUsers[_user] = User(_username, _role);
       userAddresses.push(_user);
       emit UserAdded(_user, _username, _role);

       if (_role == Role.Manager) {
           admins[_user] = true; // Automatically add managers as admins
       }
   }

   function removeUser(address _user) public onlyManager {
       require(
           authorizedUsers[_user].role != Role.None,
           "User does not exist"
       );
       delete authorizedUsers[_user];
       emit UserRemoved(_user);
   }

   // Manager functions
   function createVote(
       string memory _question,
       string[] memory _options,
       uint256 _closingDate
   ) public onlyManager {
       require(_options.length >= 2, "At least two options required");
       require(
           _closingDate > block.timestamp,
           "Closing date must be in the future"
       );

       Vote storage newVote = votes[voteCount];
       newVote.id = voteCount;
       newVote.question = _question;
       newVote.options = _options;
       newVote.closingDate = _closingDate;
       newVote.isOpen = true;
       newVote.votesPerOption = new uint256[](_options.length);

       voteCount++;
       emit VoteCreated(newVote.id, _question);
   }

   function closeVote(uint256 _voteId) public onlyManager {
       Vote storage voteInstance = votes[_voteId];
       require(voteInstance.isOpen, "Vote already closed");
       voteInstance.isOpen = false;
       emit VoteClosed(_voteId);
   }

   // Customer functions
   function vote(uint256 _voteId, uint256 _optionIndex)
   public
   onlyAuthorized
   {
       Vote storage voteInstance = votes[_voteId];
       require(voteInstance.isOpen, "Vote is closed");
       require(
           block.timestamp <= voteInstance.closingDate,
           "Voting period has ended"
       );
       require(
           !voteInstance.hasVoted[msg.sender],
           "Already voted in this vote"
       );
       require(
           _optionIndex < voteInstance.options.length,
           "Invalid option"
       );

       voteInstance.votesPerOption[_optionIndex]++;
       voteInstance.hasVoted[msg.sender] = true;
       emit Voted(_voteId, msg.sender, _optionIndex);
   }

   // Public functions
   function getVoteDetails(uint256 _voteId)
   public
   view
   returns (
       uint256 id,
       string memory question,
       string[] memory options,
       uint256[] memory votesPerOption,
       uint256 closingDate,
       bool isOpen
   )
   {
       Vote storage voteInstance = votes[_voteId];
       return (
       voteInstance.id,
       voteInstance.question,
       voteInstance.options,
       voteInstance.votesPerOption,
       voteInstance.closingDate,
       voteInstance.isOpen
       );
   }

   function hasUserVoted(uint256 _voteId, address _user)
   public
   view
   returns (bool)
   {
       return votes[_voteId].hasVoted[_user];
   }

function getUserRole(address _user) public view returns (Role) {
    return authorizedUsers[_user].role;
}




   function getAllUsers() public view returns (address[] memory) {
       return userAddresses;
   }

   // Add a function to check user authorization for a specific vote
   function isUserAuthorized(uint256 _voteId, address _user) public view returns (bool) {
       return authorizedUsers[_user].role != Role.None && !votes[_voteId].hasVoted[_user];
   }

   // Add a function to return the number of votes
   function getVotesCount() public view returns (uint256) {
       return voteCount;
   }

   function getUsername(address _user) public view returns (string memory) {
    require(authorizedUsers[_user].role != Role.None, "User not found");
    return authorizedUsers[_user].username;
}

}
