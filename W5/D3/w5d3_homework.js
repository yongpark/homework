function mysteryScoping1() {
  var x = 'out of block';
  if (true) {
    var x = 'in block';
    console.log(x);
  }
  console.log(x);
}

//in block, in block

function mysteryScoping2() {
  const x = 'out of block';
  if (true) {
    const x = 'in block';
    console.log(x);
  }
  console.log(x);
}

//in block, out of block

function mysteryScoping3() {
  const x = 'out of block';
  if (true) {
    var x = 'in block';
    console.log(x);
  }
  console.log(x);
}

//error

function mysteryScoping4() {
  let x = 'out of block';
  if (true) {
    let x = 'in block';
    console.log(x);
  }
  console.log(x);
}
//in block, out of block

function mysteryScoping5() {
  let x = 'out of block';
  if (true) {
    let x = 'in block';
    console.log(x);
  }
  let x = 'out of block again';
  console.log(x);
}

//error

function madLib(verb, adjective, noun){
  return 'We Shall ${verb.toUpperCase()} the ${adj.toUpperCase()} ${noun.toUpperCase()}'
}

function fizzBuzz(array) {
  var newArray = [];

  array.forEach(function (el) {
    if ((el % 3 === 0 || el % 5 === 0) && el % 15 !== 0) {
      newArray.push(el);
    }
  });

  return newArray;
}


function isPrime(number) {
  if (number < 2) { return false; }

  for (let i = 2; i < number; i++) {
    if (number % i === 0) {
      return false;
    }
  }
  return false;
}

function sumOfNPrimes(number){
  let sum = 0;
  let count= 0;
  let i = 2;

  while (count < number) {
    if (isPrime(i)){
      sum += i;
      count++;
    }
    i++;
  }
  return sum;
}

function allOrNothing(mod) {
  for (let i = 1; i < arguments.length; i++){
    if (arguments[i] % mod !== 0) {
      return false;
    }
  }
  return true;
}

function titleize(names, callback) {
  let titleized = names.map(function(name){
    `Mx. ${name} Jingleheimer Schmidt`;
  }
  );
  callback(titleized);
}

titleize(["Mary", "Brian", "Leo"], function(names){
  names.forEach(function(name){
    console.log(name);
  }
  );
});

function Elephant(name, height, tricks) {
  this.name = name;
  this.height = height;
  this.tricks = tricks;
}

Elephant.prototype.trumpet = function () {
  console.log(`${this.name} the elephant goes 'phrRRRRRRRRRRR!!!!!!!'`);
};

Elephant.prototype.grow = function(){
  this.height = this.height + 12;
};

Elephant.prototype.addTrick(trick) = function(trick){
  this.tricks.push(trick);
};

Elephant.paradeHelper = function (elephant) {
  console.log(`${elephant.name} is trotting by!`);
};

function dinerBreakfast(){
  let order = "I'd like cheesy scrambled eggs please"

  return function (food){
    order = '${order.slice(0, order.length - 8)} and ${food} please.';
    console.log(order)
  };
};
