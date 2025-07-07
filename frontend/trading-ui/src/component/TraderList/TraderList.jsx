import React from 'react';
import { Table } from 'antd';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { faTrashAlt as deleteIcon } from '@fortawesome/free-solid-svg-icons';
import { useState, useEffect } from 'react';
import TraderListData from './TraderListData.json';

import 'antd/dist/antd.css';
import './TraderList.scss';

function TraderList(props) {

    //Initialization of columns for table
    const columns = [
        {
            title: 'First Name',
            dataIndex: 'firstName',
            key: 'firstName',
        },
        {
            title: 'Last Name',
            dataIndex: 'lastName',
            key: 'lastName',
        },
        {
            title: 'Email',
            dataIndex: 'email',
            key: 'email',
        },
        {
            title: 'Date of Birth',
            dataIndex: 'dob',
            key: 'dob',
        },
        {
            title: 'Country',
            dataIndex: 'country',
            key: 'country',
        },
        {
            title: 'Actions',
            dataIndex: 'actions',
            key: 'actions',
            render: (text, record) => (
                <div className="trader-delete-con">
                    <FontAwesomeIcon icon={ deleteIcon } onClick={() => props.onTraderDeleteClick(record.id) } />
                </div>
            ),
        },
    ];

    const [tableColumns, setTableColumns] = useState(columns)
    const [dataSource, setDataSource] = useState([])

    useEffect(() => {
        const dataSource = TraderListData
        setDataSource(dataSource)
    }, []);

    return (
        <Table
        dataSource={ props.traders }
        columns={tableColumns}
        pagination={false}
        />
    );
}

export default TraderList