import '@testing-library/jest-dom'
import { beforeEach, vi } from 'vitest'

// Mock the entire Supabase module
vi.mock('@/lib/supabase', () => {
  const mockSupabase = {
    auth: {
      getUser: vi.fn(),
      signIn: vi.fn(),
      signOut: vi.fn(),
    },
    from: vi.fn(),
  }

  return {
    supabase: mockSupabase,
    getCurrentUser: vi.fn(),
    getUserProfile: vi.fn(),
    isAdmin: vi.fn(),
    isSeller: vi.fn(),
  }
})

// Reset all mocks before each test
beforeEach(() => {
  vi.clearAllMocks()
})
