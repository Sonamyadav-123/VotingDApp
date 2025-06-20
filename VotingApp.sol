// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract VotingApp {
    address public owner;
    string[] public candidates;
    mapping(string => uint256) public votes;
    mapping(address => bool) public hasVoted;

    constructor(string[] memory _candidates) {
        owner = msg.sender;
        candidates = _candidates;
    }

    function vote(string memory _candidate) public {
        require(!hasVoted[msg.sender], "You have already voted");
        bool valid = false;
        for (uint256 i = 0; i < candidates.length; i++) {
            if (keccak256(bytes(candidates[i])) == keccak256(bytes(_candidate))) {
                valid = true;
                break;
            }
        }
        require(valid, "Invalid candidate");
        votes[_candidate]++;
        hasVoted[msg.sender] = true;
    }

    function getVotes(string memory _candidate) public view returns (uint256) {
        return votes[_candidate];
    }

    function resetVotes() public {
        require(msg.sender == owner, "Only owner can reset votes");
        for (uint256 i = 0; i < candidates.length; i++) {
            votes[candidates[i]] = 0;
        }
    }
}
