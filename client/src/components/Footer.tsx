import React from 'react'
import { Row, Col } from 'antd' 
import Logo from '../assets/logo_small.png'
import Socials from '../assets/social.png'

const Footer = () => {
    return (
        <div>
            <Row style={{ height: '40px', margin: '200px 0 150px 0' }}>
                <Col span={4} offset={4}>
                    <span style={{ color: 'white', fontSize: '20px' }}>Ready to get started?</span>
                </Col>
                <Col span={6} offset={3}>
                    <div style={{ borderRadius: '20px', backgroundColor: 'white', color: '#686D97', height: '100%', lineHeight: '40px'}}>
                        <span style={{ margin: '0 0 0 15px'}}>Your email address</span>
                    </div>
                </Col>
                <Col span={3} offset={1}>
                    <div style={{ borderRadius: '20px', backgroundColor: '#003CFF', color: 'white', height: '100%', textAlign: 'center', lineHeight: '40px'}}>
                        <span>Submit</span>
                    </div>
                </Col>
            </Row>
            <Row style={{ height: '40px', color: 'white', marginBottom: '200px' }}>
                <Col span={1} offset={4}>
                    <img src={Logo} style={{ maxWidth: 84}}/>
                </Col>
                <Col span={2} offset={1}>
                    <p><b>Exchange</b></p>
                    <div style={{ color: '#686D97' }}>
                        Markets<br/>
                        Fees<br/>
                        Trading Rules<br/>
                    </div>
                </Col>
                <Col span={2} offset={1}>
                    <p><b>Company</b></p>
                    <div style={{ color: '#686D97' }}>
                        Announcements<br/>
                        News<br/>
                    </div>
                </Col>
                <Col span={2} offset={1}>
                    <p><b>Legal</b></p>
                    <div style={{ color: '#686D97' }}>
                        Terms<br/>
                        Privacy<br/>
                    </div>
                </Col>
                <Col span={2} offset={1}>
                    <p><b>Support</b></p>
                    <div style={{ color: '#686D97' }}>
                        FAQ<br/>
                        Help Center<br/>
                    </div>
                </Col>
                <Col span={2} offset={1}>
                    <p><b>Social</b></p>
                    <img src={Socials} style={{ maxWidth: 121}}/>
                </Col>
            </Row>
        </div>
    )
}

export default Footer