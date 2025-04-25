import type { Metadata } from 'next'
import './globals.css'

export const metadata: Metadata = {
  title: 'E-commerce with AI',
  description: 'An AI-powered e-commerce platform',
}

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode
}>) {
  return (
    <html lang="en">
      <body className="antialiased">{children}</body>
    </html>
  )
}
