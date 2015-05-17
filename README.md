# Pin
Pin service.

## Setup
Clone current repository and move to directory.

Install:

1. Ruby
2. Gems 'rubygems', 'bundler'
3. Gemfile ```bundle update```
3. Redis

Launch:

1. Start Redis (port: 6379)
2. Start application ```rackup```

## Getting started
*Note: Response format - JSON.*

### Create
```POST '/create', token: $token```

### Check
```POST '/check', token: $token, code: $code```

if code is valid server return the token ```{ token: $token }```, else response will be ```{ errors: ['error_1', 'error_2', ...]  }```. 

## Tests

```bundle exec rake```
