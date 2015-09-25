<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="2.0"
  xmlns:local="urn:local-functions"
  xmlns:saxon="http://saxon.sf.net/"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  exclude-result-prefixes="local xs">

  <!--
  This is a copy of the opentopic-func:isAbsolute() function. See:

  https://github.com/jelovirt/dita-generator/commit/e4f5d6bb
  -->
  <xsl:function name="local:is-absolute" as="xs:boolean">
    <xsl:param name="uri" as="xs:anyURI"/>

    <xsl:sequence
      select="some $prefix in ('/', 'file:')
         satisfies starts-with($uri, $prefix)
                or contains($uri, '://')"/>
  </xsl:function>

  <xsl:function name="local:has-class" as="xs:boolean">
    <xsl:param name="el" as="element()"/>
    <xsl:param name="class" as="xs:string"/>

    <xsl:sequence select="tokenize($el/@class, '\s+') = $class"/>
  </xsl:function>

  <xsl:function name="local:resolve-href" as="xs:anyURI">
    <xsl:param name="href" as="attribute(href)"/>
    <xsl:param name="against" as="xs:string"/>

    <xsl:sequence
      select="if ($href/../@scope eq 'external' or local:is-absolute($href))
            then xs:anyURI($href)
            else resolve-uri($href, $against)"/>
  </xsl:function>

  <xsl:function name="local:in-toc" as="xs:boolean">
    <xsl:param name="el" as="element()"/>

    <xsl:sequence
      select="empty($el/@toc) or normalize-space($el/@toc) eq 'yes'"/>
  </xsl:function>

</xsl:stylesheet>
