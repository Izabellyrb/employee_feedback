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

- Rename the `env_example.txt` file to `.env` 

- Fill in the variables in `.env` with your specific environment values. (Variables for production or test environments are optional and only needed if you plan to use these configurations.)

- Set up the project (dependencies, database and server):
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
Use the following code to import data (container console):
```bash
docker exec -it employee_feedback bash
rails console
ImportService.new('FILE_PATH').run
```
_(There are test files on `spec/fixtures/files/data.csv` (success) and `spec/fixtures/files/blank_data.csv` (fail))_ 

To access a list of all imported content:
```bash
FeedbackResponse.all
```

## API Endpoints
The following endpoints were created to attend the challenge:

### POST /api/v1/feedback_responses
- Import the CSV data into the database. It's required to set the `dataset_file` param and the file path.
<br>

![alt text](image-1.png)

#### Expected Responses Format
- success [200]
```json
{
    "message": "Arquivo recebido com sucesso!"
}
```
- unprocessable_entity [422]
```json
{
    "message": "Erro ao processar - Arquivo contém campos em branco: _____. Processamento cancelado."
}
```

- bad_request [400]
```json
{
    "message": "Insira um arquivo no formato csv."
}
```

- internal_server_error [500]
 ```json
{
    "message": "Erro ao processar - [Error message]."
}
```


### GET /api/v1/feedback_responses
- Retrieve all feedback entries. It's paginated (10 items per page) and you can access other pages on:
``` bash
http://localhost:3000/api/v1/feedback_responses?page=PAGE_NUMBER
```

#### Expected Response Format
```json
{
    "meta": {
        "pagina_atual": 2,
        "prox_pag": null,
        "pag_anterior": null,
        "total_pags": 20,
        "total_items": 200
    },
    "listagem": [
        ...
    ]
}
```


### GET /api/v1/feedback_search/search
- Searches employees feedback data. You can filter by any of the file columns (position (cargo), location (localidate), name (nome), enps, etc). 

``` bash
http://localhost:3000/api/v1/feedback_search/search?gender=outro&location=recife
```

#### Expected Response Format
```json
{
    "meta": {
        "pagina_atual": 1,
        "prox_pag": null,
        "pag_anterior": null,
        "total_pags": 1,
        "total_items": 1
    },
    "listagem": [
        {
            "id": 2,
            "name": "Demo 002",
            "email": "demo002@teste.com.br",
            "corporate_email": "demo002@teste.com.br",
            "location": "recife",
            "company_tenure": "entre 1 e 2 anos",
            "gender": "outro",
            "generation": "geração z",
            "company_level_0": "empresa",
            "directorate_level_1": "diretoria a",
            "management_level_2": "gerência a1",
            "coordination_level_3": "coordenação a11",
            "area_level_4": "área a111",
            "response_date": "2022-01-20",
            "interest_in_position": 1,
            "comments_interest_in_position": "-",
            "contribution": 6,
            "comments_contribution": "Gostaria de liderar iniciativas que agreguem valor.",
            "learning_and_development": 5,
            "comments_learning_and_development": "-",
            "feedback": 3,
            "comments_feedback": "-",
            "interaction_with_manager": 6,
            "comments_interaction_with_manager": "Meu gestor é acessível.",
            "clarity_about_career_opportunities": 2,
            "comments_clarity_about_career_opportunities": "-",
            "expectation_of_permanence": 6,
            "comments_expectation_of_permanence": "-",
            "employee_net_promoter_score": 8,
            "open_comments_enps": "Sinto falta de mais oportunidades.",
            "department_id": 1,
            "position_id": 1,
            "function_id": 1,
            "created_at": "2024-12-19T20:46:13.283-03:00",
            "updated_at": "2024-12-19T20:46:13.283-03:00"
        }
    ]
}
```


### GET /api/v1/feedback_search/structure_stats
- Get statistics by department, position, and function.

``` bash
http://localhost:3000/api/v1/feedback_search/structure_stats
```

#### Expected Response Format
```json
{
    "total": {
        "areas": {
            "financeiro": 2,
            "comercial": 3
        },
        "cargos": {
            "analista": 3,
            "estagiário": 2
        },
        "funcoes": {
            "profissional": 5
        }
    }
}
```

#### Expected Response Format
- Get statistics based on employees location.
``` bash
http://localhost:3000/api/v1/feedback_search/location_stats
```

```json
{
    "localidades": {
        "brasília": 2,
        "recife": 1,
        "são paulo": 1,
        "porto alegre": 1
    }
}
```

## Assumptions and Decisions
- Used the same field names as provided in the challenge instructions to ensure consistency.
- Added validations during import to ensure data integrity.
- To reduce redundancy, improve data normalization and performance, particularly for APIs, the "area", "cargo" and "funcao" columns were changed into dedicated models: Department, Position, and Function. This approach the goal was to demonstrate an understanding of scalable database design and how similar principles can be extended to other attributes as needed.
- Achieved 98.8% coverage with unit tests for models, services, and request tests for API endpoints (verifying responses and integration between components).

