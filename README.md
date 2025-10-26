# About

This repository is a template to write SQL code, and *deploy* it to a PostgreSQL database instance.

It does not feature any complex migration logic though, and if needed for your project, you should consider using
tools for this.

# PostgreSQL Template

A template project for managing PostgreSQL database schemas.

## Table of Contents
- [Prerequisites](#prerequisites)
- [Getting Started](#getting-started)
  - [Windows (WSL) Setup](#windows-wsl-setup)
  - [Linux/Mac Setup](#linuxmac-setup)
- [VS Code Setup](#vs-code-setup)
- [Project Structure](#project-structure)
- [Usage](#usage)
- [Best Practices](#best-practices)
- [Adding New SQL Files](#adding-new-sql-files)

## Prerequisites

### For Windows Users (WSL)

This is assuming a Linux system. For windows, you can use WSL to make it work.

1. **Install WSL 2**
   - Open PowerShell as Administrator and run:
     ```powershell
     wsl --install
     ```
   - Restart your computer
   - Set up your Ubuntu username and password when prompted

### For Linux

1. **Install Docker**
   - Linux: Follow instructions at [https://docs.docker.com/engine/install/](https://docs.docker.com/engine/install/)

## Getting Started

1. **Install PostgreSQL Client Tools**
   ```bash
   sudo apt update
   sudo apt install -y postgresql-client
   ```

2. **Start the PostgreSQL database**
   ```bash
   docker compose up -d
   ```

3. **Run your first deployment**
   ```bash
   ./build.sh
   ```

## Troubleshooting

1. **Verify the database is running**
   ```bash
   docker compose ps
   psql postgresql://postgres:postgres@localhost:5432/devdb -c "SELECT version();"
   ```