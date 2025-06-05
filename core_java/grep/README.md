# Grep App
## Introduction
The Grep App is a command-line Java application that recursively searches through
a given directory's files for lines that match a given regular expression, and writes
the matched lines to the given output file. The application supports two implementations: a traditional approach using `for` loops, and a 
modern lambda/stream-based approach. The project is configured with Maven
for building and managing dependencies, and implements Java Streams and Lambda expressions (in the lambda implementation).
The application is packaged using Docker for easy distribution. Development and testing were completed
using IntelliJ IDEA and `SLF4J` logging.
## Quick Start
1. **Run using Java:**
```
mvn clean install

java -cp target/grep-1.0-SNAPSHOT.jar ca.jrvs.apps.grep.JavaGrepImp 
"your-regex" /path/to/search /path/to/output.txt
```
2. **Run using Docker**
```
docker run --rm \
  -v "$(pwd)"/data:/data \
  -v "$(pwd)"/log:/log \
  your_dockerhub_username/grep ".*Romeo.*Juliet.*" /data /log/grep.out
```
# Implementation

## Pseudocode
`process` method:
```
Create an empty list to store matched lines

For each file in the directory:
    Read all lines from the file
    For each line:
        If the line matches the regex pattern:
            Add the line to the matched lines list

Write all matched lines to the output file
```

## Performance Issue
The traditional implementation of the application that uses `for` loops reads all files into memory
before writing matching lines to the output file. This approach can lead to memory issues - such as `OutOfMemoryError` - 
when dealing with very large files or directories. The lambda-based implementation improves performance
by utilizing Java Streams, which offer lazy evaluation and more efficient memory usage. While the implementation 
still collects matching lines before writing, the use of stream operations significantly reduces
the memory footprint during file traversal and line filtering.
# Test
The app was tested manually:
- Sample datasets  were added to the `data/` directory with matching and non-matching lines
- Tested app with various regex patterns
- Compared output in the `log/grep.out` file with expected results
- Verify the containerized Docker version works identically
# Deployment
The application was containerized using a `Dockerfile`. The image was built locally with:
```
docker build -t your_dockerhub_username/grep
```
It was then pushed to Docker Hub:
```
docker push your_dockerhub_username/grep
```
# Improvement
1. Use JUnit to automate testing
2. Implement a streaming write to improve performance
3. Add support for additional input formats (e.g. JSON, CSV) and output options (e.g. database)