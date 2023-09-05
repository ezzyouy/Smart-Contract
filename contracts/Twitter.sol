//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.18;

contract Twitter {
    uint16 public MAX_TWEET_LENGTH = 280;
    struct Tweet {
        uint256 id;
        address author;
        string content;
        uint256 timestamp;
        uint256 likes;
    }

    mapping(address => Tweet[]) public tweets;
    address public owner;
    constructor() {
        owner=msg.sender;
    }
    modifier onlyOwner(){
        require(msg.sender == owner, "YOU ARE NOT THE OWNER");
        _;
    }
    function changeTweetLength(uint16 newTweetLength) public onlyOwner{
        MAX_TWEET_LENGTH = newTweetLength;
    }
    function createTweet(string memory _tweet) public {
        require(
            bytes(_tweet).length <= MAX_TWEET_LENGTH,
            "tweet is to long !!!"
        );
        Tweet memory newTweet = Tweet({
            id:tweets[msg.sender].length,
            author: msg.sender,
            content: _tweet,
            timestamp: block.timestamp,
            likes: 0
        });
        tweets[msg.sender].push(newTweet);
    }

    function likeTweet(address author, uint256 id) external  {
        require(tweets[author][id].id == id,"TWEET DOES NOT EXIST");
        tweets[author][id].likes++;
    }
     function unlikeTweet(address author, uint256 id) external  {
        require(tweets[author][id].id == id,"TWEET DOES NOT EXIST");
        require(tweets[author][id].likes > 0 ,"TWEET HAS NO LIKES");
        tweets[author][id].likes--;
    }
    function getTweet(uint256 _i) public view returns (Tweet memory) {
        return tweets[msg.sender][_i];
    }

    function getAllTweets(address _owner) public view returns (Tweet[] memory) {
        return tweets[_owner];
    }
}
