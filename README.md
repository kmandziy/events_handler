# README

# Rails Project Setup with Foreman and RabbitMQ

This guide will help you set up a Rails project with Foreman to manage multiple processes, including a Sidekiq worker and a RabbitMQ subscriber.

## Prerequisites

Ensure you have the following installed:

- Ruby
- Rails
- PostgreSQL or any other database you're using
- RabbitMQ
- Bundler

## Getting Started

### 1. Clone the Repository

```
git clone git@github.com:kmandziy/events_handler.git
```

### 2. Install Dependencies

```
bundle install
gem install foreman
foreman start
```
### 3. Test with swagger

visit http://localhost:3000/api-docs/index.html
