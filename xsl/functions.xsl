<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="2.0"
  xmlns:dita-ot="http://dita-ot.sourceforge.net/ns/201007/dita-ot"
  xmlns:opentopic-func="http://www.idiominc.com/opentopic/exsl/function"
  xmlns:saxon="http://saxon.sf.net/"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  exclude-result-prefixes="opentopic-func xs">

  <xsl:function name="opentopic-func:isAbsolute" as="xs:boolean">
    <xsl:param name="uri" as="xs:anyURI"/>

    <xsl:sequence
      select="some $prefix in ('/', 'file:')
         satisfies starts-with($uri, $prefix)
                or contains($uri, '://')"/>
  </xsl:function>

  <xsl:function name="dita-ot:has-class" as="xs:boolean"
    saxon:memo-function="yes">
    <xsl:param name="el" as="element()"/>
    <xsl:param name="class" as="xs:string"/>

    <xsl:sequence select="tokenize($el/@class, '\s+') = $class"/>
  </xsl:function>

  <xsl:function name="dita-ot:resolve-href" as="xs:anyURI">
    <xsl:param name="href" as="attribute(href)"/>
    <xsl:param name="against" as="xs:string">

    </xsl:param>

    <xsl:sequence
      select="if ($href/../@scope eq 'external'
               or opentopic-func:isAbsolute($href))
            then xs:anyURI($href)
            else resolve-uri($href, $against)"/>
  </xsl:function>

</xsl:stylesheet>
