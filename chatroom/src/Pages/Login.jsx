import React, { useState } from 'react'

function Login({ setUser }) {
    const [username, setUsername] = useState('')
    const [password, setPassword] = useState('')
    
    const loginUser = (e) => {
        e.preventDefault()
        console.log('START');

        fetch('http://127.0.0.1:3000/login', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({
                    username: username.toLowerCase().replace(/\s/g, ''),
                    password: password.toLowerCase().replace(/\s/g, '')
            })
        }).then(response =>{
            if (response.ok) {
                 return response.json()
            }else{
                console.log(response.error);
                return
            }
        })
            .then(result => {
                console.log('RES',result);
                
                localStorage.setItem('jwt_token', result.token)
                localStorage.setItem("user_id", result.user.id);
                setUser(result.user)
            })
    }

    return (
        <div className="container">
            <div
                className="row justify-content-center align-items-center g-2"
            >
                <div className="col-6">
                    <form className='form' onSubmit={loginUser}>

                        <div className="mb-3">
                            <label for="" className="form-label">Name</label>
                            <input type="text" className="form-control" placeholder="username" value={username} onChange={(e) => setUsername(e.target.value)} />
                        </div>

                        <div className="mb-3">
                            <label for="" className="form-label">Password</label>
                            <input type="password" className="form-control" placeholder="password" value={password} onChange={(e) => setPassword(e.target.value)} />
                        </div>
                        <button type="submit" className="btn btn-primary" > Button </button>
                    </form>
                </div>
            </div>

        </div>

    )
}

export default Login
