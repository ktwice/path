<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="xml" indent="yes"/>

<xsl:template match="/">
  <xsl:element name="path">
   <xsl:attribute name="file" select="document-uri(/)"/>
   <xsl:comment>
 e - element
 @p - path
 @n - count of entries
 @t - count of normalized text (distinct/not-empty)
 t - not-empty text example
 a - not-empty attribute example
   </xsl:comment>	
   <xsl:comment> 1. Elements tree.</xsl:comment>
   <xsl:for-each-group select="//*"
 group-by="string-join((for $x in (ancestor::*) return name($x),name()),'/')">
    <xsl:sort select="current-grouping-key()"/>
    <xsl:variable name="p" select="concat('/',current-grouping-key())"/>
    <xsl:variable name="text" select="
for $x in current-group() 
return normalize-space(string-join($x/text(),' '))[. ne '']
    "/>
<e>
 <xsl:attribute name="p" select="$p"/>
 <xsl:attribute name="n" select="count(current-group())"/>
 <xsl:if test="exists($text)">
<t>
 <xsl:attribute name="t" select="concat(count(distinct-values($text)),'/',count($text))"/>
 <xsl:value-of select="$text[1]"/>
</t>
 </xsl:if>
    <xsl:for-each-group select="current-group()/@*" group-by="name()">
     <xsl:sort select="current-grouping-key()"/>
     <xsl:variable name="text" select="
for $x in current-group() 
return normalize-space($x)[. ne '']
     "/>
<a>
 <xsl:attribute name="p" select="concat($p,'/@',current-grouping-key())"/>
 <xsl:attribute name="n" select="count(current-group())"/>
 <xsl:attribute name="t" select="concat(count(distinct-values($text)),'/',count($text))"/>
 <xsl:value-of select="$text[1]"/>
</a>
    </xsl:for-each-group >

</e>
   </xsl:for-each-group>
   
    <xsl:comment> 2. Elements names.</xsl:comment>
   <xsl:for-each-group select="//*" group-by="name()">
    <xsl:sort select="current-grouping-key()"/>
    <xsl:variable name="text" select="
for $x in current-group() 
return normalize-space(string-join($x/text(),' '))[. ne '']
    "/>
<e>
 <xsl:attribute name="p" select="concat('//',current-grouping-key())"/>
 <xsl:attribute name="n" select="count(current-group())"/>
 <xsl:if test="exists($text)">
  <xsl:attribute name="t" select="concat(count(distinct-values($text)),'/',count($text))"/>
 </xsl:if>
</e>
   </xsl:for-each-group>
   
    <xsl:comment> 3. Attributes names.</xsl:comment>
   <xsl:for-each-group select="//@*" group-by="name()">
    <xsl:sort select="current-grouping-key()"/>
    <xsl:variable name="text" select="
for $x in current-group() 
return normalize-space($x)[. ne '']
    "/>
<a>
 <xsl:attribute name="p" select="concat('//@',current-grouping-key())"/>
 <xsl:attribute name="n" select="count(current-group())"/>
 <xsl:attribute name="t" select="concat(count(distinct-values($text)),'/',count($text))"/>
</a>
   </xsl:for-each-group >

  </xsl:element>
</xsl:template>

</xsl:stylesheet>
