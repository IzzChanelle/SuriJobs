# SuriJobs

A full-stack job platform for Suriname — connecting employers, job seekers, and service providers. Users can post vacancies, browse the marketplace, offer services, and chat in real time.

---

## Project Description

SuriJobs is a bilingual (Dutch/English) web application built for the Surinamese job market. It supports three user roles:

- **Employer** — post and manage job vacancies, review applicants
- **Service Provider** — list freelance services
- **Job Seeker / Buyer** — browse vacancies, save listings, buy marketplace products, and chat

---

## Technologies

| Layer | Stack |
|-------|-------|
| Frontend | HTML, CSS, Vanilla JavaScript |
| Backend | Node.js, Express.js |
| Database | MySQL |
| Auth | JWT (JSON Web Tokens), Google OAuth 2.0 |
| Email | Nodemailer (SMTP) |
| File uploads | Multer |

---

## Requirements

- Node.js v18 or higher
- MySQL 8.0 or higher
- npm v9 or higher
- A Google OAuth Client ID (for Google login)
- An SMTP email account (for password reset emails)

---

## Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/your-username/surijobs.git
   cd surijobs
   ```

2. **Install backend dependencies**
   ```bash
   npm install
   ```

3. **Set up environment variables**
   ```bash
   cp .env.example .env
   ```
   Then open `.env` and fill in your database credentials, JWT secret, Google Client ID, and SMTP settings.

---

## Database Setup

1. **Create the database**
   ```bash
   mysql -u root -p -e "CREATE DATABASE surijobs CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"
   ```

2. **Run the schema** (creates all tables)
   ```bash
   mysql -u root -p surijobs < sql/schema.sql
   ```

3. **Run the seed data** (inserts sample users, jobs, and listings)
   ```bash
   mysql -u root -p surijobs < sql/seed.sql
   ```

---

## Usage

1. **Start the backend server**
   ```bash
   npm start
   ```
   The API will be available at `http://localhost:3001/api`

2. **Open the frontend**

   Open `index.html` in a browser via a local server (e.g. VS Code Live Server on port 5500), or serve the frontend folder:
   ```bash
   npx serve . -p 5500
   ```

3. **Default seed accounts**

   | Email | Password | Role |
   |-------|----------|------|
   | employer@surijobs.com | password123 | Employer |
   | jobseeker@surijobs.com | password123 | Job Seeker |
   | admin@surijobs.com | password123 | Admin |

---

## API Endpoints Overview

| Method | Path | Description |
|--------|------|-------------|
| POST | `/api/auth/register` | Register a new user |
| POST | `/api/auth/login` | Login and receive JWT |
| POST | `/api/auth/google` | Google OAuth login |
| POST | `/api/auth/forgot-password` | Send password reset email |
| POST | `/api/auth/reset-password` | Reset password with token |
| GET | `/api/jobs` | List all job vacancies |
| POST | `/api/jobs` | Create a vacancy (employer only) |
| POST | `/api/jobs/:id/apply` | Apply for a job |
| GET | `/api/market` | List marketplace products |
| POST | `/api/market` | Post a product |
| GET | `/api/services` | List services |
| POST | `/api/services` | Post a service |
| GET | `/api/messages/conversations` | Get chat conversations |
| GET | `/api/notifications` | Get notifications |
| GET | `/api/profile` | Get current user profile |
| PUT | `/api/profile` | Update profile |
