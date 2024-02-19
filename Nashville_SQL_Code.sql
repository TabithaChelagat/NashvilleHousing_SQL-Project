
/*
SKILLS COVERED: Count, Count Distinct, Aliasing, Data Conversion, Altering and Updating a Table, 
			    ISNULL, SUBSTRING, PARSENAME, CASE STATEMENT
*/

Select *
From ['NashvilleHousing']


--Total data

Select COUNT([UniqueID ]) AS TotalData
From ['NashvilleHousing']

--Checking for nulls

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

--Checking for duplicates

Select COUNT([UniqueID ])-COUNT(DISTINCT [UniqueID ]) as Duplicates
From ['NashvilleHousing']


Select *
From ['NashvilleHousing']
Where PropertyAddress is null
Order by ParcelID

--Standardizing date format

Select SaleDate, CONVERT(Date, SaleDate) as SaleDateConverted
From ['NashvilleHousing']
Order by SaleDate

ALTER TABLE [dbo].['NashvilleHousing']
Add SaleDateConverted Date;

UPDATE ['NashvilleHousing']
SET SaleDateConverted = CONVERT(Date, SaleDate)

--Populating Property Address
--PropertyAdress does not change but the Owner bame does

Select *
From ['NashvilleHousing']
Where PropertyAddress is null
Order by ParcelID

--Joining the table to itself 

Select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress, b.PropertyAddress) 
From ['NashvilleHousing'] a
JOIN ['NashvilleHousing'] b
	On a.ParcelID=b.ParcelID
	and a.[UniqueID ]<>b.[UniqueID ]
Where a.PropertyAddress is null

--Updating the values

UPDATE a
SET PropertyAddress = ISNULL(a.PropertyAddress, b.PropertyAddress) 
From ['NashvilleHousing'] a
JOIN ['NashvilleHousing'] b
	On a.ParcelID=b.ParcelID
	and a.[UniqueID ]<>b.[UniqueID ]
Where a.PropertyAddress is null


--Splitting property Address

--SUBSTRING

Select PropertyAddress
From ['NashvilleHousing']

Select
SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress)-1) as SplitAddress,
SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress)+1, LEN(PropertyAddress)) as SplitCity
From ['NashvilleHousing']

ALTER TABLE [dbo].['NashvilleHousing']
Add SplitAddress Nvarchar(255);

UPDATE [dbo].['NashvilleHousing']
SET SplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress)-1)

--Splitting OwnerAddress
--PARSENAME

Select 
PARSENAME(REPLACE(OwnerAddress, ',', '.'), 3) as OwnerAdres
From ['NashvilleHousing']

--OwnerCity

Select 
PARSENAME(REPLACE(OwnerAddress, ',', '.'), 2) 
From ['NashvilleHousing']


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

------------------------------------------------------------
Select *
From ['NashvilleHousing']
------------------------------

--Populating Y and N with Yes and No

Select DISTINCT (SoldAsVacant)
From ['NashvilleHousing']

--CASE STATEMENT

Select
CASE WHEN SoldAsVacant = 'Y' THEN 'YES'
	 WHEN SoldAsVacant = 'N' THEN 'NO'
	 ELSE SoldAsVacant
		END
From ['NashvilleHousing']

--Updating the table

UPDATE ['NashvilleHousing']
SET SoldAsVacant = CASE WHEN SoldAsVacant = 'Y' THEN 'YES'
	 WHEN SoldAsVacant = 'N' THEN 'NO'
	 ELSE SoldAsVacant
		END
