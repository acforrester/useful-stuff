# Useful Census Bureau Data


## Geographic ID's
In `../geo-codes/` I provide a listing of FIPS codes at various geographic levels to merge into various other datasets.


To-Do:
- [ ] Add Census Bureau county FIPS codes.
- [ ] Add Census region and division codes to `geo-codes/state-fips-codes.csv`

### Manifest
| File    | Description |
|-------- | ----------- |
| `../geo-codes/state-fips-codes.csv` | State FIPS identifiers, state names, and USPS codes |
| `../geo-codes/census-to-bea-codes.csv` | Concordance between Census county codes and BEA aggregated counties |

## County Business Patterns
In `../county-business/` I provide a lightly cleaned set of datasets derived from the County Business Patterns (CBP).  The CBP data provide annual, county-level estimates of employment, payrolls, and establishments by industry.  These data are available [here](https://www.census.gov/programs-surveys/cbp/about.html).  CBP data are derived from the Census Bureau's Business Register, which contains a listing of "all known single- and multi-establishment employer companies" ([Census Bureau, undated](https://www.census.gov/programs-surveys/cbp/about.html)).  The Census Bureau further validates edits the CBP data for data quality and confidentiality.  For example, the Census Bureau suppresses data that would identify individual employers.  Additionally, the Census Bureau has used noise infusion since 2007 to further protect employer confidentiality.  The CBP data are tabulated by NAICS since 1998 and by SIC codes prior.  The data are available back to the 1970s; however, the data are less accessible prior to 1986.

To-Do:
- [ ] Add 1986-1999 data.

### Manifest
| File    | Description |
|-------- | ----------- |
| `../county-business/raw/cbp_2dig_2000_2017.zip` | Zip file of subset CBP data by 2-digit NAICS code.  Totals are included and coded `naics = 0`.
