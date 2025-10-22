CREATE DATABASE IF NOT EXISTS agency_db;
USE agency_db;

CREATE TABLE personnel (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(150) NOT NULL,
  role_title VARCHAR(150),
  experience_level ENUM('Junior','Mid','Senior') NOT NULL DEFAULT 'Junior',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE skills (
  id INT AUTO_INCREMENT PRIMARY KEY,
  category VARCHAR(100),
  name VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE person_skills (
  id INT AUTO_INCREMENT PRIMARY KEY,
  personnel_id INT NOT NULL,
  skill_id INT NOT NULL,
  proficiency TINYINT NOT NULL,
  FOREIGN KEY (personnel_id) REFERENCES personnel(id) ON DELETE CASCADE,
  FOREIGN KEY (skill_id) REFERENCES skills(id) ON DELETE CASCADE,
  UNIQUE (personnel_id, skill_id)
);

CREATE TABLE projects (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(200) NOT NULL,
  description TEXT,
  start_date DATE,
  end_date DATE,
  status ENUM('Planning','Active','Completed') DEFAULT 'Planning',
  team_capacity INT DEFAULT 1,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE project_requirements (
  id INT AUTO_INCREMENT PRIMARY KEY,
  project_id INT NOT NULL,
  skill_id INT NOT NULL,
  required_proficiency TINYINT NOT NULL,
  FOREIGN KEY (project_id) REFERENCES projects(id) ON DELETE CASCADE,
  FOREIGN KEY (skill_id) REFERENCES skills(id) ON DELETE CASCADE,
  UNIQUE (project_id, skill_id)
);

CREATE TABLE allocations (
  id INT AUTO_INCREMENT PRIMARY KEY,
  project_id INT NOT NULL,
  personnel_id INT NOT NULL,
  alloc_start DATE NOT NULL,
  alloc_end DATE NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (project_id) REFERENCES projects(id) ON DELETE CASCADE,
  FOREIGN KEY (personnel_id) REFERENCES personnel(id) ON DELETE CASCADE
);

-- seed skills
INSERT INTO skills (category,name) VALUES
  ('Language','Python'),('Language','JavaScript'),('Frontend','React'),('Backend','Node.js'),
  ('DB','MySQL'),('Cloud','AWS'),('Tool','Docker');

-- seed personnel
INSERT INTO personnel (name, role_title, experience_level) VALUES
  ('Asha Perera','Full Stack Developer','Mid'),
  ('Kamal Silva','Backend Developer','Senior'),
  ('Maya Fernando','Frontend Developer','Junior');

-- assign skills
INSERT INTO person_skills (personnel_id, skill_id, proficiency) VALUES
  (1,1,4),(1,3,4),(1,5,3),(2,1,3),(2,4,5),(2,5,4),(2,7,4),(3,3,3),(3,2,3);

-- seed a project
INSERT INTO projects (name,description,start_date,end_date,status,team_capacity)
 VALUES ('Website Redesign','Rebuild client website', '2025-11-01','2025-12-15','Planning',2);

-- project requirements (React 3+, Node.js 3+)
INSERT INTO project_requirements (project_id, skill_id, required_proficiency) VALUES
  (1,3,3),(1,4,3);
 
