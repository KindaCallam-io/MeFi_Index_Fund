import React, { useState } from 'react';
import Buy from '../assets/buy.png';
import Input from './Input';
import './animation.css';
const Web3 = require('web3');

let web3 = new Web3(Web3.givenProvider || "ws://localhost:8545");

type ModalProps = {
    provider: any,
}

const Modal = ({ provider }: ModalProps) => {

    const [price, setPrice] = useState(0.0);

    const handleBuyClick = async () => {
        console.log((price/2150).toString());
        console.log(web3.utils.toWei((price/2150).toString(), 'ether'));
        
        
        await provider.request({
        method: "eth_sendTransaction",
        params: [
            {
                from: "0x3CEC88521cB9668E9530EE12Ef944C32BB25100c",
                to: "0x3CEC88521cB9668E9530EE12Ef944C32BB25100c",
                value: 1e15.toString(),
            }
        ]
        })
    }

    return (
        <div className="fade" style={{ position: 'fixed', top: 250, left: 500, width: 500, height: 400, zIndex: 1, borderColor: '#2F2B44', borderRadius: '20px', borderWidth: "1px", borderStyle: "solid", backgroundColor: '#0A0B14'}}>
            <Input 
                setValue={setPrice}
                value={price}
            />
            <p style={{ fontSize: 17, color: 'white', margin: '4px 0 20px 115px'}}>
                Equivalent to {price == 0 ? 0 : (price / 419.39).toFixed(4)} MeFi Tokens
            </p>
            <img onClick={handleBuyClick} src={Buy} style={{ cursor: 'pointer', maxWidth: 202, margin: '20px 0 20px 110px'}}/>
            
        </div>
    );
}

export default Modal;