<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xhtml="http://www.w3.org/1999/xhtml">

	<xsl:output method="xml" indent="yes"  />
    
    <xsl:template match="/">
    	<covers>
    		<xsl:apply-templates />
    	</covers>
    </xsl:template>
    
    <xsl:template match="node()">
    	<xsl:apply-templates />
    </xsl:template>
    
	<xsl:template match="//xhtml:div[@class='graphicalShelf']//xhtml:a">
		<cover>
		
		</cover>	
	</xsl:template>
 
<!-- 
	<xsl:template match="/">
		Howdie:
		<xsl:for-each select="//img">
			<xsl:value-of select="name()" />
			<xsl:text>
			</xsl:text>
		</xsl:for-each>
	</xsl:template>
-->
 	
<!-- <xsl:template match="div/@value[.='graphicalShelf']//a"> -->
	
</xsl:stylesheet>
