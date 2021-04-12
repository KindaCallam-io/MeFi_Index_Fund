import { render } from '@testing-library/react';
import React, { useState } from 'react'
import funds from '../assets/funds.png'
import Header from '../components/Header';
import Footer from '../components/Footer';
import Card from '../components/Card';
import Buy from '../assets/buy.png'
import Shield from '../assets/Shield.png';
import Chart from '../assets/chart.png';
import Compass from '../assets/Discovery.png';
import { Row, Col } from 'antd';

import PaymentModal from '../components/PaymentModal';

type LandingProps = {
    provider: any
    loader: any
}

const Landing = ({ provider, loader }: LandingProps) => {

    const [modal, toggleModal] = useState(false);

    return(
        <div className="background">
            <Header loader={loader} />
            <Row style={{ margin: '0.1cm 0 2cm 0'}}>
                <img src={funds} style={{ display: 'block', marginLeft: 'auto', marginRight: 'auto', marginTop: '30px', maxWidth: '1100px'}}/>
            </Row>
            <Row>
                <Col span={11} offset={4}>
                    <div style={{ fontSize: 60, color: 'white', lineHeight: 1.2, fontWeight: 270}}>
                        The <span style={{ fontWeight: 700 }}>automated</span>
                        <br />smart-contract index fund
                    </div>
                    <div style={{ fontSize: 18, color: '#7279A0'}}>
                        A cryptocurrency index fund powered by smart contracts to maximize trust and 
                        <br />transparency while minimizing fees and inefficiencies.
                    </div>
                </Col>
                <Col span={8} offset={1}>
                    <p style={{ color: 'white', fontSize: '17', fontWeight: 700, margin: '35px 0 0 0' }}>Current Price</p>
                    <p style={{ color: 'white', fontSize: '50px', fontWeight: 700, margin: '-15px 0 10px 0' }}>$419.39</p>
                    <img onClick={() => {toggleModal(!modal)}} src={Buy} style={{ cursor: 'pointer', maxWidth: 202 }}/>
                </Col>
                {modal ? <PaymentModal provider={provider}/> : null}
            </Row>
            <Row style={{ marginTop: '10cm'}}>
                <Col span={4} offset={5}>
                    <Card 
                        title="Secure"
                        text="The smart contracts behind this fund are audited and rigorously tested."
                        img={Shield}
                    />
                </Col>
                <Col span={4} offset={2}>
                    <Card 
                        title="Passive"
                        text="No entry fees for investors and a 0% management fee for tokenholders."
                        img={Chart}
                    />
                </Col>
                <Col span={4} offset={2}>
                    <Card 
                        title="Discover"
                        text="Filter funds based on historical performance or market."
                        img={Compass}
                    />
                </Col>
            </Row>
            <Footer />
        </div>
    )
}

export default Landing;