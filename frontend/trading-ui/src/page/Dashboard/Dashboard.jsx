import React, { useEffect, useState } from 'react';
import './Dashboard.scss';
import NavBar from '../../component/NavBar/NavBar';
import TraderList from '../../component/TraderList/TraderList';
import TraderListData from '../../component/TraderList/TraderListData.json';
import { Input, DatePicker, Modal, Button, Form } from 'antd';
import "antd/dist/antd.min.css";

function Dashboard(props) {
    // Initializing State
    const [traders, setTraders] = useState([]);
    const [isModalVisible, setIsModalVisible] = useState(false);
    const [form] = Form.useForm();

    //Load initial TraderList
    useEffect(() => {
        setTraders(TraderListData);
    }, []);

    const showModal = () => {
        setIsModalVisible(true);
    };

    const handleCancel = () => {
        setIsModalVisible(false);
        form.resetFields();
    };

    //Create a Trader
    const handleOk = () => {
        form.validateFields().then(values => {
            const newId = traders.length ? Math.max(...traders.map(t => t.id)) + 1 : 1;
            const newTrader = {
                id: newId,
                firstName: values.firstName,
                lastName: values.lastName,
                email: values.email,
                country: values.country,
                dob: values.dob.format('YYYY-MM-DD'),
            };
            setTraders([...traders, newTrader]);
            setIsModalVisible(false);
            form.resetFields();
            console.log('Added trader: ', newTrader);
        }).catch(err => {
            console.error('Validation falsed: ', err);
        });
    };

    //Delete a Trader
    const onTraderDelete = (id) => {
        const updated = traders.filter(t => t.id !== id);
        setTraders(updated);
        console.log(`Trader ${id} deleted.`);
    };

    return (
        <div className="dashboard">
            <NavBar />
            <div className="dashboard-content">
                <div className="title">
                    Dashboard
                    <div className="add-trader-button">
                        <Button type="primary" onClick={showModal}>Add New Trader</Button>
                    </div>
                </div>

                <TraderList traders={traders} onTraderDeleteClick={onTraderDelete} />

                <Modal
                    title="Add New Trader"
                    okText="Submit" 
                    visible={isModalVisible}
                    onOk={handleOk}
                    onCancel={handleCancel}
                >
                    <Form form={form} layout="vertical">
                        <Form.Item label="First Name" name="firstName" rules={[{ required:true }]}>
                            <Input placeholder="John" />
                        </Form.Item>
                        <Form.Item label="Last Name" name="lastName" rules={[{ required:true }]}>
                            <Input placeholder="Smith" />
                        </Form.Item>
                        <Form.Item label="Email" name="email" rules={[{ required:true }]}>
                            <Input placeholder="johnsmith@email.com" />
                        </Form.Item>
                        <Form.Item label="Country" name="country" rules={[{ required:true }]}>
                            <Input placeholder="Country" />
                        </Form.Item>
                        <Form.Item label="Date of Birth" name="dob" rules={[{ required:true }]}>
                            <DatePicker style={{width:"100%"}} placeholder=""></DatePicker>
                        </Form.Item>
                    </Form>
                </Modal>
            </div>
        </div>
    )
}

export default Dashboard;