PROJECT SUMMARY: Data Cleaning for Nashville Real Estate Company

As an data analyst at Nashville Real Estate Company, I was tasked with cleaning and preparing data using SQL to enhance the accuracy and reliability of our analytical processes. 
The projec involved the following key steps:

Data Assessment: I conducted a thorough assessment of the existing datasets to identify inconsistencies, missing values, and anomalies that could impact data integrity.

Data Cleaning: Utilizing SQL, I implemented cleaning procedures to address identified issues such as standardizing formats, removing duplicates, filling in missing values, and correcting errors.

Normalization: I ensured that the data was normalized to eliminate redundancy and improve efficiency in storage and processing.

Documentation: Throughout the process, I maintained detailed documentation of the cleaning procedures applied, ensuring transparency and reproducibility.

DATA SOURCE

Link to data source: https://github.com/AlexTheAnalyst/PortfolioProjects/blob/main/Nashville%20Housing%20Data%20for%20Data%20Cleaning.xlsx.

DATA EXPLORATION

Analyzing Columns
Here are the columns present in the Nashville Housing dataset along with their descriptions:

UniqueID: A unique identifier for each record.
ParcelID: Identification number for the parcel of land.
LandUse: The designated use of the land (e.g., residential, commercial, industrial).
PropertyAddress: The address of the property.
SaleDate: The date when the property was sold.
SalePrice: The price at which the property was sold.
LegalReference: Legal reference associated with the property sale.
SoldAsVacant: Indicator of whether the property was sold as vacant (yes/no).
OwnerName: Name of the property owner.
OwnerAddress: Address of the property owner.
Acreage: The size of the land in acres.
TaxDistrict: Tax district associated with the property.
LandValue: Value of the land.
BuildingValue: Value of the building on the property.
TotalValue: Total assessed value of the property.
YearBuilt: The year the building was constructed.
Bedrooms: Number of bedrooms in the property.
FullBath: Number of full bathrooms in the property.
HalfBath: Number of half bathrooms in the property.
SaleDateConverted: Sale date converted into a standardized format.
SplitAddress: Breakdown of the property address.
OwnerAdres: Address of the property owner.
OwnerCity: City of the property owner.

There are a total of 23 columns in the Nashville Housing dataset.

Analyzing Rows
Using the Unique ID as our primary key, we are going to check the total data that we will be working with.

| TotalData |
|-----------|
|   56477   |

This table represents the total number of records (56,477) that we will be working on within our analysis.

Checking for NULLS

The following table represents the count of null values for each column in our dataset:

| Column Name     | Null Count |
|-----------------|------------|
| UniqueID        | 0          |
| ParcelID        | 0          |
| LandUse         | 0          |
| PropertyAddress | 0          |
| SaleDate        | 0          |
| SalePrice       | 0          |
| LegalReference  | 0          |
| SoldAsVacant    | 0          |
| OwnerName       | 31216      |
| OwnerAddress    | 30462      |
| TaxDistrict     | 30462      |
| LandValue       | 30462      |
| BuildingValue   | 30462      |
| TotalValue      | 30462      |
| YearBuilt       | 32314      |
| Bedrooms        | 32320      |
| FullBath        | 32202      |
| HalfBath        | 32333      |

Duplicates in Dataset

The following table represents the count of duplicates found in the dataset using the UniqueID column:

| Duplicates Count |
|------------------|
|        0         |



DATA TRANSFORMATION: 
SaleDateConverted

The following table represents the original SaleDate data along with the transformed SaleDateConverted data:

|   SaleDate (Original)       | SaleDateConverted (Transformed) |
|-----------------------------|----------------------------------|
| 2013-01-02 00:00:00.000     | 2013-01-02                       |
| 2013-01-02 00:00:00.000     | 2013-01-02                       |
| 2013-01-02 00:00:00.000     | 2013-01-02                       |
| 2013-01-02 00:00:00.000     | 2013-01-02                       |
| 2013-01-02 00:00:00.000     | 2013-01-02                       |

Explanation:

The SaleDate data was originally stored as a datetime format, including both date and time information. However, we only required the date part for analysis.
To achieve this, we used the CONVERT function to extract only the date part of the SaleDate data, resulting in the SaleDateConverted column with date values.


Missing PropertyAddress Data Analysis and Solution

The following table represents the missing PropertyAddress data along with the proposed solution:

### ParcelID and PropertyAddress Data

The following table displays the ParcelID and corresponding PropertyAddress data:

|   ParcelID     |      PropertyAddress       |
|----------------|----------------------------|
| 025 07 0 031.00 | NULL                       |
| 026 01 0 069.00 | NULL                       |
| 026 05 0 017.00 | NULL                       |
| 026 06 0A 038.00 | NULL                       |
| 033 06 0 041.00 | NULL                       |
| 025 07 0 031.00 | 410  ROSEHILL CT, GOODLETTSVILLE |
| 026 01 0 069.00 | 141  TWO MILE PIKE, GOODLETTSVILLE |
| 026 05 0 017.00 | 208  EAST AVE, GOODLETTSVILLE |
| 026 06 0A 038.00 | 109  CANTON CT, GOODLETTSVILLE |
| 033 06 0 041.00 | 1129  CAMPBELL RD, GOODLETTSVILLE |

Analysis:

From our data, we observed 35 rows with missing values in the PropertyAddress column.

Proposed Solution:

Upon analyzing the data, we noticed that the same property can have different UniqueIDs but the same ParcelID and PropertyAddress. Leveraging this information, we propose 
populating the PropertyAddress of NULL values based on the following condition:

If two properties have the same ParcelID but different UniqueIDs, then populate the PropertyAddress of one property to the other.

This approach ensures consistency in the PropertyAddress data and fills in missing values where possible.

|   ParcelID     |      PropertyAddress       |    PropertyAddress (Filled)   |
|----------------|----------------------------|-------------------------------|
| 025 07 0 031.00 | NULL                       | 410  ROSEHILL CT, GOODLETTSVILLE  |
| 026 01 0 069.00 | NULL                       | 141  TWO MILE PIKE, GOODLETTSVILLE |
| 026 05 0 017.00 | NULL                       | 208  EAST AVE, GOODLETTSVILLE |
| 026 06 0A 038.00 | NULL                      | 109  CANTON CT, GOODLETTSVILLE |
| 033 06 0 041.00 | NULL                      | 1129  CAMPBELL RD, GOODLETTSVILLE |

The NULL values in the PropertyAddress column were filled using the ISNULL function. This function allows us to replace NULL values with specified values, in this case, 
the existing PropertyAddress values were used to fill in the NULL values.

Extracting Address from PropertyAddress:

|   PropertyAddress (Original)       |    
|-----------------------------------|
| 1808 FOX CHASE DR, GOODLETTSVILLE |
| 1832 FOX CHASE DR, GOODLETTSVILLE | 
| 1864 FOX CHASE DR, GOODLETTSVILLE | 

The PropertyAddress table originally contains the full address including the street, city, and potentially other details. To extract only the property address, 
we used the SUBSTRING function. This function allows us to retrieve a specified part of a string. In this case, we extracted the property address portion by specifying 
the start and end positions to capture only the street address part.

|   PropertyAddress (Original)       |    PropertyAddress (Extracted)   |
|-----------------------------------|-----------------------------------|
| 1808 FOX CHASE DR, GOODLETTSVILLE | 1808 FOX CHASE DR                 |
| 1832 FOX CHASE DR, GOODLETTSVILLE | 1832 FOX CHASE DR                 |
| 1864 FOX CHASE DR, GOODLETTSVILLE | 1864 FOX CHASE DR                 |





