# plsql

A Docker-based project for experimenting with **Oracle PL/SQL** functions, procedures, and queries.  
The setup uses **Colima** on macOS to run Oracle Database in a container, allowing you to write and test PL/SQL scripts easily.

---

## 🚀 Features
- Oracle XE running inside Docker
- `init/` folder for schema and table creation scripts
- `scripts/` folder for PL/SQL functions, procedures, and queries
- Ready-to-use SQL*Plus client container for executing queries
- Mac support using **Colima**

---

## 🛠️ Prerequisites
- [Docker](https://docs.docker.com/get-docker/)
- [Colima](https://github.com/abiosoft/colima) (for macOS users)

Start Colima before using Docker:
```bash
colima start --arch x86_64
```

## 📂 Project Structure
plsql/
│── docker-compose.yml      # Defines Oracle DB and SQL*Plus client services
│── init/                   # Auto-executed scripts during DB startup
│   ├── 01-schema.sql       # Creates schema and user
│   ├── 01-surveylog.sql    # Creates table and inserts sample data
│── scripts/                # Custom PL/SQL functions, procedures, queries
│   ├── get_survey_result_fn.sql
