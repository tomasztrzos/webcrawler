# Webcrawler by Tomasz Trzos

## General Information

- Ruby 2.6.5
- Rails 6.0.2
- PostgreSQL 12.2
- Redis 4.0.14

## Installation

**1. Get the code. Clone this git repository:**

```
git clone git@github.com:ThomasTrzos/webcrawler.git
cd webcrawler
```

**2. Download and install Docker on your local machine**

- **windows:** https://docs.docker.com/docker-for-windows/install/
- **mac os:** https://docs.docker.com/docker-for-mac/install/

**3. Run Docker deamon on your local machine**

**4. Build images from docker-compose file**

```
docker-compose build
```

**5. Create development and test database**

```
docker-compose run web rails db:create
```

**6. Run web application, postgres and redis server**

```
docker-compose up
```

**To run rspec (tests):**

### Running the tests

**1. Run all tests using this command**

```
docker-compose run web bundle exec rspec spec
```

## Application Flow

Application is responsible for scanning website (limited to one domain) and returns structured document (JSON) with URLs to other pages under the same domain, link links to external URLs and images URLs. A returned hash is saved to redis-cache for 10 minutes so response for request with the same url is almost immediate. Iteration over internal domains is restricted to 300 to prevent too long running tasks (temporally solution).

_Sample request and response:_

```json
{
  "http://sample.com/": {
    "domain_urls": [],
    "external_urls": ["http://www.ccin.com/"],
    "images_urls": [
      "images/sample.png",
      "http://www.savaii.com/images/ccinlogo1.gif",
      "http://www.savaii.com/images/copylink.gif"
    ]
  }
}
```

## API

|   Endpoint   |         Params          | Method |                                                                        Description                                                                        |
| :----------: | :---------------------: | :----: | :-------------------------------------------------------------------------------------------------------------------------------------------------------: |
|      /       |                         |  GET   |                                                                 root, name of the project                                                                 |
| /api/v1/scan | ?url=https://sample.com |  GET   | request given url, scan website and returns hash with domain_urls, external_urls, images_urls for every found anchor on website (within the start domain) |

## Ideas for future extensions

- add better URLs validation
- send requests asynchronous using Google Cloud Pub/Sub messaging system and Google Cloud Functions
- save connections between urls within the domain and create a [weighted graph](https://mathworld.wolfram.com/WeightedGraph.html)
- generate pdf report
- analyse website
- create frontend app

## Authors

Tomasz Trzos

## License

© 2020 Tomasz Trzos all rights reserved.
