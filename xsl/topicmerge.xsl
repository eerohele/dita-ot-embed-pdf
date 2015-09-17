<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="2.0"
  xmlns:local="urn:local-functions"
  xmlns:ot-placeholder="http://suite-sol.com/namespaces/ot-placeholder"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  exclude-result-prefixes="xs local">

  <xsl:import href="functions.xsl"/>

  <xsl:template priority="20" mode="build-tree"
    match="*[local:has-class(., 'map/topicref')][@format eq 'pdf']">
    <ot-placeholder:pdf href="{@href}">
      <xsl:apply-templates select="." mode="navtitle"/>
    </ot-placeholder:pdf>
  </xsl:template>

  <xsl:template mode="navtitle"
    match="*[local:has-class(., 'map/topicref')][@format eq 'pdf']">
    <xsl:attribute name="navtitle">
      <xsl:apply-templates
        select="(*[local:has-class(., 'map/topicmeta')]
                /*[local:has-class(., 'topic/navtitle')], @navtitle)[1]"/>
    </xsl:attribute>
  </xsl:template>

</xsl:stylesheet>
