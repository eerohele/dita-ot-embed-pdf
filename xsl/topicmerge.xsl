<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="2.0"
  xmlns:local="urn:local-functions"
  xmlns:ot-placeholder="http://suite-sol.com/namespaces/ot-placeholder"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  exclude-result-prefixes="xs local">

  <xsl:import href="functions.xsl"/>

  <xsl:template priority="20" mode="build-tree"
    match="*[local:has-class(., 'map/topicref')][local:format-is-pdf(.)]">
    <!--
    Adding @class="- topic/topic " and generating the same ID for both
    ot-placeholder:pdf and the topicref that points to PDF file will make the
    default PDF2 stylesheets take the embedded PDF into account when creating
    the TOC.
    -->
    <ot-placeholder:pdf id="{generate-id()}" class="- topic/topic ">
      <xsl:apply-templates select="@href"/>
      <xsl:apply-templates select="." mode="navtitle"/>
    </ot-placeholder:pdf>
  </xsl:template>

  <xsl:template mode="navtitle"
    match="*[local:has-class(., 'map/topicref')][local:format-is-pdf(.)]">
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
    match="*[local:has-class(. ,'map/topicref')][local:format-is-pdf(.)]/@href">
    <xsl:sequence select="."/>
  </xsl:template>

  <xsl:template
    match="*[local:has-class(. ,'map/topicref')][local:format-is-pdf(.)]">
    <xsl:copy>
      <xsl:attribute name="id" select="generate-id()"/>

      <!--
      Add @locktitle="yes" to force DITA-OT to use the navtitle of the topicref.
      -->
      <xsl:attribute name="locktitle" select="'yes'"/>
      <xsl:apply-templates select="@* | node()"/>
    </xsl:copy>
  </xsl:template>

</xsl:stylesheet>
