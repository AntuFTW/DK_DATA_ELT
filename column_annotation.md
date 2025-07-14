| **COLUMN NAME** |                     **DESCRIPTION**                     |
|:----------------|:--------------------------------------------------------|
|CREATED_AT       |The date and time the data was processed *All the same so they could be batch imported*|
|UPDATED_AT|The date and time the record was last modified. Eg. payment status update or a return.|
|STORE_NUMBER|The unique ID of the store the book was sold at.|
|STORE_NAME|The unique name of the store that the book was sold at. This also contains location information|
|AREA_NUMBER|Unique number corresponding to an area in the UK|
|AREA_NAME|Concatenation of AREA_NUMBER (17 -> A17) as a prefix, followed by the general location of the store.|
|ISBN|13-digit unique identifier for books.|
|AUTHOR|Name of author, formatted as "Last name, first name" if its a human or just the company name if its a company.|
|TITLE|Title of book.|
|PUBLISHER|Publisher of book.|
|IMPRINT|A trade name under which a publisher issues a book. It can denote a specific brand of the publisher eg. DK Children|
|AVAILABILITY|Current stock status of a book from the publisher perspective where "In print" means the book is being actively printed and is available for order.|
|RRP|Recommended Retail Price.|
|CORE_STOCK_FLAG|Grades how important a book is to the store.|
|PUBLICATION_DATE|Date the book was published.|
|PRODUCT_GROUP|Broadest group of books the particular book falls under.|
|DEPARTMENT|Specific category within the PRODUCT_GROUP.|
|SUB_DEPARTMENT|Further refinement of Department (more granular).|
|CLASS|Most specific category of book, the most granular out of PRODUCT_GROUP, DEPARTMENT and SUB_DEPARTMENT.|
|QTY_ON_HAND|Copies of a book that are physically in stock at the specific store.|
|QTY_ON_ORDER|Number of copies of the book that the store has ordered from the central inventory hub but not received.|
|QTY_RECEIVED|Number of copies that the store has received from the central inventory hub|
|QTY_RETURNED|Number of copies that has been returned to the store.|
|QTY_SOLD|Number of copies of he book sold by the store within a specific reporting period.|
|HUB_QTY_ON_HAND|Total number of units of a book that are currently physically present and available in the central hub's inventor.|
|HUB_QTY_ON_ORDER|Number of units that have bee ordered from the central hub's inventory but have not been received.|


