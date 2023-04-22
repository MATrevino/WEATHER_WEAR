WEATHER WEAR BACKEND SERVICE

The goal of this project is to create a variety of endpoints for a frontend application that will allow users to plan road trips. The application will allow 

LEARNING GOALS
Expose an API that aggregates data from multiple external APIs
Expose an API that requires an authentication token
Expose an API for CRUD functionality
Determine completion criteria based on the needs of other developers
Test both API consumption and exposure, making use of at least one mocking tool (VCR, Webmock, etc).

Setup
1. Fork and clone this repo
2. Run bundle install
3. Run rails db:{drop,create,migrate,seed}

Environment Variables
This application makes calls to the following APIs:
- MapQuest's Geocoding API
- Weather API (using MapQuest's lat/long)
- Teleport


API Endpoints
1. GET /api/v1/forecast?location=denver,co
2. POST /api/v0/road_trip
3. POST /api/v0/users
4. POST /api/v0/sessions


# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
