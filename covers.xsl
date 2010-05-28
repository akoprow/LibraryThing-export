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
			<xsl:attribute name="id">
				<xsl:value-of select="substring-after(@href, '/work/book/')" />
			</xsl:attribute>
			<xsl:value-of select="xhtml:img/@src" /> 
		</cover>	
	</xsl:template>

</xsl:stylesheet>
