# Spatial database geometry and function

In the previous laboratory, we learned how create database with spetial extension and how loaded shape data to this database. To bater understending how spetial database create and storige graphical infromation lets have a look at some simpler examples. 

## Create table with geometry columns 

The PostGis support two standard ways of expressing spatial objects: 
	- the Well-Known Text (WKT) form 
	- the Well-Known Binary (WKB) form. 
	
Both WKT and WKB include information about the type of the object and the coordinates which form the object.

Examples of the selected text representations of the spatial objects (WKT ) of the features are as follows:

	- POINT(0 0) - describe point in 2D space
 
	- POINT Z (0 0 0) - describe point in 3D space

	- POINT ZM (0 0 0 0) - describe point in 4D space

	- LINESTRING(0 0,1 1,1 2) - describe line in 2D space

	- POLYGON((0 0,4 0,4 4,0 4,0 0),(1 1, 2 1, 2 2, 1 2,1 1)) - describe poligon in 2D

	- MULTIPOINT((0 0),(1 2)) - describe set of points in 2D space

	- MULTIPOINT Z ((0 0 0),(1 2 3)) - describe set of points in 3D space

	- MULTILINESTRING((0 0,1 1,1 2),(2 3,3 2,5 4)) - describe set of lines in 2D space

	- MULTIPOLYGON(((0 0,4 0,4 4,0 4,0 0),(1 1,2 1,2 2,1 2,1 1)), ((-1 -1,-1 -2,-2 -2,-2 -1,-1 -1))) - describe set of polygons in 2D space

	- GEOMETRYCOLLECTION(POINT(2 3),LINESTRING(2 3,3 4)) - describe set of geometry object

In practice we can use this information to create simply table with geometry columns:
	
1. In pgAdmin, open database **lab10_nyc** and run SQL Editor.	
2. Create table geom_example:
```sql 
CREATE TABLE geom_example (object_name varchar, geom geometry);
```
3. Because the creation of geometric objects is done by giving the constructor in text form. The commands for adding objects to table will take the form:
```sql
INSERT INTO geom_example VALUES
	('Point', 'POINT(0 0)'),
	('Linestring', 'LINESTRING(0 0, 1 1, 2 1, 2 2)'),
	('Polygon', 'POLYGON((0 0, 1 0, 1 1, 0 1, 0 0))'),
	('PolygonWithHole', 'POLYGON((0 0, 10 0, 10 10, 0 10, 0 0),(1 1, 1 2, 2 2, 2 1, 1 1))'),
	('Collection', 'GEOMETRYCOLLECTION(POINT(2 0),POLYGON((0 0, 1 0, 1 1, 0 1, 0 0)))');
```

4. To check the definition of graphical objects in the database, we can use the function *ST_AsText*:
```sql
SELECT object_name, ST_AsText(geom) FROM geom_example;
```
	
## Spatial function
Using geometric objects in the spatial database is done by manipulating them with the functions built into the database. We should remember that with  PostGIS all functions assume the geometric type, but their operation differs depending on the represented object. Of course, this principle does not apply to other database engines of this type.

In this section, selected functions will be discussed along with their subcategories.

### Input/Output data 
- **ST_GeomFromText(text)** - returns geometry,
- **ST_AsText(geometry)** - returns WKT text,
- **ST_AsEWKT(geometry)** - returns EWKT text,
- **ST_GeomFromWKB(bytea)** - returns geometry,
- **ST_AsBinary(geometry)** - returns WKB bytea,
- **ST_AsEWKB(geometry)** - returns EWKB bytea,
- **ST_GeomFromGML(text)** - returns geometry,
- **ST_AsGML(geometry)** - returns GML text,
- **ST_GeomFromKML(text)** - returns geometry,
- **ST_AsKML(geometry)** - returns KML text,
- **ST_AsGeoJSON(geometry)** - returns JSON text,
- **ST_AsSVG(geometry)** - returns SVG text,

### Data type exploration

- **ST_GeometryType(geometry)** -  returns the type of the geometry,
- **ST_NDims(geometry)** - returns the number of dimensions of the geometry,
- **ST_NumGeometries(geometry)** - returns the number of parts in the collection,
- **ST_GeometryN(geometry,int)** - returns the specified part of the collection,
- **ST_NumGeometries(multi/geomcollection)** - returns the number of parts in the collection

### Geometry description
- **ST_X(geometry)** - returns the X coordinate of point,
- **ST_Y(geometry)** - returns the Y coordinate of point,
- **ST_StartPoint(geometry)** - returns the first line string coordinate as a point,
- **ST_EndPoint(geometry)** - returns the last line string coordinate as a point,
- **ST_NPoints(geometry)** - returns the number of coordinates in the line string,
- **ST_Length(geometry)** - returns the total length of all linear parts,
- **ST_Area(geometry)** - returns the total area of all polygonal parts,
- **ST_NRings(geometry)** - returns the number of rings (usually 1, more if there are holes) of polygonal,
- **ST_ExteriorRing(geometry)** - returns the outer ring as a line string of polygonal,
- **ST_InteriorRingN(geometry,n)** - returns a specified interior ring as a line string of polygonal,
- **ST_Perimeter(geometry)** - returns the length of all the rings of polygonal,

### Geometry relation
- **ST_Contains(geometry A, geometry B)** - returns true if geometry A contains geometry B
- **ST_Crosses(geometry A, geometry B)** - returns true if geometry A crosses geometry B
- **ST_Disjoint(geometry A , geometry B)** - returns true if the geometries do not “spatially intersect”
- **ST_Distance(geometry A, geometry B)** - returns the minimum distance between geometry A and geometry B
- **ST_DWithin(geometry A, geometry B, radius)** - returns true if geometry A is radius distance or less from geometry B
- **ST_Equals(geometry A, geometry B)** - returns true if geometry A is the same as geometry B
- **ST_Intersects(geometry A, geometry B)** - returns true if geometry A intersects geometry B
- **ST_Overlaps(geometry A, geometry B)** - returns true if geometry A and geometry B share space, but are not completely contained by each other.
- **ST_Touches(geometry A, geometry B)** - returns true if the boundary of geometry A touches geometry B
- **ST_Within(geometry A, geometry B)** - returns true if geometry A is within geometry B

## Exercises:
1. What is the area of the: West Village, Harlem, Great Kills neighborhood?
2. Find all neighborhoods bordering on: Rossville, Queens Village and Midtown
3. What is the area of: Staten Island, Manhattan, Brooklyn?
4. How many census blocks in New York City have a hole in them?
5. What is the summary area of 'a hole' of census blocks in New York City?
6. What is the length of streets in New York City, summarized by type?
7. What streets crossing  with: Pacific St, E 9th St, Avenue K?
8. Find ten closest stations from: Elder Ave, Castle Hill Ave, 4th Ave.



