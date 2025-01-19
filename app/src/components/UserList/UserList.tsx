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
    const PUBLIC_API_URL = process.env.NEXT_PUBLIC_API_URL || 'http://localhost:3000/api'

    const resp = await fetch(`${PUBLIC_API_URL}/user`)

    if (resp) {
      const json = await resp.json();
      const { message } = json
      switch (resp.status) {
        case 200:
          console.log(message)
          setUsers(json.data)
          setLoading(false)
          return resp
        default:
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
      </div>
    </div>
  );
}
