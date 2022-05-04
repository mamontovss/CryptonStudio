pragma solidity ^0.8.0;

contract MyVoting {



struct CandidateResults{
    address candidate;
    uint vote;
}

struct Voter{
        bool voted;
}


struct Apply {                  // структура с информацией была ли оплата на участие в голосовании
    bool pay;
}

mapping (address=> Voter) public votingStatus;
mapping (address=> CandidateResults) public results;
mapping (address => Apply) public checkPayed; // мэппинг для проверки была ли оплпта для участия в голосовании

function addVoter (address _temp) public payable { // добавляем кандидата для голосования
  require (checkPayed[msg.sender].pay == true && results[_temp].candidate!=_temp); // Проверка оплаты и что такой кадидат уже не добавлен
  results[msg.sender].vote=0; 
  results[_temp].candidate = _temp;
}


function pay() public payable {
require(msg.value == 1 ether);
checkPayed[msg.sender].pay = true; // говорим что участие в голосвании оплачено и этот пользователь может добавлять кандидатов
}

function vote (address _temp2) public {
    require (votingStatus[msg.sender].voted == false && results[_temp2].candidate== _temp2);
    results[_temp2].vote= results[_temp2].vote+1; // голосуем за нужного кандидата и увеличиваем счетчик на один
    votingStatus[msg.sender].voted = true;
}

}