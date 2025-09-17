import React from 'react';
import './QuotePage.scss';
import axios from 'axios';
import { Table, Spin } from 'antd';
import { useState, useEffect } from 'react';
import NavBar from '../../component/NavBar/NavBar';

const API_KEY = 'EQ693O64B4BLGAP8';
const TICKERS = ['AAPL', 'AMZN', 'IBM']

function QuotePage(props){
    const [quotes, setQuotes] = useState([]);
    const [loading, setLoading] = useState(true);
    const [error, setError] = useState(null);

    const fetchQuote = async (symbol) => {
        try {
            const response = await axios.get('https://www.alphavantage.co/query', {
                params: {
                    function: 'GLOBAL_QUOTE',
                    symbol,
                    apikey: API_KEY,
                },
            });
      
        const data = response.data['Global Quote'];
        if (!data) return null;

        return {
            key: symbol,
            ticker: symbol,
            lastPrice: parseFloat(data['05. price']),
            bidPrice: parseFloat(data['02. open']),
            bidSize: Math.floor(Math.random() * 1000 + 100),
            askPrice: parseFloat(data['04. low']),
            askSize: Math.floor(Math.random() * 1000 + 100),
        };
        } catch (err) {
            console.error('Error fetching ${symbol}:', err);
            return null;
        }
    };

    useEffect(() => {
        const loadQuotes = async () => {
            setLoading(true);
            const results = await Promise.all(TICKERS.map(fetchQuote));
            setQuotes(results.filter(Boolean));
            setLoading(false);
        };

        loadQuotes();
    }, []);

    const columns = [
        {title: 'Ticker', dataIndex: 'ticker', key: 'ticker' },
        {title: 'Last Price', dataIndex: 'lastPrice', key: 'lastPrice', render: price => price?.toFixed(2) },
        { title: 'Bid Price', dataIndex: 'bidPrice', key: 'bidPrice', render: price => price?.toFixed(2) },
        { title: 'Bid Size', dataIndex: 'bidSize', key: 'bidSize' },
        { title: 'Ask Price', dataIndex: 'askPrice', key: 'askPrice', render: price => price?.toFixed(2) },
        { title: 'Ask Size', dataIndex: 'askSize', key: 'askSize' },
    ];

    return (
        <div className="quote-page">
            <NavBar />
            <div className="quote-page-content">
                <div className="title">Quotes</div>
                {loading ? (
                    <div className="loading"><Spin size="large" /></div>
                ) : (
                    <Table
                        dataSource={quotes}
                        columns={columns}
                        pagination={false}
                        bordered
                    />
                )}
            </div>
        </div>
    );
}

export default QuotePage;