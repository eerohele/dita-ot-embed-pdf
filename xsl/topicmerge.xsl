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

  <!--
  Both FOP and Antenna House support embedding PDFs with URI references like
  this:

    href="file.pdf#page=2"

  By default, DITA-OT interprets @href values like this as pointing to a topic
  within the referenced file. Therefore, without any modification, in the merged
  file, topicmergeImpl.xsl would generate a topicref like this:

    <topicref href="file.pdf" id="page-2" ... />

  This is not meaningful in this case, however — we just want to pass the @href
  through without generating an @id attribute.
  -->
  <xsl:template
    match="*[local:has-class(. ,'map/topicref')][@format eq 'pdf']/@href">
    <xsl:sequence select="."/>
  </xsl:template>

</xsl:stylesheet>
