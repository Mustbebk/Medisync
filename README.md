# Hospital Patient Monitoring System - Backend

A real-time patient monitoring backend for hospitals built with Node.js, Express, Socket.io, Supabase, and MongoDB.

## 🏥 Features

- **Real-time Patient Monitoring**: Stream vital signs data every 30 minutes (adjustable)
- **Medical Records Management**: Patients upload, doctors verify
- **Patient Categorization**: Manual criticality classification by doctors
- **Smart Alerts**: Emergency alerts for abnormal vital signs
- **Department-based Notifications**: Alerts routed based on patient procedures
- **Reminder System**: 
  - Reminders for unassigned patients
  - Future checkup reminders
- **Role-based Authorization**: Doctor and Patient roles with specific permissions
- **Secure Authentication**: Supabase Auth with JWT tokens

## 🛠️ Tech Stack

- **Backend Framework**: Node.js with Express.js
- **Real-time Communication**: Socket.io
- **Authentication**: Supabase Auth
- **Relational Database**: PostgreSQL (via Supabase)
- **NoSQL Database**: MongoDB
- **Task Scheduling**: node-cron
- **Email Notifications**: Nodemailer
- **Language**: TypeScript

## 📋 Prerequisites

- Node.js v16+
- npm or yarn
- Supabase account & project
- MongoDB Atlas account or local MongoDB instance
- Git

## 🚀 Setup Instructions

### 1. Clone the Repository
```bash
git clone https://github.com/yourusername/hospital-monitoring-backend.git
cd hospital-monitoring-backend