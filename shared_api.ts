// TypeScript interfaces for frontend-backend communication

export interface DemoResponse {
  message: string;
  timestamp: string;
}

export interface PingResponse {
  status: string;
  message: string;
}

export interface User {
  id: string;
  name: string;
  email: string;
  role: 'doctor' | 'patient';
  createdAt: string;
}

export interface Patient {
  id: string;
  userId: string;
  medicalHistory: string[];
  vitals: {
    heartRate: number;
    bloodPressure: string;
    temperature: number;
    lastUpdated: string;
  };
}

export interface Doctor {
  id: string;
  userId: string;
  specialization: string;
  patients: string[];
}

export interface Appointment {
  id: string;
  doctorId: string;
  patientId: string;
  dateTime: string;
  status: 'scheduled' | 'completed' | 'cancelled';
  notes?: string;
}