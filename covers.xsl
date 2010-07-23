<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xhtml="http://www.w3.org/1999/xhtml">

	<xsl:output method="text" indent="yes"  />
    
    <xsl:template match="/">
    	<covers>
    		<xsl:apply-templates />
    	</covers>
    </xsl:template>
    
    <xsl:template match="node()">
    	<xsl:apply-templates />
    </xsl:template>
    
	<xsl:template match="//xhtml:div[@class='graphicalShelf']//xhtml:a">
		<xsl:value-of select="substring-after(@href, '/work/book/')" />
		<xsl:text>;</xsl:text>
		<xsl:value-of select="xhtml:img/@src" /> 
		<xsl:text>&#10;</xsl:text>
	</xsl:template>

</xsl:stylesheet>
