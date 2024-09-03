# Geolocation API

## Overview

This is a simple Ruby on Rails API that stores and retrieves geolocation data based on IP address or URL. The API uses [ipstack](https://ipstack.com/) as the geolocation service provider, but the implementation is abstracted in a way that allows for easy swapping of the service provider in the future. The API is secured with token-based authentication and follows the JSON API standard.

## Features

- **Store Geolocation Data**: Fetch and store geolocation data using an IP address or URL.
- **Retrieve Geolocation Data**: Retrieve stored geolocation data by ID.
- **Delete Geolocation Data**: Delete stored geolocation data by ID.
- **Token-based Authentication**: All endpoints are secured and require a valid API token.
- **Service Provider Abstraction**: The geolocation service is abstracted for easy swapping of providers.
- **JSON API**: Input and output are handled using JSON.

## Getting Started

### Prerequisites

- [Docker](https://docs.docker.com/get-docker/) and [Docker Compose](https://docs.docker.com/compose/install/)
- [Ruby 3.3.4](https://www.ruby-lang.org/en/downloads/)
- [Rails 8](https://guides.rubyonrails.org/getting_started.html)
- An API key from [ipstack](https://ipstack.com/)

### Installation

1. Clone the repository:

   ```bash
   git clone https://github.com/yourusername/geolocation_api.git
   cd geolocation_api
   ```

2. Create a .env file in the root directory and add your API keys:

```bash
IPSTACK_API_KEY=your_ipstack_api_key
API_TOKEN=your_secure_api_token
```

```

```
