
# Ponyhof Job Manager
Job/Gang manager for admins and (gang) bosses.

## Features
**Admin**
- Manage Bosses and Jobs
- Multilanguage

**Boss**
- Hire and Fire employees
- Salary Management
- JobGrad Management
- Promote and Degrade employees/members

**Employees / Members**
- Get On or Off Duty at any job (not for gangs)
- Receive Salary

**UI**
- Extends UI with Job/Gang Name and Grade

## Requirements
- [ghmattimysql](https://github.com/GHMatti/ghmattimysql/releases)
- [VORP-Core](https://github.com/VORPCORE/VORP-Core/releases)
- [VORP-Inputs](https://github.com/VORPCORE/VORP-Inputs/releases)
- [VORP-Character](https://github.com/VORPCORE/VORP-Character/releases)

## How to install
- Download files or clone repository
- Copy and paste ``ponyhof_jobmanager`` folder to resources/
- Import ``jobmanager.sql`` to your database
- Add `ensure ponyhof_jobmanager` to your ``server.cfg`` file
- Edit ``config.lua`` to your needs
- Restart your server