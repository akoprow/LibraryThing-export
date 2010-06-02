<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:output method="xml" indent="yes" />

	<xsl:template match="*|@*">
		<xsl:copy>
			<xsl:apply-templates />
		</xsl:copy>
	</xsl:template>
	
	<xsl:template match="finished">
		<finished>
			<xsl:value-of select="substring(.,string-length(.)-3,4)" />
			<xsl:value-of select="replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(
				substring(.,1,3), 
				'Jan', '01'), 'Feb', '02'), 'Mar', '03'), 'Apr', '04'),	'May', '05'), 'Jun', '06'),
				'Jul', '07'), 'Aug', '08'), 'Sep', '09'), 'Oct', '10'), 'Nov', '11'), 'Dec', '12')" 
			/>
			<xsl:choose>
				<xsl:when test="substring(.,6,1) = ','">
					<xsl:text>0</xsl:text>
					<xsl:value-of select="substring(.,5,1)" />
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="substring(.,5,2)" />
				</xsl:otherwise>
			</xsl:choose>
		</finished>
	</xsl:template>
</xsl:stylesheet>