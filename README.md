# README

This README would normally document whatever steps are necessary to get the
application up and running.

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

