package Lido::XML::LIDO_1_0::temporalTopology;

use Moo;

our $VERSION = '0.05';

sub content {
	my @lines = <DATA>;
	join '' , @lines;
}

1;
__DATA__
<?xml version="1.0" encoding="UTF-8"?>
<schema targetNamespace="http://www.opengis.net/gml" xmlns="http://www.w3.org/2001/XMLSchema" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:gml="http://www.opengis.net/gml" elementFormDefault="qualified" version="3.1.1.2">
	<annotation>
		<appinfo source="urn:opengis:specification:gml:schema-xsd:temporalTopology:3.1.1"/>
		<documentation xml:lang="en">The temporal topology schema for ISO19136 provides constructs for handling topological complexes and 
		temporal feature relationships. 
		Temporal geometric characteristics of features are represented as instants and periods. 
		While, temporal context of features that does not relate to the position of time is described as connectivity relationships 
		among instants and periods. These relationships are called temporal topology as they do not change in time, 
		as long as the direction of time does not change. 
		It is used effectively in the case of describing a family tree expressing evolution of species, an ecological cycle, 
		a lineage of lands or buildings, or a history of separation and merger of administrative boundaries.
		This schema reflects a partial yet consistent implementation of the model described in ISO 19108:2002.
		
		GML is an OGC Standard.
		Copyright (c) 2001,2005,2010 Open Geospatial Consortium.
		To obtain additional rights of use, visit http://www.opengeospatial.org/legal/ .
		</documentation>
	</annotation>
	<!-- ===================================== -->
	<include schemaLocation="gml.xsd"/>
	<include schemaLocation="temporal.xsd"/>
	<!-- ===================================== -->
	<!-- ================================================================== -->
	<!-- == TimeTopologyComplex == -->
	<!-- ================================================================== -->
	<element name="TimeTopologyComplex" type="gml:TimeTopologyComplexType" substitutionGroup="gml:_TimeComplex">
		<annotation>
			<documentation xml:lang="en">This element represents temporal topology complex. It shall be the connected acyclic directed graph composed of time nodes and time edges.</documentation>
		</annotation>
	</element>
	<!-- ================================================================== -->
	<complexType name="TimeTopologyComplexType">
		<annotation>
			<documentation xml:lang="en">A temporal topology complex.</documentation>
		</annotation>
		<complexContent>
			<extension base="gml:AbstractTimeComplexType">
				<sequence>
					<element name="primitive" type="gml:TimeTopologyPrimitivePropertyType" maxOccurs="unbounded"/>
				</sequence>
			</extension>
		</complexContent>
	</complexType>
	<!-- ================================================================== -->
	<complexType name="TimeTopologyComplexPropertyType">
		<annotation>
			<documentation>A time topology complex property can either be any time topology complex element
			 encapsulated in an element of this type or an XLink reference to a remote time topology complex element 
			 (where remote includes elements located elsewhere in the same document). 
			 Note that either the reference or the contained element must be given, but not both or none.</documentation>
		</annotation>
		<sequence minOccurs="0">
			<element ref="gml:TimeTopologyComplex"/>
		</sequence>
		<attributeGroup ref="gml:AssociationAttributeGroup"/>
	</complexType>
	<!-- ================================================================== -->
	<!--  == TimeTopologyPrimitive == -->
	<!-- ================================================================== -->
	<element name="_TimeTopologyPrimitive" type="gml:AbstractTimeTopologyPrimitiveType" abstract="true" substitutionGroup="gml:_TimePrimitive">
		<annotation>
			<documentation xml:lang="en">This abstract element acts as the head of the substitution group for temporal topology primitives.</documentation>
		</annotation>
	</element>
	<!-- ================================================================== -->
	<complexType name="AbstractTimeTopologyPrimitiveType" abstract="true">
		<annotation>
			<documentation xml:lang="en">The element "complex" carries a reference to the complex containing this primitive.</documentation>
		</annotation>
		<complexContent>
			<extension base="gml:AbstractTimePrimitiveType">
				<sequence>
					<element name="complex" type="gml:ReferenceType" minOccurs="0"/>
				</sequence>
			</extension>
		</complexContent>
	</complexType>
	<!-- ================================================================== -->
	<complexType name="TimeTopologyPrimitivePropertyType">
		<annotation>
			<documentation>A time topology primitive property can either hold any time topology complex element
			 eor carry an XLink reference to a remote time topology complex element 
			 (where remote includes elements located elsewhere in the same document). 
			 Note that either the reference or the contained element must be given, but not both or none.</documentation>
		</annotation>
		<sequence minOccurs="0">
			<element ref="gml:_TimeTopologyPrimitive"/>
		</sequence>
		<attributeGroup ref="gml:AssociationAttributeGroup"/>
	</complexType>
	<!-- ================================================================== -->
	<!--  ======= TimeNode ======= -->
	<!-- ================================================================== -->
	<element name="TimeNode" type="gml:TimeNodeType" substitutionGroup="gml:_TimeTopologyPrimitive">
		<annotation>
			<documentation xml:lang="en">"TimeNode" is a zero dimensional temporal topology primitive, 
			expresses a position in topological time, and is a start and an end of time edge, which represents states of time.
			Time node may be isolated. However, it cannot describe the ordering relationships with other primitives. 
			An isolated node may not be an element of any temporal topology complex.</documentation>
		</annotation>
	</element>
	<!-- ================================================================== -->
	<complexType name="TimeNodeType">
		<annotation>
			<documentation xml:lang="en">Type declaration of the element "TimeNode".</documentation>
		</annotation>
		<complexContent>
			<extension base="gml:AbstractTimeTopologyPrimitiveType">
				<sequence>
					<element name="previousEdge" type="gml:TimeEdgePropertyType" minOccurs="0" maxOccurs="unbounded"/>
					<element name="nextEdge" type="gml:TimeEdgePropertyType" minOccurs="0" maxOccurs="unbounded"/>
					<element name="position" type="gml:TimeInstantPropertyType" minOccurs="0"/>
				</sequence>
			</extension>
		</complexContent>
	</complexType>
	<!-- ================================================================== -->
	<complexType name="TimeNodePropertyType">
		<annotation>
			<documentation>A time node property can either be any time node element encapsulated in an element of this type 
			or an XLink reference to a remote time node element (where remote includes elements located elsewhere in the same document). 
			Note that either the reference or the contained element must be given, but not both or none.</documentation>
		</annotation>
		<sequence minOccurs="0">
			<element ref="gml:TimeNode"/>
		</sequence>
		<attributeGroup ref="gml:AssociationAttributeGroup"/>
	</complexType>
	<!-- ================================================================== -->
	<!--  ======= TimeEdge ======= -->
	<!-- ================================================================== -->
	<element name="TimeEdge" type="gml:TimeEdgeType" substitutionGroup="gml:_TimeTopologyPrimitive">
		<annotation>
			<documentation xml:lang="en">TimeEdge is one dimensional temporal topology primitive,
			 expresses a state in topological time. It has an orientation from its start toward the end, 
			 and its boundaries shall associate with two different time nodes.</documentation>
		</annotation>
	</element>
	<!-- ================================================================== -->
	<complexType name="TimeEdgeType">
		<annotation>
			<documentation xml:lang="en">Type declaration of the element "TimeEdge".</documentation>
		</annotation>
		<complexContent>
			<extension base="gml:AbstractTimeTopologyPrimitiveType">
				<sequence>
					<element name="start" type="gml:TimeNodePropertyType"/>
					<element name="end" type="gml:TimeNodePropertyType"/>
					<element name="extent" type="gml:TimePeriodPropertyType" minOccurs="0"/>
				</sequence>
			</extension>
		</complexContent>
	</complexType>
	<!-- ================================================================== -->
	<complexType name="TimeEdgePropertyType">
		<annotation>
			<documentation>A time edge property can either be any time edge element encapsulated in an element of this type 
			or an XLink reference to a remote time edge element (where remote includes elements located elsewhere in the same document). 
			Note that either the reference or the contained element must be given, but not both or none.</documentation>
		</annotation>
		<sequence minOccurs="0">
			<element ref="gml:TimeEdge"/>
		</sequence>
		<attributeGroup ref="gml:AssociationAttributeGroup"/>
	</complexType>
	<!-- ================================================================== -->
	<!-- ===       Succession        === -->
	<!-- ================================================================== -->
	<simpleType name="SuccessionType">
		<annotation>
			<documentation>Feature succession is a semantic relationship derived from evaluation of observer, and 
			Feature Substitution, Feature Division and Feature Fusion are defined as associations between 
			previous features and next features in the temporal context. 
			Successions shall be represented in either following two ways. 
			* define a temporal topological complex element as a feature element 
			* define an association same as temporal topological complex between features.</documentation>
		</annotation>
		<restriction base="string">
			<enumeration value="substitution"/>
			<enumeration value="division"/>
			<enumeration value="fusion"/>
			<enumeration value="initiation"/>
		</restriction>
	</simpleType>
	<!-- ================================================================== -->
</schema>
