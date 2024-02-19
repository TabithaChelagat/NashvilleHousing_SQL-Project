**PROJECT SUMMARY**

As a data analyst at Nashville Real Estate Company, I was tasked with cleaning and preparing data using SQL to enhance the accuracy and reliability of our analytical processes. 
The project involved the following key steps:

*Data Assessment*: I conducted a thorough assessment of the existing datasets to identify inconsistencies, missing values, and anomalies that could impact data integrity.

*Data Cleaning*: Utilizing SQL, I implemented cleaning procedures to address identified issues such as standardizing formats, removing duplicates, filling in missing values, and correcting errors.

*Normalization*: I ensured that the data was normalized to eliminate redundancy and improve efficiency in storage and processing.

*Documentation*: Throughout the process, I maintained detailed documentation of the cleaning procedures applied, ensuring transparency and reproducibility.


**DATA CLEANING: From Chaos to Clarity**

Before diving into the analysis, I cleaned and formatted the raw data using SQL. This involved standardizing date formats, populating missing property addresses, and splitting address components into separate columns for better granularity. Additionally, I transformed “Y” and “N” values into “Yes” and “No” for readability. Through these data-cleaning steps, I ensured the accuracy and consistency of my dataset for meaningful analysis.


**DATA SOURCE**

Link to data source: https://github.com/AlexTheAnalyst/PortfolioProjects/blob/main/Nashville%20Housing%20Data%20for%20Data%20Cleaning.xlsx.


**DATA EXPLORATION**

***Exploratory Data Analysis (EDA) Queries:***
My EDA journey begins with extracting the refined Nashville Housing data using SQL queries. Here are the columns present in the Nashville Housing dataset along with their descriptions:


| Column Name      | Description                                                              |
|------------------|--------------------------------------------------------------------------|
| UniqueID         | A unique identifier for each record.                                     |
| ParcelID         | Identification number for the parcel of land.                            |
| LandUse          | The designated use of the land.
| PropertyAddress  | The address of the property.                                             |
| SaleDate         | The date when the property was sold.                                     |
| SalePrice        | The price at which the property was sold.                                |
| LegalReference   | Legal reference associated with the property sale.                        |
| SoldAsVacant     | Indicator of whether the property was sold as vacant (yes/no).           |
| OwnerName        | Name of the property owner.                                              |
| OwnerAddress     | Address of the property owner.                                           |
| Acreage          | The size of the land in acres.                                           |
| TaxDistrict      | Tax district associated with the property.                                |
| LandValue        | Value of the land.                                                       |
| BuildingValue    | Value of the building on the property.                                    |
| TotalValue       | Total assessed value of the property.                                    |
| YearBuilt        | The year the building was constructed.                                   |
| Bedrooms         | Number of bedrooms in the property.                                      |
| FullBath         | Number of full bathrooms in the property.                                 |
| HalfBath         | Number of half bathrooms in the property.                                 |


There are a total of 19 columns in the Nashville Housing dataset.


***Analyzing Rows***

Using the Unique ID as my primary key, I am going to check the total data that I will be working with.

```
Select COUNT([UniqueID ]) AS TotalData
From ['NashvilleHousing']
 ```
| TotalData |
|-----------|
|   56477   |

This table represents the total number of records (56,477) in the dataset.


***Checking for NULLS***

```
Select COUNT(*)-COUNT([UniqueID ]) as UniqueID, 
COUNT(*)-COUNT(ParcelID) as ParcelID,
COUNT(*)-COUNT(LandUse) as LandUse,
COUNT(*)-COUNT(PropertyAddress) as PropertyAddress,
COUNT(*)-COUNT(SaleDate) as SaleDate,
COUNT(*)-COUNT(SalePrice) as SalePrice,
COUNT(*)-COUNT(LegalReference) as LegalReference,
COUNT(*)-COUNT(SoldAsVacant) as SoldAsVacant,
COUNT(*)-COUNT(OwnerName) as OwnerName,
COUNT(*)-COUNT(OwnerAddress) as OwnerAddress,
COUNT(*)-COUNT(TaxDistrict) as TaxDistrict,
COUNT(*)-COUNT(LandValue) as LandValue,
COUNT(*)-COUNT(BuildingValue) as BuildingValue,
COUNT(*)-COUNT(TotalValue) as TotalValue,
COUNT(*)-COUNT(YearBuilt) as YearBuilt,
COUNT(*)-COUNT(Bedrooms) as Bedrooms,
COUNT(*)-COUNT(FullBath) as FullBath,
COUNT(*)-COUNT(HalfBath) as HalfBath
From ['NashvilleHousing']
```

The following table represents the count of null values for each column in my dataset:

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


***Duplicates in Dataset***

```
Select COUNT([UniqueID ])-COUNT(DISTINCT [UniqueID ]) as Duplicates
From ['NashvilleHousing']
```

The following table represents the count of duplicates found in the dataset using the UniqueID column:

| Duplicates Count |
|------------------|
|        0         |



**DATA TRANSFORMATION** 

***Date extraction***

The SaleDate data was originally stored in a DateTime format, including both date and time information. However, I will only require the date part for analysis. To achieve this, I used the CONVERT function to extract only the date part of the SaleDate data, resulting in the SaleDateConverted column with date values.

```
Select SaleDate, CONVERT(Date, SaleDate) as SaleDateConverted
From ['NashvilleHousing']
Order by SaleDate
```

The following table represents the original SaleDate data along with the transformed SaleDateConverted data:

|   SaleDate (Original)       | SaleDateConverted (Transformed) |
|-----------------------------|----------------------------------|
| 2013-01-02 00:00:00.000     | 2013-01-02                       |
| 2013-01-02 00:00:00.000     | 2013-01-02                       |
| 2013-01-02 00:00:00.000     | 2013-01-02                       |
| 2013-01-02 00:00:00.000     | 2013-01-02                       |
| 2013-01-02 00:00:00.000     | 2013-01-02                       |

After converting the SaleDate, the table was altered and updated by adding the SaleDateConverted column to the dataset.

```
ALTER TABLE [dbo].['NashvilleHousing']
Add SaleDateConverted Date;

UPDATE ['NashvilleHousing']
SET SaleDateConverted = CONVERT(Date, SaleDate)
```

***Populating the NULLS in the PropertyAddress column***

From the data, I observed 35 rows with missing values in the PropertyAddress column.

```
Select ParcelID, PropertyAddress, UniqueID
From ['NashvilleHousing'] 
Where a.PropertyAddress is null
```

Upon analyzing the data, I noticed that the same property can have different UniqueIDs but the same ParcelID and PropertyAddress. Leveraging this information, I propose populating the PropertyAddress of NULL values based on the following condition:

If two properties have the same ParcelID but different UniqueIDs, then populate the PropertyAddress of one property to the other.

```
Select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress, b.PropertyAddress) 
From ['NashvilleHousing'] a
JOIN ['NashvilleHousing'] b
	On a.ParcelID=b.ParcelID
	and a.[UniqueID ]<>b.[UniqueID ]
Where a.PropertyAddress is null
```

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

This approach ensures consistency in the PropertyAddress data and fills in missing values where possible.


|   ParcelID     |      PropertyAddress       |    PropertyAddress (Filled)   |
|----------------|----------------------------|-------------------------------|
| 025 07 0 031.00 | NULL                       | 410  ROSEHILL CT, GOODLETTSVILLE  |
| 026 01 0 069.00 | NULL                       | 141  TWO MILE PIKE, GOODLETTSVILLE |
| 026 05 0 017.00 | NULL                       | 208  EAST AVE, GOODLETTSVILLE |
| 026 06 0A 038.00 | NULL                      | 109  CANTON CT, GOODLETTSVILLE |
| 033 06 0 041.00 | NULL                      | 1129  CAMPBELL RD, GOODLETTSVILLE |

The NULL values in the PropertyAddress column were filled using the ISNULL function by joining the table to itself. This function allows us to replace NULL values with specified values, in this case, the existing PropertyAddress values were used to fill in the NULL values.

After populating the NULLs with their respective PropertyAddress, the table was altered and updated.

```
UPDATE a
SET PropertyAddress = ISNULL(a.PropertyAddress, b.PropertyAddress) 
From ['NashvilleHousing'] a
JOIN ['NashvilleHousing'] b
	On a.ParcelID=b.ParcelID
	and a.[UniqueID ]<>b.[UniqueID ]
Where a.PropertyAddress is null
```


***Extracting Address from PropertyAddress***

The PropertyAddress table originally contains the full address including the street, city, and potentially other details.

|   PropertyAddress (Original)       |    
|-----------------------------------|
| 1808 FOX CHASE DR, GOODLETTSVILLE |
| 1832 FOX CHASE DR, GOODLETTSVILLE | 
| 1864 FOX CHASE DR, GOODLETTSVILLE | 

To extract only the property address, I used the SUBSTRING function.

```
Select
SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress)-1) as SplitAddress,
SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress)+1, LEN(PropertyAddress)) as SplitCity
From ['NashvilleHousing']
```

This function allows us to retrieve a specified part of a string. In this case, I extracted the property address portion by specifying the start and end positions to capture only the street address part.

|   PropertyAddress (Original)       |    PropertyAddress (Extracted)   |
|-----------------------------------|-----------------------------------|
| 1808 FOX CHASE DR, GOODLETTSVILLE | 1808 FOX CHASE DR                 |
| 1832 FOX CHASE DR, GOODLETTSVILLE | 1832 FOX CHASE DR                 |
| 1864 FOX CHASE DR, GOODLETTSVILLE | 1864 FOX CHASE DR                 |

A new column called SplitAddress was added to our dataset and the table was updated,

```
ALTER TABLE [dbo].['NashvilleHousing']
Add SplitAddress Nvarchar(255);

UPDATE [dbo].['NashvilleHousing']
SET SplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress)-1)
 ```

***Extracting Address and City from OwnerAddress***

Similar to the PropertyAddress column, our OwnerAddress column contains additional details such as the city and state. However, for our analysis, we are only interested in extracting the address and the city.

|   OwnerAddress (Original)            |    OwnerAddress (Extracted)   |
|--------------------------------------|-------------------------------|
| 1802 STEWART PL, NASHVILLE, TN      | 1802 STEWART PL, NASHVILLE   |
| 2761 ROSEDALE PL, NASHVILLE, TN     | 2761 ROSEDALE PL, NASHVILLE  |
| 224 PEACHTREE ST, NASHVILLE, TN     | 224 PEACHTREE ST, NASHVILLE   |
| 316 LUTIE ST, NASHVILLE, TN         | 316 LUTIE ST, NASHVILLE       |


To achieve this, I used the PARSENAME function to extract the address and city portions from the original OwnerAddress values.

```
--OwnerAdres

Select 
PARSENAME(REPLACE(OwnerAddress, ',', '.'), 3) as OwnerAdres
From ['NashvilleHousing']

--OwnerCity

Select 
PARSENAME(REPLACE(OwnerAddress, ',', '.'), 2) as OwnerCity
From ['NashvilleHousing']
```

New two columns, namely, OwnerAdres and OwnerCity were created and added to the data set.

```
--Adding OwnerAdres to our table

ALTER TABLE [dbo].['NashvilleHousing']
Add OwnerAdres nvarchar(255);

UPDATE ['NashvilleHousing']
SET OwnerAdres = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 3)


--Adding OwnerCity to our table

ALTER TABLE [dbo].['NashvilleHousing']
Add OwnerCity nvarchar(255);

UPDATE ['NashvilleHousing']
SET OwnerCity = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 2)
```


***Populating Y with Yes and N with No***

The SoldAsVacant column contains four distinct entries: N, Yes, Y, and No. However, for consistency and clarity, I aim to standardize the values by replacing N with No and Y with Yes.

```
Select
CASE WHEN SoldAsVacant = 'Y' THEN 'YES'
	 WHEN SoldAsVacant = 'N' THEN 'NO'
	 ELSE SoldAsVacant
		END
From ['NashvilleHousing']
```

To achieve this, I used a CASE statement in our SQL query. The CASE statement evaluates each row's SoldAsVacant value and assigns the corresponding transformed value based on the conditions specified. In this case, N is mapped to No, Y and Yes are both mapped to Yes, and No remains unchanged.


|   SoldAsVacant (Original)   |    SoldAsVacant (Transformed)   |
|------------------------------|---------------------------------|
| N                            | No                              |
| Yes                          | Yes                             |
| Y                            | Yes                             |
| No                           | No                              |


The dataset was altered and updated to contain the values of the SoldAsVacant that had been maniulated.

```
UPDATE ['NashvilleHousing']
SET SoldAsVacant = CASE WHEN SoldAsVacant = 'Y' THEN 'YES'
	 WHEN SoldAsVacant = 'N' THEN 'NO'
	 ELSE SoldAsVacant
		END
```


**CONCLUSION**

After completing the data cleaning and transformation process, I have achieved a significantly improved dataset that is well-prepared for analysis and utilization. Several key steps were undertaken to ensure the quality and reliability of the data:

1. ***Data Cleaning:*** I identified and addressed various data inconsistencies, such as missing values, duplicates, and incorrect formats. By employing techniques like using ISNULL, CASE, and PARSENAME functions, I efficiently filled in missing values, standardized entries, and extracted relevant information.

2. ***Normalization:*** The data was normalized to ensure consistency and eliminate redundancy, enabling smoother processing and analysis. Columns such as SoldAsVacant were standardized to maintain uniformity and enhance interpretability.

3. ***Transformation:*** Through the use of functions like SUBSTRING and CASE, I successfully transformed certain columns to meet specific analysis requirements. For example, PropertyAddress and OwnerAddress were parsed to extract only the address and city information, simplifying the dataset's structure.

4. ***Standardization:*** I standardized values where applicable, such as mapping 'N' to 'No' and 'Y'/'Yes' to 'Yes' in the SoldAsVacant column, ensuring uniformity across the dataset.

5. ***Documentation:*** Detailed documentation was maintained throughout the process to provide transparency and facilitate reproducibility. This documentation includes explanations of the techniques used, the rationale behind decisions, and any assumptions made during the cleaning and transformation process.

In conclusion, the data cleaning and transformation process has resulted in a refined dataset that is primed for further analysis and exploration. By addressing inconsistencies, standardizing formats, and extracting relevant information, I have enhanced the dataset's quality and usability, laying a solid foundation for deriving valuable insights and making informed decisions.



































