//SPDX-License-Identifier: GPL-3.0

pragma solidity >= 0.5.0 < 0.9.0;

contract Lottery
{
    address public manager;
    address payable[] public participants;

    constructor()
    {
        manager=msg.sender; // global variable. those who send Ether for Lottery. 
    }

    receive() external payable
    {   require (msg.value == 2 ether);
        participants.push(payable(msg.sender));
    }

    function getBalance() public view returns(uint)
    {   require(msg.sender == manager);
        return address(this).balance; //Lottery Committe Balance
    }

    function random() public view returns(uint) // for picked random account but we shuld not use it in real appilication
    {
        return uint(keccak256(abi.encodePacked(block.difficulty, block.timestamp,participants.length)));
    }

    function selectWinner() public view returns(address)
    {
        require(msg.sender==manager);
        require(participants.length >=3);
        uint r = random();
        address payable winner;
        uint index = r % participants.length;
        winner= participants[index];
        return winner;
    }
}