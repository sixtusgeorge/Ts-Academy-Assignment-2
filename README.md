# Assignment 2: Dockerized CLI & Multi-Container Compose Stack

A containerized Linux diagnostic utility packaged with Docker, tested with an automated local test suite, and orchestrated via Docker Compose.

## Project Structure
```text
assignment-2/
├── README.md
├── Dockerfile
├── compose.yaml
├── .dockerignore
├── test.sh
├── grade.sh
└── app/
    ├── diagnostic.sh
    └── health-check.sh
```

## Installation & Setup
Clone the repository and run:
```bash
git clone [https://github.com/StormyAyo/Assignment-2.git](https://github.com/StormyAyo/Assignment-2.git)
cd assignment-2
chmod +x grade.sh test.sh app/*.sh
```

## Local Execution
```bash
./grade.sh
```
