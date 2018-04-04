# Build
From this directory, run the following:

```
docker build -t wiremock .;
```

# Testrun
To test run the built image from above, run:

```
docker run -p "8080:8080" -v "$(pwd)/mappings:/app/mappings" -v "$(pwd)/__files:/app/__files" wiremock:latest;
```

Visit the page at http://localhost:8080
