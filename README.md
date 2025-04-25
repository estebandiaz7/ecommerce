# E-commerce with AI

## Technologies Used

- Next.js 14 with App Router
- TypeScript
- Supabase
- Shadcn UI
- Tailwind CSS
- Vercel AI SDK
- Jest & Testing Library

## Getting Started

1. Clone the repository
2. Install dependencies:
   ```bash
   yarn install
   ```
3. Copy `.env.example` to `.env.local` and fill in the values
4. Run the development server:
   ```bash
   yarn dev
   ```

## Development Workflow

- Branch naming: `feature/`, `bugfix/`, `hotfix/` prefixes
- Commit messages follow [Conventional Commits](https://www.conventionalcommits.org/)
- PRs require passing CI checks and code review

## Testing

- Unit tests: `yarn test`
- Watch mode: `yarn test:watch`

## Deployment

The application is deployed on Vercel with the following environments:

- Production: main branch
- Staging: staging branch
- Preview: PR deployments

## Database Management

- Supabase is used for database and authentication
- Schema changes require migration files
- Auto-generated types in `src/types/database.types.ts`

## Contributing

1. Create a new branch
2. Make your changes
3. Run tests and linting
4. Create a PR
5. Wait for review and CI checks

## License

MIT
