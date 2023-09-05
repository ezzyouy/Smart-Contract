//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.18;

contract EventExemple {

    event NewUserRegister(address indexed user,string username);
    
    struct User{
        string username;
        uint256 age;
    }

    mapping(address => User) public users;

    function registerUser(string memory _username, uint256 _age) public {
        User storage newUser=users[msg.sender];
        newUser.username=_username;
        newUser.age=_age;

        emit NewUserRegister(msg.sender, _username);
    }
}