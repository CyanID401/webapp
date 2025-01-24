'use client'

import { useState, useEffect } from 'react'

interface User {
  id: number;
  username: string;
}

export default function UserList() {
  const [users, setUsers] = useState<any>([])
  const [loading, setLoading] = useState<boolean>(true)

  const getUsers = async () => {
    const resp = await fetch(`/api/user`)

    if (resp) {
      const json = await resp.json();
      const { message } = json
      if (resp.status == 200) {
          console.log(message)
          setUsers(json.data)
          setLoading(false)
          return resp
      }
      else  {
        console.log('error:', message)
        setLoading(false)
        return resp
      }
    }
  }

  useEffect(() =>  {
      getUsers()
  }, [])

  return (
    <div>
      <h1>User List</h1>
      <div>
        {loading ?
          <div>...</div> :
          <ul>
            {users.map((user: User) => (
              <li key={user.id}>{user.username}</li>
            ))}
          </ul>
        }
        <div>This change was delivered with CI/CD.</div>
      </div>
    </div>
  );
}
