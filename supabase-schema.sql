-- Create patients table
CREATE TABLE patients (
  id UUID PRIMARY KEY,
  email VARCHAR(255) UNIQUE NOT NULL,
  firstName VARCHAR(100),
  lastName VARCHAR(100),
  dateOfBirth DATE,
  medicalHistory TEXT,
  allergies TEXT,
  bloodType VARCHAR(5),
  emergencyContact VARCHAR(255),
  assignedDoctorId UUID,
  criticality VARCHAR(20) DEFAULT 'low' CHECK (criticality IN ('low', 'medium', 'high', 'critical')),
  createdAt TIMESTAMP DEFAULT NOW(),
  updatedAt TIMESTAMP DEFAULT NOW()
);

-- Create doctors table
CREATE TABLE doctors (
  id UUID PRIMARY KEY,
  email VARCHAR(255) UNIQUE NOT NULL,
  specialization VARCHAR(100),
  departmentId UUID NOT NULL,
  licenseNumber VARCHAR(50) UNIQUE,
  role VARCHAR(20) DEFAULT 'doctor',
  createdAt TIMESTAMP DEFAULT NOW(),
  updatedAt TIMESTAMP DEFAULT NOW()
);

-- Create departments table
CREATE TABLE departments (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name VARCHAR(100) NOT NULL,
  code VARCHAR(20) UNIQUE NOT NULL,
  createdAt TIMESTAMP DEFAULT NOW()
);

-- Create patient_doctor_assignments table
CREATE TABLE patient_doctor_assignments (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  patientId UUID NOT NULL REFERENCES patients(id) ON DELETE CASCADE,
  doctorId UUID NOT NULL REFERENCES doctors(id) ON DELETE CASCADE,
  assignedAt TIMESTAMP DEFAULT NOW(),
  UNIQUE(patientId, doctorId)
);

-- Add foreign key constraint for departments
ALTER TABLE doctors
ADD CONSTRAINT fk_doctors_department
FOREIGN KEY (departmentId) REFERENCES departments(id);

-- Create indexes for performance
CREATE INDEX idx_patients_doctorId ON patients(assignedDoctorId);
CREATE INDEX idx_patients_criticality ON patients(criticality);
CREATE INDEX idx_doctors_department ON doctors(departmentId);
CREATE INDEX idx_assignments_patient ON patient_doctor_assignments(patientId);
CREATE INDEX idx_assignments_doctor ON patient_doctor_assignments(doctorId);

-- Enable Row Level Security (RLS)
ALTER TABLE patients ENABLE ROW LEVEL SECURITY;
ALTER TABLE doctors ENABLE ROW LEVEL SECURITY;
ALTER TABLE departments ENABLE ROW LEVEL SECURITY;

-- RLS Policy for patients: Users can see their own data, doctors can see assigned patients
CREATE POLICY "Patients can view own data" ON patients
  FOR SELECT USING (auth.uid() = id);

CREATE POLICY "Doctors can view assigned patients" ON patients
  FOR SELECT USING (
    auth.uid() IN (
      SELECT doctorId FROM patient_doctor_assignments WHERE patientId = patients.id
    )
  );

-- RLS Policy for doctors
CREATE POLICY "Doctors can view own data" ON doctors
  FOR SELECT USING (auth.uid() = id);