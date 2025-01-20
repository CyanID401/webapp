import { render, screen, waitFor } from '@testing-library/react';
import UserList from './UserList';
import '@testing-library/jest-dom';

// Mock fetch globally and cast it as a Jest mock
global.fetch = jest.fn() as jest.Mock;

describe('UserList Component', () => {
  afterEach(() => {
    jest.clearAllMocks(); // Clear mocks after each test
  });

  test('renders the User List heading', () => {
    render(<UserList />);
    expect(screen.getByText('User List')).toBeInTheDocument();
  });

  test('fetches and displays users successfully', async () => {
    // Mock a successful API response
    (fetch as jest.Mock).mockResolvedValueOnce({
      ok: true,
      status: 200,
      json: async () => ({
        message: 'Success',
        data: [
          { id: 1, username: 'John Doe' },
          { id: 2, username: 'Jane Smith' },
        ],
      }),
    });

    render(<UserList />);

    // Wait for the users to appear
    await waitFor(() => {
      expect(screen.getByText('John Doe')).toBeInTheDocument();
      expect(screen.getByText('Jane Smith')).toBeInTheDocument();
    });

    // Check that fetch was called with the correct URL
    expect(fetch).toHaveBeenCalledWith('http://localhost:3000/api/user');
    expect(fetch).toHaveBeenCalledTimes(1);
  });

  test('handles API errors gracefully', async () => {
    // Mock an API error response
    (fetch as jest.Mock).mockResolvedValueOnce({
      ok: false,
      status: 500,
      json: async () => ({ message: 'Internal Server Error' }),
    });

    render(<UserList />);

    // Wait to ensure no users are displayed
    await waitFor(() => {
      const listItems = screen.queryAllByRole('listitem');
      expect(listItems.length).toBe(0);
    });

    // Check that fetch was called
    expect(fetch).toHaveBeenCalled();
  });

  test('displays a loading state initially', async () => {
    render(<UserList />);

    // Wait for the loading state to appear
    await waitFor(() => expect(screen.getByText('...')).toBeInTheDocument());
  });
});
