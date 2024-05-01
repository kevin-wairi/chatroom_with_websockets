import React, { useState, useEffect, useContext } from 'react';
import { CableContext } from '../context/cable'

function Chat({ user, users }) {
  const [messages, setMessages] = useState([]);
  const [newMessage, setNewMessage] = useState('');
  const [recipient_id, setRecipient_id] = useState('');

  const cable = useContext(CableContext)

  useEffect(() => {
    try {
      fetch('http://127.0.0.1:3000/messages') // Update URL accordingly
        .then(resp => {
          if (!resp.ok) {
            console.error('Error fetching messages:', resp.error);
            return;
          }
          return resp.json()

        })
        .then((m) => {
          console.log('M', m);
          setMessages(m);
        })
    } catch (error) {
      console.error('Error fetching messages:', error);
    }
  }, [user]);

  const sendMessage = async (e) => {
    e.preventDefault();

    const token = localStorage.getItem('jwt_token');
    try {
      const response = await fetch('http://127.0.0.1:3000/messages', {
        method: 'POST',
        headers: {
          "Content-Type": "application/json",
          Accept: "application/json",
          Authorization: `Bearer ${token}`,
        },
        body: JSON.stringify({
          content: newMessage,
          user_id: user.id,
          recipient_id: recipient_id
        })
      });

      if (!response.ok) {
        console.log('Error: Message sending failed');
        return;
      }

      const m = await response.json();
      console.log('MESSAGES', m);
      setMessages([...messages, m]);
    } catch (error) {
      console.error('Error sending message:', error);
    }
  };

  useEffect(() => {
    if (user.id) {
      cable.subscriptions.create
        (
          {
            channel: 'ChatsChannel',
            sender_id: user.id,
            recipient_id: recipient_id
          },
          {
            received: (message) => {
              setMessages([...messages, message])
            }
          }
        )
    }
  }, [user, recipient_id, setMessages, messages, cable])


  const logout = () => {
    localStorage.removeItem('jwt_token');
    localStorage.removeItem('user_id');
    window.location.reload();
  }

  return (
    <div className='container'>
      <div
        className="row justify-content-center align-items-center g-2"
      >
        <div className="col-6">
          <div
            className="row justify-content-center align-items-center g-2"
          >
            <div className="col-10"><h1>Chat Application</h1></div>
            <div className="col-2"><button className='btn btn-primary' onClick={logout}>logout</button></div>
            <div className="col-12">
              <p className='fs-2 fw-bold'>{user.username}</p>
            </div>
          </div>


          <div>
            {messages && messages.map(message => (
              <div key={message.id}>
                <p>{message.content}</p>
              </div>
            ))}
          </div>
          <div className="mb-3">
            <label for="" className="form-label fw-bold">Contacts</label>
            <select
              className="form-select"
              onChange={(e) => setRecipient_id(e.target.value)}
            >
              <option selected >Select one</option>
              {users && users.map(us => {
                return <option index={us.id} value={us.id}>{us.username}</option>
              })}
            </select>
          </div>

          <div className="mb-3">
            <input
              type="text" value={newMessage}
              className="form-control"
              onChange={(e) => setNewMessage(e.target.value)}
              placeholder="mesage"
            />
          </div>
          <button className='btn btn-success' onClick={(e) => sendMessage(e)}>Send</button>
        </div>
      </div>

    </div>
  )
}

export default Chat