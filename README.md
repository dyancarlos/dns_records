# Intricately API Challenge
Simple API for creating and searching DNS records.

### Folders Structure
**Services** folder: Used for DNS creation logic

**Queries** folder: Used for searching the DNS on database  and formatting the params.

**Serializers** folder: User to format the final JSON to the user.

### Setup
Install the dependencies:
```
bundle install
```

This project uses Postgresql, so you will have to set your credentials to the **databse.yml** and then create the database:
```
bundle exec rake db:create
```

After creates the database, you'll need to run the migrations:
```
bundle exec rake db:migrate
```

### Populating the databse
There are seeds available, you can run by:
```
bundle exec rake db:seed
```

Or you can run cURL to test the endpoint, here is an example(don't forget to check the URL):
```
curl --location --request POST 'http://localhost:3000/dns_records' \
--header 'Content-Type: application/json' \
--data-raw '{
  "dns_records": {
    "ip": "9.9.9.9",
    "hostnames_attributes": [
      {
        "hostname": "google.com"
      }
    ]
  }
}'
```

### Endpoints
#### Endpoint #1

**GET** /dns_records

**Params:**

```
page (required): A page number
included (optional): A list of all the hostnames the DNS records should have 
excluded (optional): A list of hostnames the DNS records should not have
```

#### Endpoint #2
**POST** /dns_records

**Body:**

```
{
  "dns_records": {
    "ip": "1.1.1.1",
    "hostnames_attributes": [
      {
        "hostname": "lorem.com"
      }
    ]
  }
}
```

### Specs
To run the specs:
```
bundle exec rspec
```
