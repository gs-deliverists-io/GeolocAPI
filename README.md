# Geolocation API

## Overview

This is a simple Ruby on Rails API that stores and retrieves geolocation data based on IP address or URL. The API uses [ipstack](https://ipstack.com/) as the geolocation service provider, but the implementation is abstracted in a way that allows for easy swapping of the service provider in the future. The API is secured with token-based authentication and follows the JSON API standard.
