# Functional Specification

This system allows the management of Proponentes (candidates) and their details, with functionalities for CRUD operations, INSS discount calculation, and generating reports.

<img width="1175" alt="image" src="https://github.com/user-attachments/assets/936c592b-b0b2-4ee5-bbd3-e6518710bf0b">
<img width="1175" alt="image" src="https://github.com/user-attachments/assets/95028f2b-16de-48ca-8f3a-5da29bc58ad5">
<img width="1175" alt="image" src="https://github.com/user-attachments/assets/a5fbcab5-98bb-4a2e-9771-34978f9eae1d">


This application requires Docker to be installed and running. To start the PostgreSQL database and Adminer, run the following command in the project's root directory:

```bash
docker-compose up -d
```

To access the Adminer interface for the PostgreSQL database, open your web browser and navigate to `http://localhost:8080`. Use the following credentials:

* **System:** PostgreSQL
* **User:** root
* **Password:** root
* **Server:** db
* **Database:** desconto_inss_development


To start the application, follow these steps:

1. **Install dependencies:**
   ```bash
   bundle install
   ```

2. **Create the database:**
   ```bash
   rails db:create
   ```

3. **Run migrations:**
   ```bash
   rails db:migrate
   ```

4. **Seed the database:**
   ```bash
   rails db:seed
   ```

5. **Start the server:**
   ```bash
   rails s
   ```

Now you can access the application in your web browser at `http://localhost:3000`.


## Running Sidekiq and Redis

To start the Sidekiq worker and Redis server, run the following commands in separate terminal windows:

```bash
redis-server
```

```bash
bundle exec sidekiq -C config/sidekiq.yml
```

```bash
bundle exec rspec
```

To run the tests, execute the command above in your terminal. This will run all the tests defined in your project, ensuring the codebase is functioning as expected.

