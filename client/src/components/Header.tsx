import React from 'react';
import Logo from '../assets/logo.png';
import English from '../assets/english.png';
import { Row, Col } from 'antd';
import { useAlert } from 'react-alert'

type HeaderProps = {
    loader: any
}

const Header = ({ loader }: HeaderProps) => {

    const alert = useAlert()

    const handleWalletClick = () => {
        loader().then(() => {
            alert.show("Wallet Connected");
        })
    }
    
    return (
        <Row style={{ backgroundColor: 'black', width: '100vw', height: '74px', borderStyle: 'solid', borderColor: '#2F2B44', borderWidth: '1px' }}>
            <Col span={18}>
                <a href={'/'}><img src={Logo} style={{ padding: '18px 0 0 60px', maxWidth: 210}}/></a>
            </Col>
            <Col span={3}>
                <div onClick={handleWalletClick} style={{ backgroundColor: '#003CFF', color: 'white', display: 'flex', justifyContent: 'center', alignItems: 'center', height: '100%', cursor: 'pointer' }}>
                    <b>Connect Wallet</b>
                </div>
            </Col>
            <Col span={3}>
                <div style={{ display: 'flex', justifyContent: 'center', alignItems: 'center', height: '100%'}}>
                    <img src={English} style={{ maxWidth: 81 }}/>
                </div>
            </Col>
        </Row>
    )
}

export default Header;