# Technical Challenge - Employee Feedback

## Overview

This project is a flexible solution designed to process and analyze employee feedback data. The application enables structured storage of feedback information, provides insights and exposes a simple REST API for interacting with the dataset.

Key features include:

- Database schema for feedback data analysis.
- Test suite ensuring code reliability and integrity.
- API endpoints for data retrieval, creation, and statistical analysis.
- Containerized environment for straightforward setup and execution.

## Completed Tasks:
- [x] Task 1: Create a Basic Database
- [x] Task 3: Create a Test Suite
- [x] Task 4: Create a Docker Compose Setup
- [x] Task 9: Build a Simple API

## Dataset Overview
The dataset provided (data.csv) includes employee feedback in portuguese, with the following fields:
- nome (Name)
- email
- email_corporativo (Corporate Email)
- area (Department)
- cargo (Position)
- funcao (Function)
- localidade (Location)
- tempo_de_empresa (Company Tenure)
- genero (Gender)
- geracao (Generation)
- n0_empresa (Company Level 0)
- n1_diretoria (Directorate Level 1)
- n2_gerencia (Management Level 2)
- n3_coordenacao (Coordination Level 3)
- n4_area (Area Level 4)
- Data da Resposta (Response Date)
- Interesse no Cargo (Interest in Position)
- Comentários - Interesse no Cargo (Comments - Interest in Position)
- Contribuição (Contribution)
- Comentários - Contribuição (Comments - Contribution)
- Aprendizado e Desenvolvimento (Learning and Development)
- Comentários - Aprendizado e Desenvolvimento (Comments - Learning and Development)
- Feedback
- Comentários - Feedback (Comments - Feedback)
- Interação com Gestor (Interaction with Manager)
- Comentários - Interação com Gestor (Comments - Interaction with Manager)
- Clareza sobre Possibilidades de Carreira (Clarity about Career Opportunities)
- Comentários - Clareza sobre Possibilidades de Carreira (Comments - Clarity about Career Opportunities)
- Expectativa de Permanência (Expectation of Permanence)
- Comentários - Expectativa de Permanência (Comments - Expectation of Permanence)
- eNPS (Employee Net Promoter Score)
- [Aberta] eNPS (Open Comments - eNPS)

The fields and content are in Portuguese, but the english translations were used for the model attributes in the code.


## Getting Started
### Requirements
- Docker: for database setup and run application.
- Postman (optional): For testing API endpoints

### Setup
- Clone the repository:

```bash
git clone git@github.com:Izabellyrb/employee_feedback.git
cd employee_feedback
```

- Install dependencies:

```bash
Copy code
bundle install
```

- Set up the database and server:
```bash
docker compose build
docker compose up
```

##  Running Tests
To run the tests:
```bash
docker exec -it employee_feedback bash
bundle exec rspec
```

## Import CSV data into the database
Use the following code to import data via console:
```bash
ImportService.new('FILE_PATH').run
```

To access a list of all imported content:
```bash
FeedbackResponse.all
```

## API Endpoints
The following endpoints were created to attend the challenge. In swagger you can find the complete document -> Click here.

### POST /api/v1/feedback_responses
- Import the CSV data into the database. It's required to set the `dataset_file` param and the file path. 

### GET /api/v1/feedback_responses
- Retrieve all feedback entries. It's paginated and you can access other pages on:
``` bash
http://localhost:3000/api/v1/feedback_responses?page=PAGE_NUMBER
```
  
### GET /api/v1/feedback_search/search
- Searches employees feedback data. You can filter by any of the file columns (position (cargo), location (localidate), name (nome), enps, etc). 

``` bash
GET http://localhost:3000/api/v1/feedback_search/search?gender=outro&location=recife
```

### GET /api/v1/feedback_search/structure_stats
- Get statistics by department, position, and function.

``` bash
http://localhost:3000/api/v1/feedback_search/structure_stats
```

### GET /api/v1/feedback_search/location_stats
- Get statistics based on employees location.
``` bash
http://localhost:3000/api/v1/feedback_search/location_stats
```

Example query:

``` bash
GET http://localhost:3000/api/v1/feedback_search/search?gender=outro&location=recife
```

## Assumptions and Decisions
- Used the same field names as provided in the challenge instructions to ensure consistency.
- Added validations during import to ensure data integrity.
- Swagger was implemented to document and simplify API testing.
- To reduce redundancy, improve data normalization and performance, particularly for APIs, the "area", "cargo" and "funcao" columns were changed into dedicated models: Department, Position, and Function. This approach the goal was to demonstrate an understanding of scalable database design and how similar principles can be extended to other attributes as needed.
- Achieved 98.8% coverage with unit tests for models, services, and request tests for API endpoints (verifying responses and integration between components).

