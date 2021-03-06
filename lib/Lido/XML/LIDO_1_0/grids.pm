package Lido::XML::LIDO_1_0::grids;

use Moo;

our $VERSION = '0.05';

sub content {
	my @lines = <DATA>;
	join '' , @lines;
}

1;
__DATA__
<?xml version="1.0" encoding="UTF-8"?>
<schema targetNamespace="http://www.opengis.net/gml" xmlns:gml="http://www.opengis.net/gml" xmlns="http://www.w3.org/2001/XMLSchema" xmlns:xlink="http://www.w3.org/1999/xlink" elementFormDefault="qualified" version="3.1.1.2">
	<annotation>
		<appinfo source="urn:opengis:specification:gml:schema-xsd:grids:3.1.1">grids.xsd</appinfo>
		<documentation xml:lang="en">Grid geometries
    A subset of implicit geometries
    Designed for use with GML Coverage schema, but maybe useful elsewhere as well.
    
    GML is an OGC Standard.
    Copyright (c) 2001,2005,2010 Open Geospatial Consortium.
    To obtain additional rights of use, visit http://www.opengeospatial.org/legal/ .
		</documentation>
	</annotation>
	<!-- ==============================================================
       includes and imports
	============================================================== -->
	<include schemaLocation="gml.xsd"/>
	<include schemaLocation="geometryBasic0d1d.xsd"/>
	<!-- ==============================================================
       global elements
	============================================================== -->
	<element name="_ImplicitGeometry" type="gml:AbstractGeometryType" abstract="true" substitutionGroup="gml:_Geometry"/>
	<!-- =========================================================== -->
	<element name="Grid" type="gml:GridType" substitutionGroup="gml:_ImplicitGeometry"/>
	<!-- =========================================================== -->
	<complexType name="GridType">
		<annotation>
			<documentation>An unrectified grid, which is a network composed of two or more sets of equally spaced parallel lines in which the members of each set intersect the members of the other sets at right angles.</documentation>
		</annotation>
		<complexContent>
			<extension base="gml:AbstractGeometryType">
				<sequence>
					<element name="limits" type="gml:GridLimitsType"/>
					<element name="axisName" type="string" maxOccurs="unbounded"/>
				</sequence>
				<attribute name="dimension" type="positiveInteger" use="required"/>
			</extension>
		</complexContent>
	</complexType>
	<!-- =========================================================== -->
	<complexType name="GridLimitsType">
		<sequence>
			<element name="GridEnvelope" type="gml:GridEnvelopeType"/>
		</sequence>
	</complexType>
	<!-- =========================================================== -->
	<complexType name="GridEnvelopeType">
		<annotation>
			<documentation>Provides grid coordinate values for the diametrically opposed corners of an envelope that bounds a section of grid. The value of a single coordinate is the number of offsets from the origin of the grid in the direction of a specific axis.</documentation>
		</annotation>
		<sequence>
			<element name="low" type="gml:integerList"/>
			<element name="high" type="gml:integerList"/>
		</sequence>
	</complexType>
	<!-- =========================================================== -->
	<element name="RectifiedGrid" type="gml:RectifiedGridType" substitutionGroup="gml:_ImplicitGeometry">
		<annotation>
			<documentation>Should be substitutionGroup="gml:Grid" but changed in order to accomplish Xerces-J schema validation</documentation>
		</annotation>
	</element>
	<!-- =========================================================== -->
	<complexType name="RectifiedGridType">
		<annotation>
			<documentation>A rectified grid has an origin and vectors that define its post locations.</documentation>
		</annotation>
		<complexContent>
			<extension base="gml:GridType">
				<sequence>
					<element name="origin" type="gml:PointPropertyType"/>
					<element name="offsetVector" type="gml:VectorType" maxOccurs="unbounded"/>
				</sequence>
			</extension>
		</complexContent>
	</complexType>
	<!-- =========================================================== -->
</schema>
