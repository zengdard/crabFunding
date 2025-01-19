
#!/bin/bash
docker-compose -f docker-compose.flutter.yml down -v
docker-compose -f docker-compose.flutter.yml up --build