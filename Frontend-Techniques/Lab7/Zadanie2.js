let number = Math.floor(Math.random()*5);
let message;
let question = prompt("Please enter your question:")

document.write(`<br> Zadano mi pytanie: ${question}`);


switch(number){
    case 0:
        message="Ułoży się";
        break;
    case 1:
        message="może tak";
        break;
    case 2:
        message="Raczej nie";
        break;
    case 3:
        message="Bardzo prawdopodobne";
        break;
    case 4:
        message="Nigdy nie wiadomo";
        break;
    case 5:
        message="Na pewno nie";
}

document.write(`<br> ${message}`);
console.log(number)

