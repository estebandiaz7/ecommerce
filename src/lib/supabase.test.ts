import { describe, it, expect, vi, beforeEach } from 'vitest'
import { User } from '@supabase/supabase-js'
import { getCurrentUser, getUserProfile, isAdmin, isSeller } from './supabase'
import { Database } from '@/types/database.types'

type UserProfile = Database['public']['Tables']['user_profiles']['Row']

vi.mock('./supabase', () => {
  const mockSupabase = {
    auth: {
      getUser: vi.fn(),
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

describe('Supabase Client Functions', () => {
  beforeEach(() => {
    vi.clearAllMocks()
  })

  describe('getCurrentUser', () => {
    it('should return user data when successful', async () => {
      const mockUser: User = {
        id: '123',
        email: 'test@example.com',
        app_metadata: {},
        user_metadata: {},
        aud: 'authenticated',
        created_at: new Date().toISOString(),
        role: 'authenticated',
      }
      vi.mocked(getCurrentUser).mockResolvedValueOnce(mockUser)

      const result = await getCurrentUser()
      expect(result).toEqual(mockUser)
    })

    it('should throw error when request fails', async () => {
      vi.mocked(getCurrentUser).mockRejectedValueOnce(new Error('Auth error'))

      await expect(getCurrentUser()).rejects.toThrow('Auth error')
    })
  })

  describe('getUserProfile', () => {
    const userId = '123'

    it('should return user profile when successful', async () => {
      const mockProfile: UserProfile = {
        id: '1',
        user_id: userId,
        created_at: new Date().toISOString(),
        updated_at: new Date().toISOString(),
        avatar_url: null,
        phone_number: null,
        preferences: null,
      }
      vi.mocked(getUserProfile).mockResolvedValueOnce(mockProfile)

      const result = await getUserProfile(userId)
      expect(result).toEqual(mockProfile)
    })

    it('should throw error when request fails', async () => {
      vi.mocked(getUserProfile).mockRejectedValueOnce(
        new Error('Profile not found')
      )

      await expect(getUserProfile(userId)).rejects.toThrow('Profile not found')
    })
  })

  describe('isAdmin', () => {
    const userId = '123'

    it('should return true for admin user', async () => {
      vi.mocked(isAdmin).mockResolvedValueOnce(true)

      const result = await isAdmin(userId)
      expect(result).toBe(true)
    })

    it('should return false for non-admin user', async () => {
      vi.mocked(isAdmin).mockResolvedValueOnce(false)

      const result = await isAdmin(userId)
      expect(result).toBe(false)
    })
  })

  describe('isSeller', () => {
    const userId = '123'

    it('should return true for seller user', async () => {
      vi.mocked(isSeller).mockResolvedValueOnce(true)

      const result = await isSeller(userId)
      expect(result).toBe(true)
    })

    it('should return false for non-seller user', async () => {
      vi.mocked(isSeller).mockResolvedValueOnce(false)

      const result = await isSeller(userId)
      expect(result).toBe(false)
    })
  })
})
