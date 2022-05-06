pragma solidity ^0.8.0;

contract MyVoting {
address public owner;
uint public id=0;
uint public winner=0;


constructor (){
    owner= msg.sender; // идентификация создателя контаркта 
}

struct CandidateResults{ // структура которая хранит данные об адресе кандидата
    address candidate; // адрес кандидата
    uint vote;   // количестве голосов за кандидата
}

struct Voter{
        bool voted;
}


struct Apply {                  // структура с информацией была ли оплата на участие в голосовании
    bool pay;
}

mapping (address=> Voter) public votingStatus;
//mapping (address=> CandidateResults) public results;
mapping (address => Apply) public checkPayed; // мэппинг для проверки была ли оплпта для участия в голосовании
mapping (uint => CandidateResults) public listResults; // мэпинг ключ - структура

function addVoter (address _temp) public payable { // Функция которая добавляет кандидата для голосования
  require (checkPayed[msg.sender].pay == true && checkCandidateInStruct(_temp)!=true); // Проверка оплаты и что такой кадидат уже не добавлен
  id= id+1;
  listResults[id].vote = 0;
  listResults[id].candidate = _temp;
 // results[msg.sender].vote=0; 
  // results[_temp].candidate = _temp;
}


function pay() public payable { // функция оплаты, которая требует чтобы участник голосования произвел оплату
require(msg.value == 10000000000000000); // 0.01 eth
checkPayed[msg.sender].pay = true; // говорим что участие в голосвании оплачено и этот пользователь может добавлять кандидатов
}

function vote (address _temp2) public {  // функция которая позволяет голосовать
    require (votingStatus[msg.sender].voted == false && checkCandidateInStruct(_temp2)==true); // results[_temp2].candidate== _temp2);
    // results[_temp2].vote= results[_temp2].vote+1; // голосуем за нужного кандидата и увеличиваем счетчик на один
     listResults[id].vote= listResults[id].vote+1;
    votingStatus[msg.sender].voted = true;
}

function checkCandidateInStruct(address _temp2) public returns(bool _r){

    for (uint _i = 0; _i<=id; _i++) {  //for loop example
        if (listResults[id].candidate == _temp2) {
            _r = true;
        }
           
      }

}

function endvoting() public {
   require(checkPayed[msg.sender].pay == true); 
    winner = findMaxValue();
    address payable _to= payable (listResults[id].candidate);
    address _thiscontract = address(this);  //узнаем адрес текущего контракта
    //_to.transfer(_thiscontract.balance); // переводим все что есть на контракте на нужный адресс;
    uint _amount =_thiscontract.balance- (((_thiscontract.balance)/100)*10);  // вычет комисии в 10 %
    _to.transfer(_amount); // перевод зачисленной суммы на контракт за вычетом комисии
}

function ownerBalance() public returns (uint _to){
    _to= address(this).balance;
}

function findMaxValue() public returns (uint _winnerid){  // поиск победителя
    uint _max;
    _max= listResults[id].vote;
     for (uint _i = 0; _i<=id; _i++) {  //for loop example
        if (listResults[id].vote<listResults[_i].vote) {
            _max= listResults[_i].vote;
            _winnerid =_i;
        }
           
      }
       

}


}