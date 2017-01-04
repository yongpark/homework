import React from 'react';

class Calculator extends React.Component {
  constructor(props) {
    super(props);
    // your code here
    this.state = { result:0, num1:"", num2:""};
    //the result and the two user-inputted numbers.
    this.setNum1 = this.setNum1.bind(this);
    this.setNum2 = this.setNum2.bind(this);
    this.add = this.add.bind(this);
    this.subtract = this.subtract.bind(this);
    this.multiply = this.multiply.bind(this);
    this.divide = this.divide.bind(this);
    this.clear = this.clear.bind(this);
  }

  // your code here



  setNum1(e){
    e.preventDefault();
    if (e.target.value) {
      const num1 = parseInt(e.target.value);
      this.setState({num1});
    }else{
      const num1 = "";
      this.setState({num1});
    }
  }

  setNum2(e){
    e.preventDefault();
    if (e.target.value) {
      const num2 = parseInt(e.target.value);
      this.setState({num2: num2});
    }else{
      const num2 = "";
      this.setState({num2: num2});
    }
  }

  add(e){
    e.preventDefault();
    const result = this.state.num1 + this.state.num2;
    this.setState({result});
  }

  subtract(e){
    e.preventDefault();
    const result = this.state.num1 - this.state.num2;
    this.setState({result});
  }

  multiply(e){
    e.preventDefault();
    const result = this.state.num1 * this.state.num2;
    this.setState({result});
  }

  divide(e){
    e.preventDefault();
    const result = this.state.num1 / this.state.num2;
    this.setState({result});
  }

  clear(e){
    e.preventDefault();
    const num1 = "";
    const num2 = "";
    this.setState({num1:num1, num2:num2, result:0});
  }

  render() {
    const{num1, num2, result} = this.state;
    return (
      <div>
        <h1>{this.state.result}</h1>
        <input onChange ={this.setNum1} value={num1}/>
        <input onChange ={this.setNum2} value={num2}/>
        <br/>
        <button onClick={this.clear}>Clear</button>
        <button onClick={this.add}>+</button>
        <button onClick={this.subtract}>-</button>
        <button onClick={this.multiply}>*</button>
        <button onClick={this.divide}>/</button>
      </div>
    );
  }
}

export default Calculator;
