import React, { useState, useEffect } from 'react';
import './App.css';
import Landing from './views/Landing'
import detectEthereumProvider from '@metamask/detect-provider';
import Web3 from "web3";

declare const window: any

let provider : any;

function App() {

  const [refresh, setrefresh] = useState(0);
  
  const loadWeb3 = async () => {
    if (window.ethereum) {
      window.web3 = new Web3(window.ethereum);
      await window.ethereum.enable();
    } else if (window.web3) {
      window.web3 = new Web3(window.web3.currentProvider);
    } else {
      window.alert(
        "Non-Ethereum browser detected. You should consider trying MetaMask!"
      );
    }
  };

  return (
    <div className="App">
      <Landing loader={loadWeb3} provider={window.ethereum}/>
    </div>
  );
}

export default App;
