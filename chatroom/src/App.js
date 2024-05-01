import { useState, useEffect } from "react";
import { Routes, Route } from 'react-router-dom';
import Chat from "./Pages/Chat";
import Login from "./Pages/Login";

function App({ cable }) {
  const [user, setUser] = useState('')
  const [users, setUsers] = useState([])

  // !persist user logged
  useEffect(() => {
    const token = localStorage.getItem('jwt_token');
    const user_id = localStorage.getItem("user_id");

    if (token && user_id) {
      const id = parseInt(user_id);

      fetch(`http://127.0.0.1:3000/users/${id}`, {
        headers: {
          "Content-Type": "application/json",
          Accepts: "application/json",
          Authorization: `Bearer ${token}`,
        },
      })
        .then((resp) => {
          if (resp.ok) {
            return resp.json();
          } else {
            throw new Error(`Error: ${resp.status}`);
          }
        })
        .then((current_user) => {
          console.log('PERS', current_user);
          setUser(current_user);
        })
        .catch((err) => {
          console.error(err);
        });
    } else {
    }
  }, [])

  useEffect(() => {
    if (user) {
      const token = localStorage.getItem('jwt_token');
      fetch('http://127.0.0.1:3000/users', {
        headers: {
          "Content-Type": "application/json",
          Accepts: "application/json",
          Authorization: `Bearer ${token}`,
        }
      })
        .then(json => json.json())
        .then(users => { 
          const filtered = users.filter(us => us.id !== user.id)
          setUsers(()=>filtered)
           console.log(users) })
    }
  }, [user])


  return (
    <div className="App">
      <Routes>
        {user ?
          <Route path="/" element={<Chat cable={cable} user={user} users={users} />} />
          :
          <Route path="/" element={<Login setUser={setUser}  />} />
        }
      </Routes>
    </div>
  );
}

export default App;
