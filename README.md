# mezen

---

# R Package for Dataset Analysis and Zenodo Integration

## Description

This package provides functions to interact with Zenodo records, analyze datasets, and extract important metadata. It includes the ability to:

- Download community records from Zenodo using a token.
- Extract metadata from Zenodo records and create a structured dataframe.
- Use an LLM (local Ollama LLM) to analyze dataset descriptions and retrieve features, ground truth, and other details.
- Query JSON files generated from Zenodo records and retrieve specific items like Zenodo IDs or dataset titles.

The package integrates several R libraries for text extraction, HTTP requests, and working with JSON data.

## Installation

You can install this package from your local source after building it using `devtools::build()`.

For that download the github repository and store it in some known place. 
Then, if the package is stored as `mezen_0.0.1.000.tar.gz`, install it using the following command:

```r
install.packages("mezen_0.0.1.000.tar.gz", repos = NULL, type = "source")
```
and then call it with 

```r
library(mezen)
```

## Required Packages

The package requires the following R packages:
- `litr`
- `zen4R`
- `tidyverse`
- `jsonlite`
- `RCurl`
- `httr`
- `XML`
- `dplyr`
- `rvest`
- `stringr`
- `rollama`
- `tibble`

## Required Software: 
To be able to run rollama package in R you need to install a distribution of the `ollama` LLM locally on your machine or in the docker. 
Here is the information on how to do this : https://github.com/ollama/ollama?tab=readme-ov-file. 

- '`ollama`

## Functions

### 1. `load_community_records(name)`

This function downloads the necessary records from a Zenodo community based on the provided community name.

**Parameters:**
- `name`: The name of the community (e.g., `"mardigmci"`).

**Returns:**
- A list containing the metadata and Zenodo IDs of the records.

### 2. `create_dataframe()`

This function creates an empty dataframe with predefined columns to store metadata for datasets. The dataframe includes fields like `ZenodoID`, `CollectionName`, `DOI`, `Researchers`, `License`, and others.

**Returns:**
- A dataframe with columns for dataset metadata.

### 3. `read_and_search(description_text)`

This function formats a description text and prepares a set of queries for an LLM to extract specific metadata such as the number of features, ground truth, dataset size, type of graph, and authors from the description.

**Parameters:**
- `description_text`: A string containing the description of the dataset.

**Returns:**
- A set of queries for LLM processing.

### 4. `analyse_records(gmci_records_id)`

This function analyzes the records from Zenodo and extracts various metadata, including dataset title, Zenodo DOI, license, keywords, description, and more. It then queries the LLM to extract additional information and generates a JSON file with the extracted data.

**Parameters:**
- `gmci_records_id`: A vector of Zenodo record IDs.

**Returns:**
- A list of datasets with extracted metadata.

### 5. `show_data(name)`

This function loads a JSON file and prints its content.

**Parameters:**
- `name`: The path to the JSON file to be displayed.

### 6. `question(question_text, json_file = "example.json")`

This function queries an LLM with a specified question based on the content of a provided JSON file.

**Parameters:**
- `question_text`: The question to ask the LLM.
- `json_file`: The path to the JSON file (default is `"example.json"`).

**Returns:**
- A response from the LLM based on the query.

### 7. `download_data(question_text, json_file = "example.json")`

This function downloads a dataset from Zenodo based on a question asking for specific metadata (e.g., a dataset with a specific keyword). The function retrieves the appropriate Zenodo DOI and downloads the dataset.

**Parameters:**
- `question_text`: The question used to identify the dataset.
- `json_file`: The path to the JSON file (default is `"example.json"`).

**Returns:**
- A message confirming that the dataset was successfully downloaded.

### 8. `find_integer_in_text(text)`

This function finds the first integer in a given text string using regular expressions.

**Parameters:**
- `text`: The text where the integer should be searched for.

**Returns:**
- The first integer found in the text or `NULL` if no integer is found.

## Example Usage

### Example 1: Firstly one should load Zenodo Community Records and produce a json file "example.json" with the information stored in the community

```{r}
data = load_community_records("mardigmci")
file = analyse_records(data$records[1:10])
show_data("example.json")
```

### Example 2: Query the Data (ask the )

```{r}
question("What datasets have keywords 'Count data'? Return their titles.")
question("What datasets have more than 10 features? Return their Zenodo IDs.")
question("What datasets have more than 100 views? Return their titles.")
download_data("Pharmacological dataset")
```

### Example 3: Find Integer in Text

```r
find_integer_in_text("The dataset has 250 features and 3000 observations.")
```

## Testing

You can write tests using the `testthat` package to ensure the functions are working as expected. Here is an example of writing a simple test:

```r
test_that("find_integer_in_text works correctly", {
  expect_equal(find_integer_in_text("The dataset has 1000 records."), "1000")
})
```

## Documentation and Building the Package

Once the package code is written and tested, you can generate the documentation, build, and install the package using the following commands:

```r
litr::document()  # Use instead of devtools::document()
devtools::build()  # Build the package
devtools::install()  # Install the package
```