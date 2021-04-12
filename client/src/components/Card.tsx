import React from 'react';

type CardProps = {
    title: string,
    text: string,
    img: any,
}

const Card = ({ title, text, img }: CardProps) => {

    return (
        <div>
            <img src={img} style={{maxWidth: 59, minWidth: 59}}/>
            <p style={{ fontSize: 23, color: 'white', marginBottom: -4, marginTop: 10}}>{ title }</p>
            <p style={{ fontSize: 17, color: '#7279A0'}}>
                { text }
            </p>
        </div>
    );
}

export default Card;