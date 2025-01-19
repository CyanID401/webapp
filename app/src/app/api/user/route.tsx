import { NextResponse } from 'next/server'
import { type NextRequest } from 'next/server'

const API_URL = process.env.API_URL

export async function GET(req: NextRequest) {
  try {
    const resp = await fetch(`${API_URL}/api/user`, {
      method: 'GET',
      headers: {
        'Content-Type': 'application/json'
      },
    })

    const data = await resp.json()

    if (resp.status === 404) {
      return NextResponse.json(
        { message: data.error || 'User not found' },
        { status: 404 }
      )
    }

    if (!resp.ok) {
      return NextResponse.json(
        { message: data.error || 'An error occurred' },
        { status: resp.status }
      )
    }

    return NextResponse.json(
      { message: 'Fetched users successfully', data },
      { status: 200 }
    )
  } catch (error) {
    console.error('Error fetching user:', error)
    return NextResponse.json(
      { message: `Failed to fetch user data: ${error}` },
      { status: 500 }
    )
  }
}