#WEATHER WEAR BACKEND SERVICE

The goal of this project is to create a variety of endpoints for a frontend application that will allow users to plan road trips. The application will allow users to see the forecasted weather at their destination for their estimated time of arrival.

#LEARNING GOALS

*Expose an API that aggregates data from multiple external APIs
*Expose an API that requires an authentication token
*Expose an API for CRUD functionality
*Determine completion criteria based on the needs of other developers
*Test both API consumption and exposure, making use of at least one mocking tool (VCR, Webmock, etc).

**Setup**
1. Fork and clone this repo
2. Run bundle install
3. Run rails db:{drop,create,migrate,seed}

**Environment Variables**
This application makes calls to the following APIs:
- MapQuest's Geocoding API
- Weather API (using MapQuest's lat/long)
- Teleport


API Endpoints
1. GET /api/v1/forecast?location=denver,co
2. POST /api/v1/road_trip
3. POST /api/v1/users
4. POST /api/v1/sessions
5. GET /api/v1/salaries
