| **COLUMN NAME** |                     **DESCRIPTION**                     |
|:----------------|:--------------------------------------------------------|
|CREATED_AT       |The date and time the transaction was started. *All the same so they could be batch imported* **CHECK THIS**    |
|UPDATED_AT|The date and time the record was last modified. Eg. payment status update or a return. **CHECK THIS**|
|STORE_NUMBER|The unique ID of the store the book was sold at.|
|STORE_NAME|The unique name of the store that the book was sold at. This also contains location information|
|AREA_NUMBER|Unique number corresponding to an area in the UK|
|AREA_NAME|Concatenation of AREA_NUMBER (17 -> A17) as a prefix, followed by the general location of the store.|
|ISBN|13-digit unique identifier for books.|
|AUTHOR|Name of author. (If this is a company then there is no comma)|
|TITLE|Title of book.|
|PUBLISHER|Publisher of book.|
|IMPRINT|Brand or division within the publishing house.|
|AVAILABILITY|Availability of the book.|
|RRP|Recommended Retail Price.|
|CORE_STOCK_FLAG|How important the book is to the store. **CHECK THIS**|
|PUBLICATION_DATE|Date the book was published.|
|PRODUCT_GROUP|General group of books the particular book falls under.|
|DEPARTMENT|Department that overarches the PRODUCT_GROUP.|
|SUB_DEPARTMENT|Sub department of the main department.|
|CLASS|Similar to PRODUCT_GROUP, DEPARTMENT and SUB_DEPARTMENT. **CHECK THIS AS NOT SURE WHICH ONE TO USE**|
|QTY_ON_HAND|Stock in the store.|
|QTY_ON_ORDER|Stock available to order.|
|QTY_RECEIVED|Stock which is received. **CHECK THIS WHAT DOES IT MEAN**|
|QTY_SOLD|Stock which has been sold.|
|HUB_QTY_ON_HAND|Total number of units of a book that are currently physically present and available in the central hub's inventory|
|HUB_QTY_ON_ORDER|Number of units that can be ordered from the central hub's inventory|


